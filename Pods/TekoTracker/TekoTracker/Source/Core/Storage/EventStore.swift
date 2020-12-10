//
//  EventStore.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/18/19.
//

import CoreData
import RxSwift

protocol EventDataStoreProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
    func save<T>(_ eventRequest: T, status: Constant.UploadStatus) where T: BaseRequestModel
    func save<C>(_ eventRequests: C, status: Constant.UploadStatus) where C: Collection, C.Element: BaseRequestModel
    func updateUploadStatus<T>(class: T.Type, ids: [String], status: Constant.UploadStatus) where T: BaseRequestModel
    func getEventRequests<T>(class: T.Type, statuses: [Constant.UploadStatus], count: Int, page: Int) -> Observable<[T]> where T: BaseRequestModel
    func updateCreatedTime(distanceToServerTime: TimeInterval)
}

extension EventDataStoreProtocol {
    func save<T>(_ eventRequest: T, status: Constant.UploadStatus) where T: BaseRequestModel {
        let eventRequests: Set<T> = .init(arrayLiteral: eventRequest)
        save(eventRequests, status: status)
    }

    func getEventRequests<T>(class: T.Type, statuses: [Constant.UploadStatus], page: Int) -> Observable<[T]> where T: BaseRequestModel {
        getEventRequests(class: `class`, statuses: statuses, count: Constant.eventUploadBatchSize, page: page)
    }
}

final class EventDataStore: EventDataStoreProtocol {
    var _backManagedObjectContext: NSManagedObjectContext?
    let _mainManagedObjectContext: NSManagedObjectContext
    let _persistentStoreCoordinator: NSPersistentStoreCoordinator
    let logDebug: Bool

    convenience init(logDebug: Bool) throws {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]

        let persistentStoreCoordinator: NSPersistentStoreCoordinator = try {
            guard var modelURL = Bundle(for: EventDataStore.self).url(forResource: "Model", withExtension: "momd") else {
                throw NSError(domain: "EventStore", code: -999, userInfo: [
                    NSLocalizedDescriptionKey: "Cannot find Model.momd"
                ])
            }

            // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
            let mom: NSManagedObjectModel?
            if #available(iOS 13.0, *) {
                mom = NSManagedObjectModel(contentsOf: modelURL)
            } else {
                let versionInfoURL = modelURL.appendingPathComponent("VersionInfo.plist")
                if let versionInfoNSDictionary = NSDictionary(contentsOf: versionInfoURL),
                    let version = versionInfoNSDictionary.object(forKey: "NSManagedObjectModel_CurrentVersionName") as? String {
                    modelURL.appendPathComponent("\(version).mom")
                    mom = NSManagedObjectModel(contentsOf: modelURL)
                } else {
                    mom = NSManagedObjectModel(contentsOf: modelURL)
                }
            }

            guard let _mom = mom else {
                throw NSError(domain: "EventStore", code: -999, userInfo: [
                    NSLocalizedDescriptionKey: "Failed to initialize NSManagedObjectModel"
                ])
            }

