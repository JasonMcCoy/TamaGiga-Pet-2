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
    let DIM_ALPHA: CGFloat = 0.4
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!

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
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
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
