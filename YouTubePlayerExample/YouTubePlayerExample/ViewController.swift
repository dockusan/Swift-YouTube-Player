//
//  ViewController.swift
//  YouTubePlayerExample
//
//  Created by Giles Van Gruisen on 1/31/15.
//  Copyright (c) 2015 Giles Van Gruisen. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController, YouTubePlayerDelegate {

    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var currentTimeButton: UIButton!
    @IBOutlet var durationButton: UIButton!
    var isAppInBackground: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.playInBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @IBAction func play(sender: UIButton) {
        if playerView.ready {
            if playerView.playerState != YouTubePlayerState.Playing {
                playerView.play()
                playButton.setTitle("Pause", for: .normal)
            } else {
                playerView.pause()
                playButton.setTitle("Play", for: .normal)
            }
        }
    }
    
    @objc func playInBackground(){
        print("play background")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
            print("play playerView")

            self.playerView.play()
        }
//        isAppInBackground = true
    }
    
    @IBAction func prev(sender: UIButton) {
        playerView.previousVideo()
    }

    @IBAction func next(sender: UIButton) {
        playerView.nextVideo()
    }

    @IBAction func loadVideo(sender: UIButton) {
        playerView.playerVars = [
            "playsinline": "1" as AnyObject,
            "controls": "2" as AnyObject,
            "showinfo": "0"as AnyObject
        ]
        playerView.loadVideoID("erkypb6Yf04")
    }

    @IBAction func loadPlaylist(sender: UIButton) {
        playerView.loadPlaylistID("RDe-ORhEE9VVg")
    }
    
    @IBAction func currentTime(sender: UIButton) {
        let title = String(format: "Current Time %@", playerView.getCurrentTime() ?? "0")
        currentTimeButton.setTitle(title, for: .normal)
    }
    
    @IBAction func duration(sender: UIButton) {
        let title = String(format: "Duration %@", playerView.getDuration() ?? "0")
        durationButton.setTitle(title, for: .normal)

    }

    func showAlert(message: String) {
        self.present(alertWithMessage(message: message), animated: true, completion: nil)
    }

    func alertWithMessage(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
//        MPNowPlayingInfoCenter.default().nowPlayingInfo
        print(playerState)
//        if playerState == .Paused && isAppInBackground{
//            self.playerView.play()
//        }
    }
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        
    }
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }

}

