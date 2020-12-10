//
//  MediaPreviewViewController.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/8/20.
//

import UIKit

class MediaPreviewViewController: UIViewController {

    let mediaItems: [MediaItem]
    var currentIndex: Int = 0

    lazy var pageViewController = createPageViewController()
    lazy var previewCollectionView = createCollectionView()
    lazy var closeButton = createCloseButton()
    lazy var countLabel = createCountLabel()

    init(mediaItems: [MediaItem], selectedIndex: Int) {
        self.mediaItems = mediaItems
        self.currentIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.mediaItems = []
        super.init(coder: coder)
    }

    override func loadView() {
        super.loadView()
        setupView()
        setupPageViewController()
        setupCollectionView()
        setupCloseButton()
        setupCountContainer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if mediaItems.isEmpty { return }
        let viewController = produceMediaViewController(from: mediaItems[currentIndex], index: currentIndex)
        pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
    }

    @objc func onClose() {
        dismiss(animated: true)
    }
}

extension MediaPreviewViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MediaItemViewCell
        cell.fillData(mediaItems[indexPath.row], isSelected: indexPath.row == currentIndex)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard currentIndex != indexPath.row else { return }
        let previousSelectedIndex = currentIndex
        currentIndex = indexPath.row
        countLabel.text = "\(currentIndex + 1)/\(mediaItems.count)"
        let oldIndexPath = IndexPath(row: previousSelectedIndex, section: 0)
        collectionView.reloadItems(at: [oldIndexPath, indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let viewController = produceMediaViewController(from: mediaItems[indexPath.row], index: indexPath.row)
        if indexPath.row < previousSelectedIndex {
            pageViewController.setViewControllers([viewController], direction: .reverse, animated: true)
        } else {
            pageViewController.setViewControllers([viewController], direction: .forward, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 92, height: collectionView.frame.height)
    }
}

extension MediaPreviewViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex == 0 {
            return nil
        }
        return produceMediaViewController(from: mediaItems[currentIndex - 1], index: currentIndex - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == mediaItems.count - 1 {
            return nil
        }
        return produceMediaViewController(from: mediaItems[currentIndex + 1], index: currentIndex + 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let index = (pageViewController.viewControllers?.first as? MediaViewController)?.index,
              self.currentIndex != index else { return }
        let oldIndexPath = IndexPath(row: self.currentIndex, section: 0)
        self.currentIndex = index
        countLabel.text = "\(currentIndex + 1)/\(mediaItems.count)"
        let newIndexPath = IndexPath(row: index, section: 0)
        previewCollectionView.reloadItems(at: [oldIndexPath, newIndexPath])
        previewCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
    }
}

private extension MediaPreviewViewController {

    func createPageViewController() -> UIPageViewController {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.delegate = self
        return pageVC
    }

    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MediaItemViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }

    func createCloseButton() -> UIButton {
        let closeButton = UIButton(frame: .init(x: 0, y: 0, width: 40, height: 40))
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(MediaPreview.config.closeIcon, for: .normal)
        closeButton.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        return closeButton
    }

    func createCountLabel() -> UILabel {
        let label = UILabel(frame: view.bounds)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MediaPreview.config.font
        label.textColor = .black
        label.text = "\(currentIndex + 1)/\(mediaItems.count)"
        return label
    }

    func setupView() {
        switch MediaPreview.config.style {
        case .light:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = UIColor(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0, alpha: 1)
        }
    }

    func setupPageViewController() {
        if mediaItems.isEmpty { return }
        let pageView = pageViewController.view!
        pageView.backgroundColor = .clear
        pageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageView)

        NSLayoutConstraint.activate([
            .init(item: pageView,
                attribute: .top, relatedBy: .equal,
                toItem: view,
                attribute: .top, multiplier: 1, constant: 0),
            .init(item: pageView,
                attribute: .leading, relatedBy: .equal,
                toItem: view,
                attribute: .leading, multiplier: 1, constant: 0),
            .init(item: pageView,
                attribute: .trailing, relatedBy: .equal,
                toItem: view,
                attribute: .trailing, multiplier: 1, constant: 0),
        ])

        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }

    func setupCollectionView() {
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        view.addSubview(previewCollectionView)
        let bottomCollectionViewConstrant: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            bottomCollectionViewConstrant = .init(
                item: previewCollectionView,
                attribute: .bottom, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide,
                attribute: .bottom, multiplier: 1, constant: 0
            )
        } else {
            bottomCollectionViewConstrant = .init(
                item: previewCollectionView,
                attribute: .bottom, relatedBy: .equal,
                toItem: bottomLayoutGuide,
                attribute: .bottom, multiplier: 1, constant: 0
            )
        }
        NSLayoutConstraint.activate([
            .init(item: previewCollectionView,
                  attribute: .top, relatedBy: .equal,
                  toItem: pageViewController.view,
                  attribute: .bottom, multiplier: 1, constant: 8),
            .init(item: previewCollectionView,
                  attribute: .leading, relatedBy: .equal,
                  toItem: view,
                  attribute: .leading, multiplier: 1, constant: 0),
            .init(item: previewCollectionView,
                  attribute: .trailing, relatedBy: .equal,
                  toItem: view,
                  attribute: .trailing, multiplier: 1, constant: 0),
            bottomCollectionViewConstrant,
            .init(item: previewCollectionView,
                  attribute: .height, relatedBy: .equal,
                  toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 92)
        ])
    }

    func setupCloseButton() {
        view.addSubview(closeButton)

        let topCloseButtonConstraint: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            topCloseButtonConstraint = .init(
                item: closeButton,
                attribute: .top, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide,
                attribute: .top, multiplier: 1, constant: 0
            )
        } else {
            topCloseButtonConstraint = .init(
                item: closeButton,
                attribute: .top, relatedBy: .equal,
                toItem: topLayoutGuide,
                attribute: .bottom, multiplier: 1, constant: 0
            )
        }

        NSLayoutConstraint.activate([
            .init(item: closeButton,
                  attribute: .leading, relatedBy: .equal,
                  toItem: view,
                  attribute: .leading, multiplier: 1, constant: 8),
            topCloseButtonConstraint,
            .init(item: closeButton,
                  attribute: .width, relatedBy: .equal,
                  toItem: nil,
                  attribute: .notAnAttribute, multiplier: 1, constant: 40),
            .init(item: closeButton,
                  attribute: .width, relatedBy: .equal,
                  toItem: closeButton,
                  attribute: .height, multiplier: 1, constant: 1),
        ])
    }

    func setupCountContainer() {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 224 / 255.0, green: 224 / 255.0, blue: 224 / 255.0, alpha: 1)
            .withAlphaComponent(0.7)
        container.layer.cornerRadius = 12
        view.addSubview(container)
        container.addSubview(countLabel)

        NSLayoutConstraint.activate([
            .init(item: container,
                  attribute: .centerY, relatedBy: .equal,
                  toItem: closeButton,
                  attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: container,
                  attribute: .trailing, relatedBy: .equal,
                  toItem: view,
                  attribute: .trailing, multiplier: 1, constant: -16),
            .init(item: container,
                  attribute: .height, relatedBy: .equal,
                  toItem: nil,
                  attribute: .notAnAttribute, multiplier: 1, constant: 24),

            .init(item: countLabel,
                  attribute: .centerX, relatedBy: .equal,
                  toItem: container,
                  attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: countLabel,
                  attribute: .centerY, relatedBy: .equal,
                  toItem: container,
                  attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: countLabel,
                  attribute: .leading, relatedBy: .equal,
                  toItem: container,
                  attribute: .leading, multiplier: 1, constant: 8),
        ])
    }

}

private func produceMediaViewController(from item: MediaItem, index: Int) -> MediaViewController {
    let viewController: MediaViewController
    switch item.type {
    case .image:
        viewController = ImageViewController(item: item)
    case .video:
        viewController = VideoViewController(item: item)
    }
    viewController.index = index
    return viewController
}
