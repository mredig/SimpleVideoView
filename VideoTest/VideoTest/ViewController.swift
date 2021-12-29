//
//  ViewController.swift
//  VideoTest
//
//  Created by Michael Redig on 12/28/21.
//

import UIKit
import SimpleVideoView
import AVFoundation

class ViewController: UIViewController {

	var looper: AVPlayerLooper?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		let url = URL(string: "https://media0.giphy.com/media/CvxQBnh6Vuu8zNbOG5/giphy.mp4?cid=686a81dcc61fkmsqf271r0msb2lt9vxr8glugwgm3dej8s3y&rid=giphy.mp4&ct=g")!
		let url2 = URL(string: "https://media4.giphy.com/media/bUm7IqjufH5eoFN6bG/giphy.mp4?cid=686a81dcc61fkmsqf271r0msb2lt9vxr8glugwgm3dej8s3y&rid=giphy.mp4&ct=g")!

		let playerItem = AVPlayerItem(url: url2)

		let videoView = SimpleVideoView(loopingPlayerItem: playerItem)
		videoView.translatesAutoresizingMaskIntoConstraints = false
		videoView.player?.play()

		view.addSubview(videoView)

		NSLayoutConstraint.activate([
			view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: videoView.leadingAnchor),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: videoView.trailingAnchor),
			view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: videoView.topAnchor),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: videoView.bottomAnchor),
		])

		Task {
			try await Task.sleep(nanoseconds: 3_000_000_000)
			let playerItem = AVPlayerItem(url: url)

			let newLoop = SimpleVideoView.loopingPlayer(for: playerItem)

			videoView.player = newLoop.player
			videoView.retainLooper(newLoop.looperReference)
			newLoop.player.play()
		}
	}


}

