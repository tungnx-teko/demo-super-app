//
//  MediaItemViewCell.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/8/20.
//

import UIKit
import Kingfisher
import AVFoundation

class MediaItemViewCell: UICollectionViewCell {

    lazy var imageView = createImageView()
    lazy var playIcon = createPlayIcon()

    var mediaID: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func fillData(_ item: MediaItem, isSelected: Bool) {
        mediaID = item.id
        item.setDelegate(self)
        playIcon.isHidden = item.type == .image
        if let thumbnail = item.thumbnail {
            imageView.image = thumbnail
        } else if item.asset == nil {
            imageView.kf.setImage(with: item.url, placeholder: MediaPreview.config.placeholderImage)
        } else {
            imageView.image = MediaPreview.config.placeholderImage
        }
        if isSelected {
            imageView.layer.borderWidth = 1
        } else {
            imageView.layer.borderWidth = 0
        }
    }

}

private extension MediaItemViewCell {

    func setup() {
        backgroundColor = .clear
        addSubview(imageView)
        addSubview(playIcon)
    }

    func createImageView() -> UIImageView {
        let view = UIImageView(frame: bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentMode = .scaleAspectFit
        view.layer.borderColor = MediaPreview.config.activeColor.cgColor
        view.layer.cornerRadius = 4
        view.image = MediaPreview.config.placeholderImage
        return view
    }

    func createPlayIcon() -> UIView {
        let view = UIImageView(frame: bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.layer.cornerRadius = 4
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentMode = .center
        view.image = MediaPreview.config.playIcon
        return view
    }

}

extension MediaItemViewCell: MediaItemDelegate {

    func mediaItem(_ item: MediaItem, didLoadThumbnail image: UIImage?) {
        DispatchQueue.main.async {
            guard self.mediaID == item.id else { return }
            self.imageView.image = image
        }
    }

    func mediaItem(_ item: MediaItem, didLoadOrigin image: UIImage?) {}

    func mediaItem(_ item: MediaItem, didLoadAVAsset avAsset: AVAsset?) {}

}
