//
//  MediaViewController.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/9/20.
//

import Foundation

class MediaViewController: UIViewController {

    private(set) var item: MediaItem
    var index: Int = 0

    init(item: MediaItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setItem(_ item: MediaItem) {
        self.item = item
    }
}
