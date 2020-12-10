//
//  ImageViewController.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/8/20.
//

import UIKit
import Kingfisher
import AVFoundation

class ImageViewController: MediaViewController {

    lazy var imageView = createImageView()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .clear
        view.addSubview(imageView)
        didSetItem()
    }

    override func setItem(_ item: MediaItem) {
        super.setItem(item)
        didSetItem()
    }

}

extension ImageViewController: MediaItemDelegate {
    func mediaItem(_ item: MediaItem, didLoadThumbnail image: UIImage?) {}

    func mediaItem(_ item: MediaItem, didLoadOrigin image: UIImage?) {
        guard item.id == self.item.id else { return }
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    func mediaItem(_ item: MediaItem, didLoadAVAsset avAsset: AVAsset?) {}
}

private extension ImageViewController {

    func didSetItem() {
        item.setDelegate(self)
        if item.asset != nil {
            imageView.image = item.originImage ?? MediaPreview.config.placeholderImage
        } else {
            imageView.kf.setImage(with: item.url, placeholder: MediaPreview.config.placeholderImage)
        }
    }

    func createImageView() -> ZoomableImageView {
        let view = ZoomableImageView(frame: self.view.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentMode = .scaleAspectFit
        return view
    }

}
