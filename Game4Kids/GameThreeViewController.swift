//
//  GameThreeViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/15/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation

class GameThreeViewController: UIViewController {
    
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var imgPlayer3: UIImageView!
    @IBOutlet weak var imgPlayer4: UIImageView!
    
    @IBOutlet weak var imgTarget1: UIImageView!
    @IBOutlet weak var imgTarget2: UIImageView!
    @IBOutlet weak var imgTarget3: UIImageView!
    @IBOutlet weak var imgTarget4: UIImageView!
    
    var originPlayer1:CGPoint?
    var originPlayer2:CGPoint?
    var originPlayer3:CGPoint?
    var originPlayer4:CGPoint?

    var player: AVAudioPlayer?
    var arrOrigin: [CGPoint]?
    var flag: Int = 0 {
        didSet {
            print(flag)
            showDialog()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        autoLayout()
        arrOrigin = getPos()
        
        imgPlayer1.isUserInteractionEnabled = true
        imgPlayer2.isUserInteractionEnabled = true
        imgPlayer3.isUserInteractionEnabled = true
        imgPlayer4.isUserInteractionEnabled = true
        
        originPlayer1 = imgPlayer1.center
        originPlayer2 = imgPlayer2.center
        originPlayer3 = imgPlayer3.center
        originPlayer4 = imgPlayer4.center
        
        imgPlayer1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView1)))
        imgPlayer2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView2)))
        imgPlayer3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView3)))
        imgPlayer4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView4)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSound(name: "xep tranh", Extension: "mp3")
    }
    
    @IBAction func actTronAnh(_ sender: Any) {
        playSound(name: "xep tranh", Extension: "mp3")
        setPosition(arrData: arrOrigin?.randomArr(arrSource: arrOrigin!) as! [CGPoint])
        
        imgPlayer1.isUserInteractionEnabled = true
        imgPlayer2.isUserInteractionEnabled = true
        imgPlayer3.isUserInteractionEnabled = true
        imgPlayer4.isUserInteractionEnabled = true
    }
    
    func showDialog()  {
        if flag == 4 {
            playSound(name: "ke lai day du", Extension: "wav")
            flag = 0
            imgPlayer1.isUserInteractionEnabled = false
            imgPlayer2.isUserInteractionEnabled = false
            imgPlayer3.isUserInteractionEnabled = false
            imgPlayer4.isUserInteractionEnabled = false

        }
    }

    
    func setPosition(arrData: [CGPoint]) {
        imgPlayer1.frame.origin = arrData[0]
        imgPlayer2.frame.origin = arrData[1]
        imgPlayer3.frame.origin = arrData[2]
        imgPlayer4.frame.origin = arrData[3]
        
        originPlayer1 = imgPlayer1.center
        originPlayer2 = imgPlayer2.center
        originPlayer3 = imgPlayer3.center
        originPlayer4 = imgPlayer4.center
    }
    
    func getPos() -> [CGPoint] {
        var arr = [CGPoint]()
        arr.append(imgPlayer1.frame.origin)
        arr.append(imgPlayer2.frame.origin)
        arr.append(imgPlayer3.frame.origin)
        arr.append(imgPlayer4.frame.origin)
        return arr
    }


    func autoLayout() {
        let screenHeight: CGFloat = self.view.frame.height
        let topMargin: CGFloat = screenHeight*0.25
        
        let paddingTarget: CGFloat = screenHeight*0.01
        
        let witdhPlayer: CGFloat = screenHeight*0.27
        let heightPlayer: CGFloat = witdhPlayer
        
//        let topMarginTarget: CGFloat = a!+50
        let witdhTarget: CGFloat = screenHeight*0.28
        let heightTarget: CGFloat = witdhTarget
        
        imgPlayer3.frame = CGRect(x: 0, y: topMargin, width: witdhPlayer, height: heightPlayer)
        imgPlayer3.center = CGPoint(x: self.view.center.x+imgPlayer3.frame.size.width/2+10, y: imgPlayer3.frame.origin.y)
        imgPlayer4.frame = CGRect(x: imgPlayer3.frame.maxX+10, y: imgPlayer3.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        
        imgPlayer1.frame = CGRect(x: 0, y: topMargin, width: witdhPlayer, height: heightPlayer)
        imgPlayer1.center = CGPoint(x: self.view.center.x-imgPlayer1.frame.size.width/2-10, y: imgPlayer1.frame.origin.y)
        imgPlayer2.frame = CGRect(x: imgPlayer1.frame.origin.x-witdhPlayer-10, y: imgPlayer1.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        
        imgTarget1.frame = CGRect(x: imgPlayer1.frame.origin.x-witdhPlayer-10-paddingTarget, y: imgPlayer1.frame.maxY+20, width: witdhTarget, height: heightTarget)
        imgTarget2.frame = CGRect(x: imgTarget1.frame.maxX+10, y: imgTarget1.frame.origin.y, width: witdhTarget, height: heightTarget)
        
        imgTarget3.frame = CGRect(x: imgTarget2.frame.maxX+10, y: imgTarget1.frame.origin.y, width: witdhTarget, height: heightTarget)
//        imgTarget3.center = CGPoint(x: self.view.center.x+imgTarget3.frame.size.width/2+10, y: imgTarget3.frame.origin.y)
        imgTarget4.frame = CGRect(x: imgTarget3.frame.maxX+10, y: imgTarget1.frame.origin.y, width: witdhTarget, height: heightTarget)
        
        
//        imgTarget5.frame = CGRect(x: imgTarget1.frame.origin.x, y: imgTarget3.frame.maxY+10, width: witdhTarget, height: heightTarget)
//        imgTarget6.frame = CGRect(x: imgTarget5.frame.maxX+10, y: imgTarget5.frame.origin.y, width: witdhTarget, height: heightTarget)
        
    }

    
    //MARK: 1
    func checkContaintView(view:UIView, frameTarget: UIView, frameOrigin: CGPoint) -> Bool {
        let temp = false
        if frameTarget.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget.center
//                self.playSound(name: "dung roi", Extension: "wav")
            }
            return true
        } else {
            UIView.animate(withDuration: 0.3) {
                view.center = frameOrigin
//                self.playSound(name: "thu cach khac", Extension: "wav")
            }
            return false
        }
    }
    
    func checkContaintView2(view:UIView, frameTarget1: UIView, frameTarget2: UIView, frameTarget3: UIView, frameTarget4: UIView, frameOrigin: CGPoint) -> Bool {
        var temp = false
        if frameTarget1.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget1.center
//                self.playSound(name: "dung roi", Extension: "wav")
//                self.flag += 1
            }
            temp = true
            
        } else if frameTarget2.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget2.center
