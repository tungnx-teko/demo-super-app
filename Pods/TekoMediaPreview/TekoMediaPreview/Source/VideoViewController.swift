//
//  VideoViewController.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/8/20.
//

import AVFoundation
import Photos

class VideoViewController: MediaViewController {

    var playerTimeObserver: Any?
    var playerObserver: [NSKeyValueObservation] = []
    var isChangingSlider: Bool = false
    var isPlayerStopped: Bool = false

    var player: AVPlayer? {
        didSet { didSetPlayer() }
    }

    lazy var playIcon = createPlayIcon()
    lazy var playerView = createPlayerView()
    lazy var timeLabel = createTimeLabel()
    lazy var durationLabel = createDurationLabel()
    lazy var slider = createSlider()

    deinit {
        self.removePlayerObservers()
        self.player?.pause()
        self.player = nil
    }

    override func loadView() {
        super.loadView()
        didSetItem()
        view.backgroundColor = .clear
        view.addSubview(playerView)
        setupPlayIcon()
        setupPlayerBar()

        playerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePlay)))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
        playIcon.isHidden = false
    }

    override func setItem(_ item: MediaItem) {
        super.setItem(item)
        didSetItem()
    }
}

extension VideoViewController: MediaItemDelegate {
    func mediaItem(_ item: MediaItem, didLoadThumbnail image: UIImage?) {}

    func mediaItem(_ item: MediaItem, didLoadOrigin image: UIImage?) {}

    func mediaItem(_ item: MediaItem, didLoadAVAsset avAsset: AVAsset?) {
        guard let avAsset = avAsset else { return }
        self.player = AVPlayer(playerItem: .init(asset: avAsset))
    }
}

private extension VideoViewController {

    func createPlayIcon() -> UIView {
        let imageView = UIImageView(image: MediaPreview.config.playIcon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func createPlayerView() -> PlayerView {
        let playerView = PlayerView(frame: view.bounds)
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView.playerFillMode = .resizeAspect
        playerView.player = player
        return playerView
    }

    func createTimeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MediaPreview.config.font.withSize(13)
        label.textColor = MediaPreview.config.activeColor
        label.text = "00:00"
        return label
    }

    func createDurationLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MediaPreview.config.font.withSize(13)
        label.textColor = MediaPreview.config.activeColor
        label.text = " / 00:00"
        return label
    }

    func createSlider() -> UISlider {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = MediaPreview.config.activeColor
        slider.minimumTrackTintColor = MediaPreview.config.activeColor
        slider.addTarget(self, action: #selector(onSliderChanged(_:for:)), for: .valueChanged)
        slider.minimumValue = 0
        return slider
    }

    func setupPlayIcon() {
        view.addSubview(playIcon)
        NSLayoutConstraint.activate([
            .init(item: playIcon,
                  attribute: .centerX, relatedBy: .equal,
                  toItem: playerView,
                  attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: playIcon,
                  attribute: .centerY, relatedBy: .equal,
                  toItem: playerView,
                  attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: playIcon,
                  attribute: .width, relatedBy: .equal,
                  toItem: nil,
                  attribute: .notAnAttribute, multiplier: 1, constant: 60),
            .init(item: playIcon,
                  attribute: .height, relatedBy: .equal,
                  toItem: playIcon,
                  attribute: .width, multiplier: 1, constant: 0)
        ])
    }

    func setupPlayerBar() {
        let playerBarContainer = UIView(frame: view.bounds)
        playerBarContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerBarContainer)

        let bottomPlayerBarContainerConstraint: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            bottomPlayerBarContainerConstraint = .init(
                item: playerBarContainer,
                attribute: .bottom, relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide,
                attribute: .bottom, multiplier: 1, constant: 0
            )
        } else {
            bottomPlayerBarContainerConstraint = .init(
                item: playerBarContainer,
                attribute: .bottom, relatedBy: .equal,
                toItem: bottomLayoutGuide,
                attribute: .top, multiplier: 1, constant: 0
            )
        }

