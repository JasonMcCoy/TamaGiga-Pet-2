//
//  ViewController.swift
//  TamaGiga Pet 2
//
//  Created by Jason McCoy on 6/26/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var redGolem: GolemImg!
    @IBOutlet weak var redGolemHeart: DragAnimation!
    @IBOutlet weak var redGolemMeat: DragAnimation!
    @IBOutlet weak var redGolemStalactite: DragAnimation!
    @IBOutlet weak var pinkGolem: PinkGolemImg!
    @IBOutlet weak var penaltySkullImg1: UIImageView!
    @IBOutlet weak var penaltySkullImg2: UIImageView!
    @IBOutlet weak var penaltySkullImg3: UIImageView!
    @IBOutlet weak var livesPanel: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var redGolemBtn: UIButton!
    @IBOutlet weak var redGolemBtnTxt: UILabel!
    @IBOutlet weak var pinkGolemBtn: UIButton!
    @IBOutlet weak var pinkGolemBtnTxt: UILabel!
    @IBOutlet weak var chooseMonsterLabel: UIImageView!
    @IBOutlet weak var monsterLabelText: UILabel!
    @IBOutlet weak var heartTxtLbl: UILabel!
    @IBOutlet weak var meatTxtLbl: UILabel!
    @IBOutlet weak var stalactiteTxtLbl: UILabel!
    
    
    @IBAction func restartBtn(_ sender: AnyObject) {
        
        penalties = 0
        monsterHappy = false
        currentItem = 0
        
        penaltySkullImg1.isHidden = false
        penaltySkullImg2.isHidden = false
        penaltySkullImg3.isHidden = false
        penaltySkullImg1.alpha = DIM_ALPHA
        penaltySkullImg2.alpha = DIM_ALPHA
        penaltySkullImg3.alpha = DIM_ALPHA
        
        redGolem.playIdleAnimation()
        pinkGolem.playIdleAnimation()
        
        restartBtn.isHidden = true
        startGame()
        
    }
    
    @IBAction func redGolemBtn(_ sender: AnyObject) {
        
        maleGolemChosen = true
        femaleGolemChosen = false
        chooseMonsterLabel.isHidden = true
        monsterLabelText.isHidden = true
        redGolemBtn.isHidden = true
        redGolemBtnTxt.isHidden = true
        pinkGolemBtn.isHidden = true
        pinkGolemBtnTxt.isHidden = true
        redGolem.playIdleAnimation()
        chooseMonster()
        
    }
    
    @IBAction func pinkGolemBtn(_ sender: AnyObject) {
        
        maleGolemChosen = false
        femaleGolemChosen = true
        chooseMonsterLabel.isHidden = true
        monsterLabelText.isHidden = true
        redGolemBtn.isHidden = true
        redGolemBtnTxt.isHidden = true
        pinkGolemBtn.isHidden = true
        pinkGolemBtnTxt.isHidden = true
        pinkGolem.playIdleAnimation()
        chooseMonster()
        
    }
    
    
    let OPAQUE: CGFloat = 1.0
    let DIM_ALPHA: CGFloat = 0
    let DIM_ALPHA2: CGFloat = 0.3
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    var maleGolemChosen: Bool?
    var femaleGolemChosen: Bool?
    
    var sfxBGMusic: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxStalactite: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        penaltySkullImg1.isHidden = true
        penaltySkullImg2.isHidden = true
        penaltySkullImg3.isHidden = true
        restartBtn.isHidden = true
    }
    
    func chooseMonster() {
        if maleGolemChosen == true {
            redGolemMeat.alpha = DIM_ALPHA2
            redGolemMeat.isUserInteractionEnabled = false
            redGolemStalactite.alpha = DIM_ALPHA2
            redGolemStalactite.isUserInteractionEnabled = false
            redGolemHeart.dropTarget = redGolem
            redGolemMeat.dropTarget = redGolem
            redGolemStalactite.dropTarget = redGolem
            penaltySkullImg1.isHidden = false
            penaltySkullImg2.isHidden = false
            penaltySkullImg3.isHidden = false
            penaltySkullImg1.alpha = DIM_ALPHA
            penaltySkullImg2.alpha = DIM_ALPHA
            penaltySkullImg3.alpha = DIM_ALPHA
        } else if femaleGolemChosen == true {
            redGolemMeat.alpha = DIM_ALPHA2
            redGolemMeat.isUserInteractionEnabled = false
            redGolemStalactite.alpha = DIM_ALPHA2
            redGolemStalactite.isUserInteractionEnabled = false
            redGolemHeart.dropTarget = pinkGolem
            redGolemMeat.dropTarget = pinkGolem
            redGolemStalactite.dropTarget = pinkGolem
            penaltySkullImg1.isHidden = false
            penaltySkullImg2.isHidden = false
            penaltySkullImg3.isHidden = false
            penaltySkullImg1.alpha = DIM_ALPHA
            penaltySkullImg2.alpha = DIM_ALPHA
            penaltySkullImg3.alpha = DIM_ALPHA
            redGolem.isHidden = true
            pinkGolem.isHidden = false
            pinkGolem.playIdleAnimation()
        }
        
        startGame()
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        redGolemMeat.alpha = DIM_ALPHA2
        redGolemMeat.isUserInteractionEnabled = false
        redGolemHeart.alpha = DIM_ALPHA2
        redGolemHeart.isUserInteractionEnabled = false
        redGolemStalactite.alpha = DIM_ALPHA2
        redGolemStalactite.isUserInteractionEnabled = false
        
        if currentItem == 0 { // 0 means the Heart food is playable and the other foods are not.
            sfxHeart.play()
        } else if currentItem == 1 { // 1 means the Meat food is playable and the other foods are not.
            sfxBite.play()
        } else if currentItem == 2 { // 2 means the Stalactite food is playable and the other foods are not.
            sfxStalactite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
        timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func restartTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.restartButton), userInfo: nil, repeats: true)
    }
    
    func restartButton() {
        restartBtn.isHidden = false
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            penalties += 1
            
            sfxSkull.play()
        
        if penalties == 1 {
            penaltySkullImg1.alpha = OPAQUE
            penaltySkullImg2.alpha = DIM_ALPHA
        } else if penalties == 2 {
            penaltySkullImg2.alpha = OPAQUE
            penaltySkullImg3.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            penaltySkullImg3.alpha = OPAQUE
        } else {
            penaltySkullImg1.alpha = DIM_ALPHA
            penaltySkullImg2.alpha = DIM_ALPHA
            penaltySkullImg3.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
        
        let rand = arc4random_uniform(3)
        
        if rand == 0 { // 0 means the Heart food is playable and the other foods are not.
            redGolemHeart.alpha = OPAQUE
            redGolemHeart.isUserInteractionEnabled = true
            
            redGolemMeat.alpha = DIM_ALPHA2
            redGolemMeat.isUserInteractionEnabled = false
            
            redGolemStalactite.alpha = DIM_ALPHA2
            redGolemStalactite.isUserInteractionEnabled = false
        } else if rand == 1 { // 1 means the Meat food is playable and the other foods are not.
            redGolemHeart.alpha = DIM_ALPHA2
            redGolemHeart.isUserInteractionEnabled = false
            
            redGolemMeat.alpha = OPAQUE
            redGolemMeat.isUserInteractionEnabled = true
            
            redGolemStalactite.alpha = DIM_ALPHA2
            redGolemStalactite.isUserInteractionEnabled = false
        } else if rand == 2 { // 2 means the Stalactite food is playable and the other foods are not.
            redGolemHeart.alpha = DIM_ALPHA2
            redGolemHeart.isUserInteractionEnabled = false
            
            redGolemMeat.alpha = DIM_ALPHA2
            redGolemMeat.isUserInteractionEnabled = false
            
            redGolemStalactite.alpha = OPAQUE
            redGolemStalactite.isUserInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func startGame() {
        NotificationCenter.default.addObserver(self, selector: #selector(itemDroppedOnCharacter), name: "onTargetDropped" as NSNotification.Name, object: nil)
        
        do {
            
            try sfxBGMusic = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bgmusic", ofType: "mp3")!))
            try sfxSkull = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "skull", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "heart", ofType: "wav")!))
            try sfxBite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bite", ofType: "wav")!))
            try sfxStalactite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "stalactite", ofType: "mp3")!))
            try sfxDeath = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "death", ofType: "wav")!))
            
            sfxBGMusic.prepareToPlay()
            sfxBGMusic.play()
            
            sfxSkull.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxStalactite.prepareToPlay()
            sfxDeath.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }
    
    func gameOver() {
        timer.invalidate()
        redGolem.playDeathAnimation()
        pinkGolem.playDeathAnimation()
        sfxDeath.play()
        restartTimer()
    }
    
    /* Hide Status Bar */
    func prefersStatusBarHidden() -> Bool {
        return true
    }
    /* End Hide Status Bar */

}
