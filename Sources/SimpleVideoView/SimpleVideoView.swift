import UIKit
import AVFoundation

public class SimpleVideoView: UIView {
	public var player: AVPlayer? {
		get { playerLayer.player }
		set { playerLayer.player = newValue }
	}
	public var gravity: AVLayerVideoGravity {
		get { playerLayer.videoGravity }
		set { playerLayer.videoGravity = newValue }
	}

	private let playerLayer: AVPlayerLayer

//	private var observers: Set<NSKeyValueObservation> = []

	private var looper: AVPlayerLooper?

	public init() {
		self.playerLayer = AVPlayerLayer(player: nil)
		super.init(frame: .zero)

		attachLayer()
	}


	public convenience init(player: AVPlayer, gravity: AVLayerVideoGravity = .resizeAspect) {
		self.init()
		self.player = player
		self.gravity = gravity

//		let readyOb = playerLayer.observe(\.isReadyForDisplay) { [weak self] (player, change) in
//			guard player.isReadyForDisplay else { return }
//			self?.attachLayer()
//		}
//		observers.insert(readyOb)
	}

	public convenience init(playerItem: AVPlayerItem, gravity: AVLayerVideoGravity = .resizeAspect) {
		let player = AVPlayer(playerItem: playerItem)
		self.init(player: player, gravity: gravity)
	}

	public convenience init(loopingPlayerItem: AVPlayerItem, gravity: AVLayerVideoGravity = .resizeAspect) {
		let (queuePlayer, looper) = Self.loopingPlayer(for: loopingPlayerItem)
		self.init(player: queuePlayer, gravity: gravity)
		self.looper = looper
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

//	deinit {
//		observers.forEach { $0.invalidate() }
//	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		let rect = bounds
		playerLayer.frame = rect
	}

	private func attachLayer() {
		guard playerLayer.superlayer == nil else { return }
		layer.addSublayer(playerLayer)
	}

	public func retainLooper(_ looper: AVPlayerLooper) {
		self.looper = looper
	}

	/**
	 Returns both the player object and a reference to the looper. The looper must be retained in memory.
	 */
	public static func loopingPlayer(for loopingPlayerItem: AVPlayerItem) -> (player: AVQueuePlayer, looperReference: AVPlayerLooper) {
		let queuePlayer = AVQueuePlayer()
		let looper = AVPlayerLooper(player: queuePlayer, templateItem: loopingPlayerItem)
		return (queuePlayer, looper)
	}
}
