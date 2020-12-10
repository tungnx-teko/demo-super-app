//
//  ZoomableImageView.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/12/20.
//

import UIKit

private let horizontalSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 200.0 : 50.0

public protocol ZoomableImageViewDelegate: class {
    func zoomableImageViewWillBeginZooming(_ zoomableImageView: ZoomableImageView)
    func zoomableImageViewDidEndZooming(_ zoomableImageView: ZoomableImageView)
    func zoomableImageViewDidSingleTap(_ zoomableImageView: ZoomableImageView, scaling: Bool)
}

@IBDesignable
public class ZoomableImageView: UIView {

    lazy var scrollView = createScrollView()
    lazy var imageView = createImageView()
    private lazy var scrollDelegate = InternalScrollViewDelegate(zoomableView: self)

    public weak var delegate: ZoomableImageViewDelegate?

    @IBInspectable public var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue
            didSetImage()
        }
    }

    @IBInspectable public var highlightedImage: UIImage? {
        get { imageView.highlightedImage }
        set { imageView.highlightedImage = newValue }
    }

    @available(iOS 13.0, *)
    public var preferredSymbolConfiguration: UIImage.SymbolConfiguration? {
        get { imageView.preferredSymbolConfiguration }
        set { imageView.preferredSymbolConfiguration = newValue }
    }

    @IBInspectable public var isHighlighted: Bool {
        get { imageView.isHighlighted }
        set { imageView.isHighlighted = newValue }
    }

    public var animationImages: [UIImage]? {
        get { imageView.animationImages }
        set { imageView.animationImages = newValue }
    }

    public var highlightedAnimationImages: [UIImage]? {
        get { imageView.highlightedAnimationImages }
        set { imageView.highlightedAnimationImages = newValue }
    }

    @IBInspectable public var animationDuration: TimeInterval {
        get { imageView.animationDuration }
        set { imageView.animationDuration = newValue }
    }

    @IBInspectable public var animationRepeatCount: Int {
        get { imageView.animationRepeatCount }
        set { imageView.animationRepeatCount = newValue }
    }

    override public var tintColor: UIColor! {
        get { super.tintColor }
        set {
            super.tintColor = newValue
            imageView.tintColor = newValue
        }
    }

    @IBInspectable public var imageContentMode: UIView.ContentMode {
        get { imageView.contentMode }
        set { imageView.contentMode = newValue }
    }

    @IBInspectable public var minimumZoomScale: CGFloat {
        get { scrollView.minimumZoomScale }
        set { scrollView.minimumZoomScale = newValue }
    }

    @IBInspectable public var maximumZoomScale: CGFloat {
        get { scrollView.maximumZoomScale }
        set { scrollView.maximumZoomScale = newValue }
    }

    @IBInspectable public var zoomScale: CGFloat {
        get { scrollView.zoomScale }
        set { scrollView.zoomScale = newValue }
    }

    public var isAnimating: Bool {
        imageView.isAnimating
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public func startAnimating() {
        imageView.startAnimating()
    }

    public func stopAnimating() {
        imageView.stopAnimating()
    }

    func didSetImage() {
        if let imageSize = imageView.image?.size {
            imageView.center = scrollView.center
            imageView.frame.size = imageSize
        }
        updateMinZoomScaleForSize()
    }
}

private extension ZoomableImageView {

    func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.flashScrollIndicators()
        scrollView.delegate = scrollDelegate
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        return scrollView
    }

    func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(
            x: horizontalSpacing, y: 0,
            width: frame.width - 2 * horizontalSpacing, height: frame.height
        ))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func setup() {
        insertSubview(scrollView, at: 0)
        scrollView.addSubview(imageView)

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)

        singleTap.require(toFail: doubleTap)
    }

    @objc func didDoubleTap(_ recognizer: UIGestureRecognizer) {
        scrollView.setZoomScale(1, animated: true)
    }

    @objc func didSingleTap(_ recognizer: UIGestureRecognizer) {
        if scrollView.zoomScale > minimumZoomScale {
            scrollView.setZoomScale(minimumZoomScale, animated: true)
            delegate?.zoomableImageViewDidSingleTap(self, scaling: true)
        } else {
            delegate?.zoomableImageViewDidSingleTap(self, scaling: false)
        }
    }

    func getApprociateScale() -> CGFloat {
        let widthScale = scrollView.frame.width / imageView.bounds.width
        let heightScale = scrollView.frame.height / imageView.bounds.height
        return min(widthScale, heightScale)
    }

    private func updateMinZoomScaleForSize() {
        let minScale = getApprociateScale()
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    private func updateConstraintsForSize() {
        let realHeight = imageView.bounds.height * scrollView.zoomScale
        let readWidth = imageView.bounds.width * scrollView.zoomScale
        let deltaHeight = scrollView.bounds.height - realHeight
        let deltaWidth = scrollView.bounds.width - readWidth
        let yOffset = max(0, deltaHeight / 2)
        let xOffset = max(0, deltaWidth / 2)
        imageView.frame.origin = CGPoint(x: xOffset, y: yOffset)
    }
}

private extension ZoomableImageView {

    class InternalScrollViewDelegate: NSObject, UIScrollViewDelegate {
        weak var zoomableView: ZoomableImageView?

        init(zoomableView: ZoomableImageView?) {
            self.zoomableView = zoomableView
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            zoomableView?.imageView
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            zoomableView?.updateConstraintsForSize()
        }

        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            guard let zoomableView = zoomableView else { return }
            zoomableView.delegate?.zoomableImageViewWillBeginZooming(zoomableView)
        }

        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            guard let zoomableView = zoomableView else { return }
            zoomableView.delegate?.zoomableImageViewDidEndZooming(zoomableView)
        }
    }

}
