//
//  GameTargetViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/14/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation



class GameTargetViewController: UIViewController {
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        playSound(name: "ve voi me", Extension: "wav")
//    }

    func playSound(name: String, Extension: String) {
        let url = Bundle.main.url(forResource: name, withExtension: Extension)!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }


}
