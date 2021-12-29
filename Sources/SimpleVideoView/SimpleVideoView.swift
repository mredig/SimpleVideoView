import UIKit
import AVFoundation

public class SimpleVideoView: UIView {
	public let player: AVPlayer
	public var gravity: AVLayerVideoGravity {
		get { playerLayer.videoGravity }
		set { playerLayer.videoGravity = newValue }
	}

	private let playerLayer: AVPlayerLayer

	private var observers: Set<NSKeyValueObservation> = []

	public init(player: AVPlayer, gravity: AVLayerVideoGravity = .resizeAspect) {
		self.player = player
		self.playerLayer = AVPlayerLayer(player: player)
		super.init(frame: .zero)
		self.gravity = gravity

		let readyOb = playerLayer.observe(\.isReadyForDisplay) { [weak self] (player, change) in
			guard player.isReadyForDisplay else { return }
			self?.attachLayer()
		}
		observers.insert(readyOb)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		observers.forEach { $0.invalidate() }
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		let rect = bounds
		playerLayer.frame = rect
	}

	private func attachLayer() {
		guard playerLayer.superlayer == nil else { return }
		layer.addSublayer(playerLayer)
	}
}
