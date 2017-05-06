//
//  PrepareFireViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/17/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation
class PrepareFireViewController: UIViewController {

    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSound(name: "neu la be", Extension: "wav")
    }
    
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
