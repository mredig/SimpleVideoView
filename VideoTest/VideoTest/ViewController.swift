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

		let queue = AVQueuePlayer()
		let item = AVPlayerItem(url: url2)
		let looper = AVPlayerLooper(player: queue, templateItem: item)
		self.looper = looper

		let videoView = SimpleVideoView(player: queue, gravity: .resizeAspect)
		videoView.translatesAutoresizingMaskIntoConstraints = false
		queue.play()

		view.addSubview(videoView)

		NSLayoutConstraint.activate([
			view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: videoView.leadingAnchor),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: videoView.trailingAnchor),
			view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: videoView.topAnchor),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: videoView.bottomAnchor),
		])
	}


}

