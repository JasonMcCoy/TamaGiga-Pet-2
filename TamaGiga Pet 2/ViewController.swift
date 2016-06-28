//
//  ViewController.swift
//  TamaGiga Pet 2
//
//  Created by Jason McCoy on 6/26/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redGolem: UIImageView!
    @IBOutlet weak var redGolemHeart: DragAnimation!
    @IBOutlet weak var redGolemMeat: DragAnimation!
    @IBOutlet weak var redGolemStalactite: DragAnimation!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imgArray = [UIImage]()
        
        for suffixNumber in 1...4 {
            let img = UIImage(named: "golemIdle\(suffixNumber).png")
            imgArray.append(img!)
        }
        
        redGolem.animationImages = imgArray
        redGolem.animationDuration = 0.8
        redGolem.animationRepeatCount = 0
        redGolem.startAnimating()
        
    }
    
    
    //Im Assuming you didn't want the status bar
    /* Hide Status Bar */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /* End Hide Status Bar */

}
