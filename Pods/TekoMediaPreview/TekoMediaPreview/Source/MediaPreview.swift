//
//  MediaPreview.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/8/20.
//

import UIKit

public struct MediaPreview {
    static var config: Config!

    public static func show(on viewController: UIViewController, config: Config, mediaItems: [MediaItem], selectedIndex: Int = 0) {
        self.config = config
        let vc = MediaPreviewViewController(mediaItems: mediaItems, selectedIndex: selectedIndex)
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true)
    }
}

public struct Config {
    let playIcon: UIImage?
    let closeIcon: UIImage?
    let placeholderImage: UIImage?

    let activeColor: UIColor
    let font: UIFont!
    let style: Style

    public init(playIcon: UIImage?, closeIcon: UIImage?, placeholderImage: UIImage?, activeColor: UIColor, font: UIFont!, style: Style = .light) {
        self.playIcon = playIcon
        self.closeIcon = closeIcon
        self.placeholderImage = placeholderImage
        self.activeColor = activeColor
        self.font = font
        self.style = style
    }
}

extension Config {
    public enum Style {
        case light
        case dark
    }
}
