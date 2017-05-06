//
//  GameFourViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/16/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation


class GameFourViewController: UIViewController {

    @IBOutlet weak var imgBuom: UIImageView!
    @IBOutlet weak var imgKien: UIImageView!
    @IBOutlet weak var imgSoc: UIImageView!
    @IBOutlet weak var imgHeo: UIImageView!
    
    @IBOutlet weak var btnNumber1: UIButton!
    @IBOutlet weak var btnNumber2: UIButton!
    @IBOutlet weak var btnNumber3: UIButton!
    @IBOutlet weak var btnNumber4: UIButton!
    
    
    var originPlayer1:CGPoint?
    var originPlayer2:CGPoint?
    var originPlayer3:CGPoint?
    var originPlayer4:CGPoint?
    
    var player: AVAudioPlayer?
    
    var flag: Int = 0 {
        didSet {
            showDialog()
        }
    }
    
    var arrOrigin: [CGPoint]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayout()
        
        arrOrigin = getPos()
        setLayout()
        
        setUserInterface(flag: true)
//        originPlayer1 = imgBuom.frame.origin
//        originPlayer2 = imgKien.frame.origin
//        originPlayer3 = imgSoc.frame.origin
//        originPlayer4 = imgHeo.frame.origin
        
        print("heo------", imgHeo.center)
        
        imgBuom.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView1)))
        imgKien.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView2)))
        imgSoc.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView3)))
        imgHeo.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView4)))


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSound(name: "ke ve minh", Extension: "wav")
        
         _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.playSoundTimer), userInfo: nil, repeats: false)
        
    }
    
//    override func viewDidLayoutSubviews() {
//        arrOrigin = getPos()
//    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        btnNumber1.layer.cornerRadius = btnNumber1.frame.size.height/2
        btnNumber2.layer.cornerRadius = btnNumber2.frame.size.height/2
        btnNumber3.layer.cornerRadius = btnNumber3.frame.size.height/2
        btnNumber4.layer.cornerRadius = btnNumber4.frame.size.height/2
        
        arrOrigin = getPos()
        originPlayer1 = imgBuom.center
        originPlayer2 = imgKien.center
        originPlayer3 = imgSoc.center
        originPlayer4 = imgHeo.center
    }
    @IBAction func actChoiLai(_ sender: Any) {
        setPosition(arrData: arrOrigin!)
        imgBuom.isUserInteractionEnabled = true
        imgKien.isUserInteractionEnabled = true
        imgHeo.isUserInteractionEnabled = true
        imgSoc.isUserInteractionEnabled = true
    }
    
    func autoLayout() {
        let wButton: CGFloat = btnNumber2.frame.size.height
        btnNumber2.frame.size = CGSize(width: wButton, height: wButton)
    }
    
    func setLayout() {
        imgBuom.setNeedsLayout()
        imgBuom.layoutIfNeeded()
        
        imgKien.setNeedsLayout()
        imgKien.layoutIfNeeded()
        
        imgHeo.setNeedsLayout()
        imgHeo.layoutIfNeeded()
        
        imgSoc.setNeedsLayout()
        imgSoc.layoutIfNeeded()
    }
    
    //Get arr pos
    func getPos() -> [CGPoint] {
        var arr = [CGPoint]()
        arr.append(imgBuom.frame.origin)
        arr.append(imgKien.frame.origin)
        arr.append(imgHeo.frame.origin)
        arr.append(imgSoc.frame.origin)
        
        print("arr pos-----", arr)

        return arr
    }
    
    func setPosition(arrData: [CGPoint]) {
        imgBuom.frame.origin = arrData[0]
        imgKien.frame.origin = arrData[1]
        imgHeo.frame.origin = arrData[2]
        imgSoc.frame.origin = arrData[3]
        
//        originPlayer1 = imgPlayer1.center
//        originPlayer2 = imgPlayer2.center
//        originPlayer3 = imgPlayer3.center
//        originPlayer4 = imgPlayer4.center
//        originPlayer5 = imgPlayer5.center
//        originPlayer6 = imgPlayer6.center
        
    }

    
    func showDialog()  {
        if flag == 4 {
            playSound(name: "ke lai that hay", Extension: "wav")
            flag = 0
//            setUserInterface(flag: false)
        }
    }
    
    func playSoundTimer() {
        playSound(name: "xep tranh", Extension: "mp3")
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
    
    func setUserInterface(flag: Bool) {
        imgBuom.isUserInteractionEnabled = flag
        imgKien.isUserInteractionEnabled = flag
        imgSoc.isUserInteractionEnabled = flag
        imgHeo.isUserInteractionEnabled = flag
    }
    
    func checkContaintView2(view:UIView, frameTarget1: UIView, frameTarget2: UIView, frameTarget3: UIView, frameTarget4: UIView, frameOrigin: CGPoint) -> Bool {
        var temp = false
        if frameTarget1.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget1.center
//                self.playSound(name: "ke lai that hay", Extension: "wav")
//                self.flag += 1
            }
            temp = true
            
        } else if frameTarget2.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget2.center
//                self.playSound(name: "ke lai that hay", Extension: "wav")
//                self.flag += 1
            }
            temp = true
            
        } else if frameTarget3.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget3.center
//                self.playSound(name: "ke lai that hay", Extension: "wav")
//                self.flag += 1
            }
            temp = true
            
        } else if frameTarget4.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget4.center
//                self.playSound(name: "ke lai that hay", Extension: "wav")
//                self.flag += 1
            }
            temp = true
        }
        else {
            UIView.animate(withDuration: 0.3) {
                view.center = frameOrigin
            }
            temp = false
        }
        return temp
    }
    
    func dragView1(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: btnNumber1, frameTarget2: btnNumber2, frameTarget3: btnNumber3, frameTarget4: btnNumber4, frameOrigin: originPlayer1!)
            if check {
                self.flag += 1
                imgBuom.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView2(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: btnNumber1, frameTarget2: btnNumber2, frameTarget3: btnNumber3, frameTarget4: btnNumber4, frameOrigin: originPlayer2!)
            if check {
                self.flag += 1
                imgKien.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView3(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: btnNumber1, frameTarget2: btnNumber2, frameTarget3: btnNumber3, frameTarget4: btnNumber4, frameOrigin: originPlayer3!)
            if check {
                self.flag += 1
                imgSoc.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView4(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: btnNumber1, frameTarget2: btnNumber2, frameTarget3: btnNumber3, frameTarget4: btnNumber4, frameOrigin: originPlayer4!)
            if check {
                self.flag += 1
                imgHeo.isUserInteractionEnabled = false
            }
        }
    }
}
