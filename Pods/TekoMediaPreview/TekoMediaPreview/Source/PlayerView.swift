//
//  PlayerView.swift
//  TekoMediaPreview
//
//  Created by Dung Nguyen on 10/9/20.
//

import AVFoundation

typealias FillMode = AVLayerVideoGravity

class PlayerView: UIView {

    // MARK: - overrides
    override class var layerClass: AnyClass { AVPlayerLayer.self }

    // MARK: - internal properties
    var playerLayer: AVPlayerLayer { self.layer as! AVPlayerLayer }

    var player: AVPlayer? {
        get { self.playerLayer.player }
        set {
            playerLayer.player = newValue
            playerLayer.isHidden = playerLayer.player == nil
        }
    }

    // MARK: - public properties
    var playerBackgroundColor: UIColor? {
        get { playerLayer.backgroundColor.flatMap(UIColor.init) }
        set { playerLayer.backgroundColor = newValue?.cgColor }
    }

    var playerFillMode: FillMode {
        get { playerLayer.videoGravity }
        set { playerLayer.videoGravity = newValue }
    }

    var isReadyForDisplay: Bool { self.playerLayer.isReadyForDisplay }

    // MARK: - object lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.playerLayer.isHidden = true
        self.playerFillMode = .resizeAspect
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.playerLayer.isHidden = true
        self.playerFillMode = .resizeAspect
    }

    deinit {
        self.player?.pause()
        self.player = nil
    }

}