//                self.playSound(name: "dung roi", Extension: "wav")
//                self.flag += 1
            }
            temp = true
            
        } else if frameTarget3.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget3.center
                //                self.playSound(name: "dung roi", Extension: "wav")
//                self.flag += 1
            }
            temp = true
            
        } else if frameTarget4.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget4.center
                //                self.playSound(name: "dung roi", Extension: "wav")
//                self.flag += 1
            }
           temp = true
        }
        
        
        else {
            UIView.animate(withDuration: 0.3) {
                view.center = frameOrigin
//                self.playSound(name: "thu cach khac", Extension: "wav")
            }
            return false
        }
        return temp
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

    
    //MARK: 2
    func dragView1(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameTarget4: imgTarget4, frameOrigin: originPlayer1!)
            if check {
                self.flag += 1
                imgPlayer1.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView2(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameTarget4: imgTarget4, frameOrigin: originPlayer2!)
            if check {
                self.flag += 1
                imgPlayer2.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView3(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameTarget4: imgTarget4, frameOrigin: originPlayer3!)
            if check {
                self.flag += 1
                imgPlayer3.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView4(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameTarget4: imgTarget4, frameOrigin: originPlayer4!)
            if check {
                self.flag += 1
                imgPlayer4.isUserInteractionEnabled = false
            }
        }
    }
}
