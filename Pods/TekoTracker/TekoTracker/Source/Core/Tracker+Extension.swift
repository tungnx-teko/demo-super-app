//
//  Tracker+Extension.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 6/19/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit

extension Tracker {
    func initialize() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }

    @objc func applicationDidBecomeActive() {
        controller.start()
    }

    @objc func applicationWillEnterForeground() {
        controller.start()
    }

    @objc func applicationDidEnterBackground() {
        
    }

    @objc func applicationWillResignActive() {
        controller.pause()
    }

    @objc func applicationWillTerminate() {
        controller.stop()
    }
}
