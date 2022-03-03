//
//  ViewController.swift
//  KennyYakala
//
//  Created by Asilcan Çetinkaya on 2.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var volkiArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highSocreLabel: UILabel!
    @IBOutlet weak var volk1: UIImageView!
    @IBOutlet weak var volk2: UIImageView!
    @IBOutlet weak var volk3: UIImageView!
    @IBOutlet weak var volk4: UIImageView!
    @IBOutlet weak var volk5: UIImageView!
    @IBOutlet weak var volk6: UIImageView!
    @IBOutlet weak var volk7: UIImageView!
    @IBOutlet weak var volk8: UIImageView!
    @IBOutlet weak var volk9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highSocreLabel.text = "HighScore : \(highScore)"
            
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highSocreLabel.text = "Highscore : \(highScore)"
            
        }
        
        
        volk1 .isUserInteractionEnabled = true
        volk2 .isUserInteractionEnabled = true
        volk3 .isUserInteractionEnabled = true
        volk4 .isUserInteractionEnabled = true
        volk5 .isUserInteractionEnabled = true
        volk6 .isUserInteractionEnabled = true
        volk7 .isUserInteractionEnabled = true
        volk8 .isUserInteractionEnabled = true
        volk9 .isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        volk1.addGestureRecognizer(recognizer1)
        volk2.addGestureRecognizer(recognizer2)
        volk3.addGestureRecognizer(recognizer3)
        volk4.addGestureRecognizer(recognizer4)
        volk5.addGestureRecognizer(recognizer5)
        volk6.addGestureRecognizer(recognizer6)
        volk7.addGestureRecognizer(recognizer7)
        volk8.addGestureRecognizer(recognizer8)
        volk9.addGestureRecognizer(recognizer9)
        
        
        volkiArray = [volk1, volk2 , volk3 , volk4 , volk5 , volk6 , volk7 , volk8 , volk9]
        
        
        
        
        counter = 30
        timeLabel.text = String(counter)
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(hideVolk), userInfo: nil, repeats: true)
        
        hideVolk()
        
   
    }
    
    @objc  func hideVolk() {
        
        for volk in volkiArray {
            volk.isHidden = true
        }
        
       let random = Int(arc4random_uniform(UInt32(volkiArray.count - 1)))
        volkiArray[random].isHidden = false
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
        
    }
    
    @objc func timerFunction(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for volk in volkiArray {
                volk.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highSocreLabel.text = "HighScore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore ")
            }
            
            
            let allert = UIAlertController(title: "Time's Over", message: "Play Again ?", preferredStyle:UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                //replay func
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                
                self.score = 0
                self.scoreLabel.text = " Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer(timeInterval: 1, target: self, selector: #selector(self.hideVolk), userInfo: nil, repeats: true)
                
            }
            
            allert.addAction(okButton)
            allert.addAction(replayButton)
            self.present(allert, animated: true, completion: nil)
            
        }
       
    }

}