        NSLayoutConstraint.activate([
            .init(item: playerBarContainer,
                  attribute: .leading, relatedBy: .equal,
                  toItem: view,
                  attribute: .leading, multiplier: 1, constant: 0),
            .init(item: playerBarContainer,
                  attribute: .trailing, relatedBy: .equal,
                  toItem: view,
                  attribute: .trailing, multiplier: 1, constant: 0),
            bottomPlayerBarContainerConstraint,
        ])

        setupSlider(in: playerBarContainer)
        setupTimeContainer(in: playerBarContainer)
    }

    func setupSlider(in playerBarContainer: UIView) {
        playerBarContainer.addSubview(slider)
        NSLayoutConstraint.activate([
            .init(item: slider,
                  attribute: .leading, relatedBy: .equal,
                  toItem: view,
                  attribute: .leading, multiplier: 1, constant: 8),
            .init(item: slider,
                  attribute: .trailing, relatedBy: .equal,
                  toItem: playerBarContainer,
                  attribute: .trailing, multiplier: 1, constant: -8),
            .init(item: slider,
                  attribute: .top, relatedBy: .equal,
                  toItem: playerBarContainer,
                  attribute: .top, multiplier: 1, constant: 0)
        ])
    }

    func setupTimeContainer(in playerBarContainer: UIView) {
        let timeContainer = UIView(frame: view.bounds)
        timeContainer.translatesAutoresizingMaskIntoConstraints = false
        playerBarContainer.addSubview(timeContainer)
        timeContainer.addSubview(timeLabel)
        timeContainer.addSubview(durationLabel)

        NSLayoutConstraint.activate([
            .init(item: timeContainer,
                  attribute: .leading, relatedBy: .greaterThanOrEqual,
                  toItem: playerBarContainer,
                  attribute: .leading, multiplier: 1, constant: 8),
            .init(item: timeContainer,
                  attribute: .centerX, relatedBy: .equal,
                  toItem: playerBarContainer,
                  attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: timeContainer,
                  attribute: .top, relatedBy: .equal,
                  toItem: slider,
                  attribute: .bottom, multiplier: 1, constant: 8),
            .init(item: timeContainer,
                  attribute: .bottom, relatedBy: .equal,
                  toItem: playerBarContainer,
                  attribute: .bottom, multiplier: 1, constant: 0),

            .init(item: timeLabel,
                  attribute: .leading, relatedBy: .equal,
                  toItem: timeContainer,
                  attribute: .leading, multiplier: 1, constant: 0),
            .init(item: timeLabel,
                  attribute: .top, relatedBy: .greaterThanOrEqual,
                  toItem: timeContainer,
                  attribute: .top, multiplier: 1, constant: 0),
            .init(item: timeLabel,
                  attribute: .centerY, relatedBy: .equal,
                  toItem: timeContainer,
                  attribute: .centerY, multiplier: 1, constant: 0),

            .init(item: durationLabel,
                  attribute: .top, relatedBy: .greaterThanOrEqual,
                  toItem: timeContainer,
                  attribute: .top, multiplier: 1, constant: 0),
            .init(item: durationLabel,
                  attribute: .centerY, relatedBy: .equal,
                  toItem: timeContainer,
                  attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: durationLabel,
                  attribute: .trailing, relatedBy: .equal,
                  toItem: timeContainer,
                  attribute: .trailing, multiplier: 1, constant: -8),
            .init(item: durationLabel,
                  attribute: .leading, relatedBy: .equal,
                  toItem: timeLabel,
                  attribute: .trailing, multiplier: 1, constant: 0),
        ])
    }

    @objc func togglePlay() {
        guard let player = player else { return }
        guard player.error == nil else { return }
        switch player.timeControlStatus {
        case .playing:
            player.pause()
            playIcon.isHidden = false
        case .paused:
            if isPlayerStopped {
                isPlayerStopped = false
                player.currentItem?.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 1000))
                slider.value = 0
                timeLabel.text = "00:00"
            }
            playIcon.isHidden = true
            player.play()
        default:
            playIcon.isHidden = false
        }
    }

    @objc func onSliderChanged(_ sender: UISlider, for event: UIEvent) {
        timeLabel.text = sender.value.toDurationString()
        player?.currentItem?.seek(to: CMTimeMakeWithSeconds(Float64(sender.value), preferredTimescale: 1000))
        guard let touchEvent = event.allTouches?.first else { return }
        switch touchEvent.phase {
        case .began, .moved:
            self.isChangingSlider = true
        case .ended:
            self.isChangingSlider = false
        case .cancelled:
            self.isChangingSlider = false
        default:
            break
        }
    }

    @objc func receivePlayerDidEndPlayingNotification(_ notification: Notification) {
        isPlayerStopped = true
        playIcon.isHidden = false
    }

    func didSetItem() {
        item.setDelegate(self)
        if item.asset != nil {
            if let avAsset = item.avAsset {
                self.player = .init(playerItem: .init(asset: avAsset))
            }
        } else if let url = item.url {
            self.player = .init(url: url)
        }
    }

    func didSetPlayer() {
        DispatchQueue.main.async {
            self.playerView.player = self.player
            self.setupIfReady()
        }
        removePlayerObservers()
        addPlayerObservers()
        player?.actionAtItemEnd = .pause
    }

    func addPlayerObservers() {
        self.playerTimeObserver = self.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1000), queue: DispatchQueue.main, using: { [weak self] _ in
            guard let self = self, !self.isChangingSlider else { return }
            guard let currentTime = self.player?.currentItem?.currentTime().seconds else { return }
            self.timeLabel.text = currentTime.toDurationString()
            self.slider.value = Float(currentTime)
        })
        let statusObserver = self.player?.observe(\.status, options: [.new, .old]) { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.setupIfReady()
            }
        }
        if let statusObserver = statusObserver {
            self.playerObserver.append(statusObserver)
        }
        let timeControlStatusObserver = self.player?.observe(\.timeControlStatus, options: [.new, .old]) { [weak self] _, _ in
            guard let self = self, let player = self.player else { return }
            DispatchQueue.main.async {
                switch player.timeControlStatus {
                case .playing:
                    guard let item = player.currentItem else { return }
                    let duration: Double
                    let expectedValuableDuration = item.duration.seconds
                    if expectedValuableDuration.isNaN {
                        duration = item.seekableTimeRanges.last?.timeRangeValue.end.seconds ?? 0
                    } else {
                        duration = expectedValuableDuration
                    }
                    self.slider.maximumValue = max(Float(duration), 0)
                    self.durationLabel.text = " / \(duration.toDurationString())"
                default:
                    break
                }
            }
        }
        if let timeControlStatusObserver = timeControlStatusObserver {
            self.playerObserver.append(timeControlStatusObserver)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(receivePlayerDidEndPlayingNotification), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }

    func removePlayerObservers() {
        if let observer = self.playerTimeObserver {
            self.player?.removeTimeObserver(observer)
        }
        self.playerObserver.forEach { $0.invalidate() }
        self.playerObserver = []
        NotificationCenter.default.removeObserver(self)
    }

    func setupIfReady() {
        guard let player = player else { return }
        switch player.status {
        case .readyToPlay:
            guard let item = player.currentItem else { return }
            let duration: Double
            let expectedValuableDuration = item.duration.seconds
            if expectedValuableDuration.isNaN {
                duration = item.seekableTimeRanges.last?.timeRangeValue.end.seconds ?? 0
            } else {
                duration = expectedValuableDuration
            }
            self.slider.maximumValue = max(Float(duration), 0)
            self.durationLabel.text = " / \(duration.toDurationString())"
        default:
            break
        }
    }

}

extension BinaryFloatingPoint {
    func toDurationString() -> String {
        let (hr,  minf) = modf(self / 3600)
        let (min, secf) = modf(60 * minf)
        let sec = 60 * secf
        if hr > 0 {
            return String(format: "%0.2d:%0.2d:%0.2d", Int(hr), Int(min), Int(sec))
        } else {
            return String(format: "%0.2d:%0.2d", Int(min), Int(sec))
        }
    }
}