            let psc = NSPersistentStoreCoordinator(managedObjectModel: _mom)
            let storeURL = docURL.appendingPathComponent("event.sqlite")
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options:
                [
                    NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true
                ])

            return psc
        }()
        self.init(persistentStoreCoordinator: persistentStoreCoordinator, logDebug: logDebug)
    }

    // Unit testing
    init(persistentStoreCoordinator: NSPersistentStoreCoordinator, logDebug: Bool) {
        self._persistentStoreCoordinator = persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        self._mainManagedObjectContext = managedObjectContext
        self.logDebug = logDebug

        #if !RELEASE || !PRODUCTION
        if logDebug {
            print("TekoTracker => Initialize store successfully")
        }
        #endif
    }

    var managedObjectContext: NSManagedObjectContext {
        if Thread.isMainThread {
            return _mainManagedObjectContext
        }
        if let context = _backManagedObjectContext {
            return context
        }
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = _mainManagedObjectContext
        self._backManagedObjectContext = context
        return context
    }

    func save<C>(_ eventRequests: C, status: Constant.UploadStatus) where C : Collection, C.Element : BaseRequestModel {
        self._mainManagedObjectContext.perform {
            [weak self] in
            guard let self = self else { return }
            do {
                eventRequests.forEach { $0.uploadStatus = status.rawValue }
                eventRequests.forEach {
                    $0.events.forEach(self.managedObjectContext.insert)
                    self.managedObjectContext.insert($0.session)
                    self.managedObjectContext.insert($0.visitor)
                    self.managedObjectContext.insert($0.networkInfo)
                    self.managedObjectContext.insert($0)
                }
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }

                let fetchRequest = NSFetchRequest<C.Element>(entityName: String(describing: C.Element.self))
                let count = try self.managedObjectContext.count(for: fetchRequest)
                if count > Constant.maxEventDatabaseCapacity {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: C.Element.self))
                    let uploadStatusKeyPathString = C.Element.uploadStatusKeyPathString
                    let eventCreatedAtKeyPathString = C.Element.eventCreatedAtKeyPathString
                    fetchRequest.predicate = .init(format: "%K == %d OR %K == %d",
                                                   uploadStatusKeyPathString, Constant.UploadStatus.completed.rawValue,
                                                   uploadStatusKeyPathString, Constant.UploadStatus.never.rawValue)
                    fetchRequest.sortDescriptors = [.init(key: eventCreatedAtKeyPathString, ascending: true)]
                    fetchRequest.fetchBatchSize = Constant.eventDeleteBatchSize
                    try self.managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: fetchRequest))
                }
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }
            }
            catch {
                #if !RELEASE || !PRODUCTION
                if self.logDebug {
                    print("TekoTracker => Failed to save", error)
                }
                #endif
            }
        }
    }

    func updateUploadStatus<T>(class: T.Type, ids: [String], status: Constant.UploadStatus) where T: BaseRequestModel {
        self._mainManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<T>(entityName: String(describing: `class`))
                fetchRequest.predicate = .init(format: "%K IN %@", T.idKeyPathString, ids)
                let results = try self.managedObjectContext.fetch(fetchRequest)
                for r in results {
                    guard r.uploadStatus != status.rawValue else { continue }
                    r.uploadStatus = status.rawValue
                }
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }
            } catch {
                #if !RELEASE || !PRODUCTION
                if self.logDebug {
                    print("TekoTracker => Failed to update", error)
                }
                #endif
            }
        }
    }

    func getEventRequests<T>(class: T.Type, statuses: [Constant.UploadStatus], count: Int, page: Int) -> Observable<[T]> where T: BaseRequestModel {
        Observable.create {
            subscriber in
            self._mainManagedObjectContext.perform {
                do {
                    let fetchRequest = NSFetchRequest<T>(entityName: String(describing: `class`))
                    if statuses.count == 1 {
                        fetchRequest.predicate = .init(format: "%K == %d", T.uploadStatusKeyPathString, statuses[0].rawValue)
                    } else {
                        fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: statuses.map {
                            status in .init(format: "%K == %d", T.uploadStatusKeyPathString, status.rawValue)
                        })
                    }
                    fetchRequest.fetchLimit = count
                    fetchRequest.fetchOffset = page * count
                    subscriber.onNext(try self.managedObjectContext.fetch(fetchRequest))
                    subscriber.onCompleted()
                } catch {
                    subscriber.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    func updateCreatedTime(distanceToServerTime: TimeInterval) {
        self._mainManagedObjectContext.perform {
            [weak self] in
            guard let self = self else { return }
            do {
                try self._updateCreateTimeWithoutSaving(class: SingleEventRequestModel.self, distanceToServerTime: distanceToServerTime)
                try self._updateCreateTimeWithoutSaving(class: MultiEventRequestModel.self, distanceToServerTime: distanceToServerTime)
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }
            } catch {
                #if !RELEASE || !PRODUCTION
                if self.logDebug {
                    print("TekoTracker => Failed to update", error)
                }
                #endif
            }
        }
    }

    private func _updateCreateTimeWithoutSaving<T>(class: T.Type, distanceToServerTime: TimeInterval) throws where T: BaseRequestModel {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: `class`))
        fetchRequest.predicate = .init(format: "%K == %d", T.uploadStatusKeyPathString, Constant.UploadStatus.needToSyncTime.rawValue)
        let results = try self.managedObjectContext.fetch(fetchRequest)
        for r in results {
            r.events.forEach {
                $0.createdAt += distanceToServerTime
            }
            r.uploadStatus = Constant.UploadStatus.ready.rawValue
        }
    }
}
