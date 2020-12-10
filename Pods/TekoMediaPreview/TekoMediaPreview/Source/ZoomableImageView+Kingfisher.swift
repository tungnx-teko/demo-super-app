//
//  ZoomableImageView+Kingfisher.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/13/20.
//

import Kingfisher

extension ZoomableImageView: KingfisherCompatible {}

extension KingfisherWrapper where Base: ZoomableImageView {
    @discardableResult
    public func setImage(
        with source: Source?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        base.imageView.kf.setImage(with: source, placeholder: placeholder, options: options, progressBlock: progressBlock) {
            [weak base] result in
            base?.didSetImage()
            completionHandler?(result)
        }
    }

    @discardableResult
    public func setImage(
        with resource: Resource?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        base.imageView.kf.setImage(with: resource, placeholder: placeholder, options: options, progressBlock: progressBlock) {
            [weak base] result in
            base?.didSetImage()
            completionHandler?(result)
        }
    }

    @discardableResult
    public func setImage(
        with provider: ImageDataProvider?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        base.imageView.kf.setImage(with: provider, placeholder: placeholder, options: options, progressBlock: progressBlock) {
            [weak base] result in
            base?.didSetImage()
            completionHandler?(result)
        }
    }

    public func cancelDownloadTask() {
        base.imageView.kf.cancelDownloadTask()
    }

    public var taskIdentifier: Source.Identifier.Value? {
        base.imageView.kf.taskIdentifier
    }

    public var indicatorType: IndicatorType {
        get { base.imageView.kf.indicatorType }
        set { base.imageView.kf.indicatorType = newValue }
    }

    public var indicator: Indicator? {
        base.imageView.kf.indicator
    }
}
