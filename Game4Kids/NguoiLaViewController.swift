//
//  NguoiLaViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/17/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation

class NguoiLaViewController: UIViewController {
    
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var imgPlayer3: UIImageView!
    @IBOutlet weak var imgPlayer4: UIImageView!
    @IBOutlet weak var imgPlayer5: UIImageView!
    @IBOutlet weak var imgPlayer6: UIImageView!
    
    @IBOutlet weak var imgTarget1: UIImageView!
    @IBOutlet weak var imgTarget2: UIImageView!
    @IBOutlet weak var imgTarget3: UIImageView!
    @IBOutlet weak var btnTronAnh: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    
    var originPlayer1:CGPoint?
    var originPlayer2:CGPoint?
    var originPlayer3:CGPoint?
    var originPlayer4:CGPoint?
    var originPlayer5:CGPoint?
    var originPlayer6:CGPoint?
    
    var player: AVAudioPlayer?
    
    var arrOrigin: [CGPoint]?

    var flag: Int = 0 {
        didSet {
            showDialog()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        autoLayout()
        setUserInterface(flag: true)
        arrOrigin = getPos()
        
        setPosition(arrData: arrOrigin?.randomArr(arrSource: arrOrigin!) as! [CGPoint])
        
        imgPlayer1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView1)))
        imgPlayer2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView2)))
        imgPlayer3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView3)))
        
        imgPlayer4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView4)))
        imgPlayer5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView5)))
        imgPlayer6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView6)))

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSound(name: "noi cac tranh", Extension: "wav")
    }

    @IBAction func actTronAnh(_ sender: Any) {
        playSound(name: "noi cac tranh", Extension: "wav")
        setPosition(arrData: arrOrigin?.randomArr(arrSource: arrOrigin!) as! [CGPoint])
        setUserInterface(flag: true)

        imgPlayer4.isHidden = false
        imgPlayer5.isHidden = false
        imgPlayer6.isHidden = false
    }
    
    func showDialog()  {
        if flag == 3 {
            playSound(name: "nhin tranh va ke", Extension: "wav")
            imgPlayer4.isHidden = true
            imgPlayer5.isHidden = true
            imgPlayer6.isHidden = true
            flag = 0
            setUserInterface(flag: false)
        }
    }
    
    func autoLayout() {
        let screenHeight: CGFloat = self.view.frame.height
        let topMargin: CGFloat = screenHeight*0.2 + lbTitle.frame.height+10
        
        let paddingTarget: CGFloat = 60
        
        let witdhPlayer: CGFloat = screenHeight*0.2
        let heightPlayer: CGFloat = witdhPlayer
        
        let witdhTarget: CGFloat = screenHeight*0.25
        let heightTarget: CGFloat = witdhTarget
        
        let hButton: CGFloat = screenHeight*0.15
        let wButton: CGFloat = self.view.frame.width*0.4
        
        let posX: CGFloat = topMargin + heightPlayer + 50
        
        imgPlayer3.frame = CGRect(x: 0, y: topMargin, width: witdhPlayer, height: heightPlayer)
        imgPlayer3.center = CGPoint(x: self.view.center.x-witdhPlayer/2-10, y: imgPlayer3.frame.origin.y)
        
        imgPlayer2.frame = CGRect(x: imgPlayer3.frame.origin.x-witdhPlayer-10, y: imgPlayer3.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer1.frame = CGRect(x: imgPlayer2.frame.origin.x-witdhPlayer-10, y: imgPlayer3.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        
        
        imgPlayer4.frame = CGRect(x: 0, y: topMargin, width: witdhPlayer, height: heightPlayer)
        imgPlayer4.center = CGPoint(x: self.view.center.x+witdhPlayer/2+10, y: imgPlayer4.frame.origin.y)
        
        imgPlayer5.frame = CGRect(x: imgPlayer4.frame.maxX+10, y: imgPlayer1.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer6.frame = CGRect(x: imgPlayer5.frame.maxX+10, y: imgPlayer1.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        
        imgTarget2.frame = CGRect(x: 0, y: posX, width: witdhTarget, height: heightTarget)
        imgTarget2.center = CGPoint(x: self.view.center.x, y: imgTarget2.frame.origin.y)
        let posXTarget1: CGFloat = imgTarget2.frame.origin.x - paddingTarget - witdhTarget
        imgTarget1.frame = CGRect(x: posXTarget1, y: imgTarget2.frame.origin.y, width: witdhTarget, height: heightTarget)
        imgTarget3.frame = CGRect(x: imgTarget2.frame.maxX+paddingTarget, y: imgTarget2.frame.origin.y, width: witdhTarget, height: heightTarget)
        
        btnTronAnh.frame = CGRect(x: btnTronAnh.frame.origin.x, y: imgTarget2.frame.maxY+40, width: wButton, height: hButton)
        btnTronAnh.center = CGPoint(x: imgTarget2.center.x, y: imgTarget2.frame.maxY+40)
        
        lbTitle.adjustsFontSizeToFitWidth = true

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
        imgPlayer1.isUserInteractionEnabled = flag
        imgPlayer2.isUserInteractionEnabled = flag
        imgPlayer3.isUserInteractionEnabled = flag
        imgPlayer4.isUserInteractionEnabled = flag
        imgPlayer5.isUserInteractionEnabled = flag
        imgPlayer6.isUserInteractionEnabled = flag
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
    
    //Get arr pos
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
    
    func checkContaintView2(view:UIView, frameTarget1: UIView, frameTarget2: UIView, frameTarget3: UIView, frameOrigin: CGPoint) ->Bool {
        var temp = false
        if frameTarget1.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget1.center
                self.playSound(name: "dung roi", Extension: "wav")
            }
            temp = true
            
        } else if frameTarget2.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget2.center
                self.playSound(name: "dung roi", Extension: "wav")
            }
            temp = true
            
        } else if frameTarget3.frame.contains(view.center) {
            UIView.animate(withDuration: 0.3) {
                view.center = frameTarget3.center
                self.playSound(name: "dung roi", Extension: "wav")
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
    
    func checkContaintViewOrigin(view:UIView, frameOrigin: CGPoint) {
        UIView.animate(withDuration: 0.3) {
            view.center = frameOrigin
            self.playSound(name: "thu cach khac", Extension: "wav")
        }
    }
    
    func dragView1(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameOrigin: originPlayer1!)
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
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameOrigin: originPlayer2!)
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
            let check = checkContaintView2(view: recognizer.view!, frameTarget1: imgTarget1, frameTarget2: imgTarget2, frameTarget3: imgTarget3, frameOrigin: originPlayer3!)
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
            checkContaintViewOrigin(view: recognizer.view!, frameOrigin: originPlayer4!)
        }
    }
    
    func dragView5(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            checkContaintViewOrigin(view: recognizer.view!, frameOrigin: originPlayer5!)
        }
    }
    
    func dragView6(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            checkContaintViewOrigin(view: recognizer.view!, frameOrigin: originPlayer6!)
        }
    }
}
