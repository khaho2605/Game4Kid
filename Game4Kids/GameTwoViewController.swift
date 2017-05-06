//
//  GameTwoViewController.swift
//  Game4Kids
//
//  Created by KHA on 12/13/16.
//  Copyright © 2016 Kha. All rights reserved.
//

import UIKit
import AVFoundation


class GameTwoViewController: UIViewController {
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var imgPlayer3: UIImageView!
    @IBOutlet weak var imgPlayer4: UIImageView!
    @IBOutlet weak var imgPlayer5: UIImageView!
    
    @IBOutlet weak var imgTarget1: UIImageView!
    @IBOutlet weak var imgTarget2: UIImageView!
    @IBOutlet weak var imgTarget3: UIImageView!
    @IBOutlet weak var imgTarget4: UIImageView!
    @IBOutlet weak var imgTarget5: UIImageView!
    @IBOutlet weak var imgTarget6: UIImageView!

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
        
        imgPlayer1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView)))
        imgPlayer2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView2)))
        imgPlayer3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView3)))
        imgPlayer4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView4)))
        imgPlayer5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView5)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSound(name: "xep tranh", Extension: "mp3")
        
    }
    
    @IBAction func btnTronAnh(_ sender: Any) {
        setPosition(arrData: arrOrigin?.randomArr(arrSource: arrOrigin!) as! [CGPoint])
        playSound(name: "xep tranh", Extension: "mp3")
        imgPlayer1.isUserInteractionEnabled = true
        imgPlayer2.isUserInteractionEnabled = true
        imgPlayer3.isUserInteractionEnabled = true
        imgPlayer4.isUserInteractionEnabled = true
        imgPlayer5.isUserInteractionEnabled = true
    }
    
    func autoLayout() {
        let screenHeight: CGFloat = self.view.frame.height
        let topMargin: CGFloat = screenHeight*0.2
    
        let witdhPlayer: CGFloat = screenHeight*0.2
        let heightPlayer: CGFloat = witdhPlayer
        
        let topMarginTarget: CGFloat = topMargin
        let witdhTarget: CGFloat = screenHeight*0.21
        let heightTarget: CGFloat = witdhTarget
        
        
        
        imgPlayer2.frame = CGRect(x: imgPlayer1.frame.maxX+10, y: topMargin, width: witdhPlayer, height: heightPlayer)
        imgPlayer2.center = CGPoint(x: self.view.center.x-imgPlayer2.frame.size.width/2-30, y: imgPlayer2.frame.origin.y)
        
        imgPlayer1.frame = CGRect(x: imgPlayer2.frame.origin.x-screenHeight*0.2-10, y: imgPlayer2.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer3.frame = CGRect(x: imgPlayer1.frame.origin.x, y: imgPlayer1.frame.maxY+10, width: witdhPlayer, height: heightPlayer)
        imgPlayer4.frame = CGRect(x: imgPlayer3.frame.maxX+10, y: imgPlayer3.frame.origin.y, width: witdhPlayer, height: heightPlayer)
        imgPlayer5.frame = CGRect(x: imgPlayer1.frame.origin.x, y: imgPlayer3.frame.maxY+10, width: witdhPlayer, height: heightPlayer)
        
        imgTarget1.frame = CGRect(x: imgPlayer2.frame.maxX+70, y: topMarginTarget, width: witdhTarget, height: heightTarget)
        imgTarget1.center = CGPoint(x: self.view.center.x+imgTarget1.frame.size.width/2+30, y: imgTarget1.frame.origin.y)
        
        imgTarget2.frame = CGRect(x: imgTarget1.frame.maxX+10, y: imgTarget1.frame.origin.y, width: witdhTarget, height: heightTarget)
        imgTarget3.frame = CGRect(x: imgTarget1.frame.origin.x, y: imgTarget1.frame.maxY+10, width: witdhTarget, height: heightTarget)
        imgTarget4.frame = CGRect(x: imgTarget3.frame.maxX+10, y: imgTarget3.frame.origin.y, width: witdhTarget, height: heightTarget)
        imgTarget5.frame = CGRect(x: imgTarget1.frame.origin.x, y: imgTarget3.frame.maxY+10, width: witdhTarget, height: heightTarget)
        imgTarget6.frame = CGRect(x: imgTarget5.frame.maxX+10, y: imgTarget5.frame.origin.y, width: witdhTarget, height: heightTarget)
        
        imgPlayer1.layer.cornerRadius = 5
        imgPlayer2.layer.cornerRadius = 5
        imgPlayer3.layer.cornerRadius = 5
        imgPlayer4.layer.cornerRadius = 5
        imgPlayer5.layer.cornerRadius = 5
        
        imgPlayer1.layer.masksToBounds = true
        imgPlayer2.layer.masksToBounds = true
        imgPlayer3.layer.masksToBounds = true
        imgPlayer4.layer.masksToBounds = true
        imgPlayer5.layer.masksToBounds = true
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
    
    //MARK: Show dialog
    func showDialog() {
        if flag == 5 {
            print("Value", flag)
            self.playSound(name: "thieu ket thuc", Extension: "wav")
            flag = 0
            
            imgPlayer1.isUserInteractionEnabled = false
            imgPlayer2.isUserInteractionEnabled = false
            imgPlayer3.isUserInteractionEnabled = false
            imgPlayer4.isUserInteractionEnabled = false
            imgPlayer5.isUserInteractionEnabled = false
        }
    }
    
    func setPosition(arrData: [CGPoint]) {
        imgPlayer1.frame.origin = arrData[0]
        imgPlayer2.frame.origin = arrData[1]
        imgPlayer3.frame.origin = arrData[2]
        imgPlayer4.frame.origin = arrData[3]
        imgPlayer5.frame.origin = arrData[4]
        
        originPlayer1 = imgPlayer1.center
        originPlayer2 = imgPlayer2.center
        originPlayer3 = imgPlayer3.center
        originPlayer4 = imgPlayer4.center
        originPlayer5 = imgPlayer5.center
    }
    
    //Get arr pos
    func getPos() -> [CGPoint] {
        var arr = [CGPoint]()
        arr.append(imgPlayer1.frame.origin)
        arr.append(imgPlayer2.frame.origin)
        arr.append(imgPlayer3.frame.origin)
        arr.append(imgPlayer4.frame.origin)
        arr.append(imgPlayer5.frame.origin)
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


