//
//  ViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/13/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?
class ViewController: UIViewController {

    @IBOutlet weak var btnGame1: UIButton!
    @IBOutlet weak var btnGame2: UIButton!
    
    @IBOutlet weak var btnMute: UIButton!
    var flag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGame1.backgroundColor = .white
        btnGame2.backgroundColor = .white
//        flag = false
        
        playSound(name: "AllFallDown", Extension: "mp3")
    }

    //View hien thi xong
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        playSound(name: "AllFallDown", Extension: "mp3")
//    }
    
    //bat dau chuyen sang view khac
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        player?.stop()
    }
   
    @IBAction func actMute(_ sender: Any) {
        if flag {
            player?.play()
            flag = false
            btnMute.setImage(UIImage(named: "notMute"), for: .normal)
        } else {
            player?.pause()
            flag = true
            btnMute.setImage(UIImage(named: "mute"), for: .normal)
        }
    }
    func playSound(name: String, Extension: String) {
        let url = Bundle.main.url(forResource: name, withExtension: Extension)!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            player.numberOfLoops = -1
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

