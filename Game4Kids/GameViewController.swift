//
//  GameViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/13/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var imgPlayer3: UIImageView!
    @IBOutlet weak var imgPlayer4: UIImageView!
    @IBOutlet weak var imgPlayer5: UIImageView!
    @IBOutlet weak var imgPlayer6: UIImageView!
    
    
    @IBOutlet weak var imgTarget1: UIImageView!
    @IBOutlet weak var imgTarget2: UIImageView!
    @IBOutlet weak var imgTarget3: UIImageView!
    @IBOutlet weak var imgTarget4: UIImageView!
    @IBOutlet weak var imgTarget5: UIImageView!
    @IBOutlet weak var imgTarget6: UIImageView!
    @IBOutlet weak var btnReplay: UIButton!
    
    var originPlayer1:CGPoint?
    var originPlayer2:CGPoint?
    var originPlayer3:CGPoint?
    var originPlayer4:CGPoint?
    var originPlayer5:CGPoint?
    var originPlayer6:CGPoint?
    
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
        setPosition(arrData: arrOrigin?.randomArr(arrSource: arrOrigin!) as! [CGPoint])
        
        imgPlayer1.isUserInteractionEnabled = true
        imgPlayer2.isUserInteractionEnabled = true
        imgPlayer3.isUserInteractionEnabled = true
        imgPlayer4.isUserInteractionEnabled = true
        imgPlayer5.isUserInteractionEnabled = true
        imgPlayer6.isUserInteractionEnabled = true
        
        imgPlayer1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView)))
        imgPlayer2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView2)))
        imgPlayer3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView3)))
        imgPlayer4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView4)))
        imgPlayer5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView5)))
        imgPlayer6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView6)))

    }
    
    @IBAction func btnActReplay(_ sender: Any) {
        setPosition(arrData: arrOrigin?.randomArr(arrSource: arrOrigin!) as! [CGPoint])
        imgPlayer1.isUserInteractionEnabled = true
        imgPlayer2.isUserInteractionEnabled = true
        imgPlayer3.isUserInteractionEnabled = true
        imgPlayer4.isUserInteractionEnabled = true
        imgPlayer5.isUserInteractionEnabled = true
        imgPlayer6.isUserInteractionEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSound(name: "ve voi me", Extension: "wav")
    }
    
    func autoLayout() {
        
        let screenHeight: CGFloat = self.view.frame.height
        let screenWidth: CGFloat = self.view.frame.width
        let topMargin: CGFloat = screenHeight*0.22
        let witdhPlayer: CGFloat = screenHeight*0.2
        let heightPlayer: CGFloat = witdhPlayer
        
        let topMarginTarget: CGFloat = screenHeight*0.2
        let witdhTarget: CGFloat = screenHeight*0.23
        let heightTarget: CGFloat = witdhTarget
        
//        let paddingBtn: CGFloat = screenWidth*0.3
        let widthButton: CGFloat = screenWidth*0.2
        let heightButton: CGFloat = screenHeight*0.26

        imgPlayer3.frame = CGRect(x: 0, y: topMargin, width: witdhPlayer, height: heightPlayer)
        imgPlayer3.center = CGPoint(x: self.view.center.x-witdhPlayer/2, y: imgPlayer3.frame.origin.y)
        
        imgPlayer2.frame = CGRect(x: imgPlayer3.frame.origin.x-10-witdhPlayer, y: imgPlayer3.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer1.frame = CGRect(x: imgPlayer2.frame.origin.x-10-witdhPlayer, y: imgPlayer3.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        
        
        imgPlayer4.frame = CGRect(x: imgPlayer3.frame.maxX+10, y: imgPlayer1.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer5.frame = CGRect(x: imgPlayer4.frame.maxX+10, y: imgPlayer1.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer6.frame = CGRect(x: imgPlayer5.frame.maxX+10, y: imgPlayer1.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        
        imgPlayer1.layer.cornerRadius = 5
        imgPlayer2.layer.cornerRadius = 5
        imgPlayer3.layer.cornerRadius = 5
        imgPlayer4.layer.cornerRadius = 5
        imgPlayer5.layer.cornerRadius = 5
        imgPlayer6.layer.cornerRadius = 5

        
        imgTarget2.frame = CGRect(x: 0, y: imgPlayer1.frame.maxY+topMarginTarget, width: witdhTarget, height: heightTarget)
        imgTarget2.center = CGPoint(x: self.view.center.x, y: imgTarget2.frame.origin.y)
        
        imgTarget1.frame = CGRect(x: imgTarget2.frame.origin.x-10-witdhTarget, y: imgTarget2.frame.origin.y, width: witdhTarget, height: heightTarget)
        
        imgTarget3.frame = CGRect(x: imgTarget2.frame.maxX+10, y: imgTarget2.frame.origin.y, width: witdhTarget, height: heightTarget)
        imgTarget4.frame = CGRect(x: imgTarget1.frame.origin.x, y: imgTarget1.frame.maxY+10, width: witdhTarget, height: heightTarget)
        imgTarget5.frame = CGRect(x: imgTarget4.frame.maxX+10, y: imgTarget4.frame.origin.y, width: witdhTarget, height: heightTarget)
        imgTarget6.frame = CGRect(x: imgTarget5.frame.maxX+10, y: imgTarget4.frame.origin.y, width: witdhTarget, height: heightTarget)

        btnReplay.frame = CGRect(x: imgTarget6.frame.maxX+20, y: imgTarget6.frame.origin.y, width: widthButton, height: heightButton)
        btnReplay.layer.cornerRadius = 10
        btnReplay.titleLabel?.adjustsFontSizeToFitWidth = true
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
    
    func playDongVai() {
        playSound(name: "dong vai", Extension: "wav")
    }

    //MARK: Show dialog
    func showDialog() {
        if flag == 6 {
            print("Value", flag)
            playSound(name: "be that gioi", Extension: "wav")
            flag = 0
            imgPlayer1.isUserInteractionEnabled = false
            imgPlayer2.isUserInteractionEnabled = false
            imgPlayer3.isUserInteractionEnabled = false
            imgPlayer4.isUserInteractionEnabled = false
            imgPlayer5.isUserInteractionEnabled = false
            imgPlayer6.isUserInteractionEnabled = false
            
            _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.playDongVai), userInfo: nil, repeats: false);
        }
    }

    func setPosition(arrData: [CGPoint]) {
        imgPlayer1.frame.origin = arrData[0]
        imgPlayer2.frame.origin = arrData[1]
        imgPlayer3.frame.origin = arrData[2]
        imgPlayer4.frame.origin = arrData[3]
        imgPlayer5.frame.origin = arrData[4]
        imgPlayer6.frame.origin = arrData[5]
        
        originPlayer1 = imgPlayer1.center
        originPlayer2 = imgPlayer2.center
        originPlayer3 = imgPlayer3.center
        originPlayer4 = imgPlayer4.center
        originPlayer5 = imgPlayer5.center
        originPlayer6 = imgPlayer6.center
    }
    
    //Get arr posX
    func getPos() -> [CGPoint] {
        var arr = [CGPoint]()
        arr.append(imgPlayer1.frame.origin)
        arr.append(imgPlayer2.frame.origin)
        arr.append(imgPlayer3.frame.origin)
        arr.append(imgPlayer4.frame.origin)
        arr.append(imgPlayer5.frame.origin)
        arr.append(imgPlayer6.frame.origin)
        
        return arr
    }
    
    //MARK: 1
    func checkContaintView(view:UIView, frameTarget: UIView, frameOrigin: CGPoint) -> Bool {
        
        if frameTarget.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget.center
                self.playSound(name: "dung roi", Extension: "wav")
            }
            return true
        } else {
            UIView.animate(withDuration: 0.3) {
                view.center = frameOrigin
                self.playSound(name: "thu cach khac", Extension: "wav")
            }
            return false
        }
    }
    
    //MARK: 2
    func dragView(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView(view: recognizer.view!, frameTarget: imgTarget1, frameOrigin: originPlayer1!)
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
            let check = checkContaintView(view: recognizer.view!, frameTarget: imgTarget2, frameOrigin: originPlayer2!)
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
            let check = checkContaintView(view: recognizer.view!, frameTarget: imgTarget3, frameOrigin: originPlayer3!)
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
            let check = checkContaintView(view: recognizer.view!, frameTarget: imgTarget4, frameOrigin: originPlayer4!)
            if check {
                self.flag += 1
                imgPlayer4.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView5(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView(view: recognizer.view!, frameTarget: imgTarget5, frameOrigin: originPlayer5!)
            if check {
                self.flag += 1
                imgPlayer5.isUserInteractionEnabled = false
            }
        }
    }
    
    func dragView6(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView(view: recognizer.view!, frameTarget: imgTarget6, frameOrigin: originPlayer6!)
            if check {
                self.flag += 1
                imgPlayer6.isUserInteractionEnabled = false
            }
        }
    }
}
