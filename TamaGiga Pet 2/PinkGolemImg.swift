//
//  PingGolemImg.swift
//  TamaGiga Pet 2
//
//  Created by Jason McCoy on 6/29/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import Foundation
import UIKit

class PinkGolemImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "PinkgolemIdle1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for suffixNumber in 1...4 {
            let img = UIImage(named: "PinkgolemIdle\(suffixNumber).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "PinkgolemDeath1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for suffixNumber in 1...4 {
            let img = UIImage(named: "PinkgolemDeath\(suffixNumber).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
}
