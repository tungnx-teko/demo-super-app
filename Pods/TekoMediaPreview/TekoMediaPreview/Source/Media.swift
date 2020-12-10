//
//  Media.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/8/20.
//

import Photos
import AVFoundation

public protocol MediaItemDelegate: class {
    func mediaItem(_ item: MediaItem, didLoadOrigin image: UIImage?)
    func mediaItem(_ item: MediaItem, didLoadThumbnail image: UIImage?)
    func mediaItem(_ item: MediaItem, didLoadAVAsset avAsset: AVAsset?)
}

public class MediaItem {
    let id: String
    let url: URL?
    let asset: PHAsset?
    var avAsset: AVAsset?
    let type: Type
    var thumbnail: UIImage?
    var originImage: UIImage?

    private var observers: [String: WeakDelegate] = [:]

    public init(url: URL?, type: Type) {
        self.id = UUID().uuidString
        self.url = url
        self.type = type
        self.asset = nil
        self.avAsset = nil
    }

    public init?(asset: PHAsset)  {
        self.id = UUID().uuidString
        switch asset.mediaType {
        case .image:
            self.type = .image
        case .video:
            self.type = .video
        default:
            return nil
        }
        self.url = nil
        self.asset = asset
        self.requestResource(asset: asset)
    }

    public func setDelegate(_ delegate: MediaItemDelegate?) {
        guard let delegate = delegate else { return }
        observers[String(describing: Swift.type(of: delegate))] = WeakDelegate(value: delegate)
    }

}

extension MediaItem {
    public enum `Type` {
        case image
        case video
    }
}

private extension MediaItem {
    struct WeakDelegate {
        weak var value: MediaItemDelegate?

        init(value: MediaItemDelegate?) {
            self.value = value
        }
    }

    func requestResource(asset: PHAsset) {
        PHImageManager.default().requestImage(
            for: asset,
            targetSize: .init(width: 50, height: 50),
            contentMode: .aspectFit,
            options: {
                let options = PHImageRequestOptions()
                options.isNetworkAccessAllowed = true
                options.deliveryMode = .fastFormat
                return options
            }()
        ) {
            image, _ in
            self.thumbnail = image
            self.observers.values.forEach { $0.value?.mediaItem(self, didLoadThumbnail: image) }
        }

        PHImageManager.default().requestImage(
            for: asset,
            targetSize: PHImageManagerMaximumSize,
            contentMode: .aspectFit,
            options: {
                let options = PHImageRequestOptions()
                options.isNetworkAccessAllowed = true
                options.deliveryMode = .highQualityFormat
                return options
            }()
        ) {
            image, _ in
            self.originImage = image
            self.observers.values.forEach { $0.value?.mediaItem(self, didLoadOrigin: image) }
        }

        PHImageManager.default().requestAVAsset(
            forVideo: asset,
            options: {
                let options = PHVideoRequestOptions()
                options.isNetworkAccessAllowed = true
                options.deliveryMode = .automatic
                return options
            }()
        ) {
            avAsset, _, _ in
            self.avAsset = avAsset
            self.observers.values.forEach { $0.value?.mediaItem(self, didLoadAVAsset: avAsset) }
        }
    }
}
