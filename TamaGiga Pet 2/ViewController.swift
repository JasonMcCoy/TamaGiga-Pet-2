//
//  ViewController.swift
//  TamaGiga Pet 2
//
//  Created by Jason McCoy on 6/26/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redGolem: GolemImg!
    @IBOutlet weak var redGolemHeart: DragAnimation!
    @IBOutlet weak var redGolemMeat: DragAnimation!
    @IBOutlet weak var redGolemStalactite: DragAnimation!
    @IBOutlet weak var pinkGolem: PinkGolemImg!
    @IBOutlet weak var penaltySkullImg1: UIImageView!
    @IBOutlet weak var penaltySkullImg2: UIImageView!
    @IBOutlet weak var penaltySkullImg3: UIImageView!
    
    
    let OPAQUE: CGFloat = 1.0
    let DIM_ALPHA: CGFloat = 0
    let DIM_ALPHA2: CGFloat = 0.3
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!
    var monsterHappy = false
    var currentItem: UInt32 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redGolemHeart.dropTarget = redGolem
        redGolemMeat.dropTarget = redGolem
        redGolemStalactite.dropTarget = redGolem
        redGolemHeart.dropTarget = pinkGolem
        redGolemMeat.dropTarget = pinkGolem
        redGolemStalactite.dropTarget = pinkGolem
        
        penaltySkullImg1.alpha = DIM_ALPHA
        penaltySkullImg2.alpha = DIM_ALPHA
        penaltySkullImg3.alpha = DIM_ALPHA
        
        NotificationCenter.default().addObserver(self, selector: #selector(itemDroppedOnCharacter), name: "onTargetDropped", object: nil)
        
        startTimer()
        
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
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
                    penalties += 1
        
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
    
    func gameOver() {
        timer.invalidate()
        redGolem.playDeathAnimation()
        pinkGolem.playDeathAnimation()
    }
    
    /* Hide Status Bar */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /* End Hide Status Bar */

}
