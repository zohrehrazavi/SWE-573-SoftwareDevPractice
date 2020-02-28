//
//  Intro1.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 15.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class Intro1: UIViewController  {

   
    @IBOutlet weak var gif_image_view: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gif_image_view.loadGif(name: "kilo_gif")
        
       
        
       /* let ekran_genişliği = view.frame.width
        
        imageView.frame = CGRect(x: 100, y: 202, width: 100, height: 1000 * 0.3)
 
 */



        
    }
    
    
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        
        
        
        if sender.state == .began {
            let vel = sender.velocity(in: view) // view is your UIView
            if vel.x < 0 {
                print("left")
                
                self.performSegue (withIdentifier: "birden_ikiye_1", sender: self)
                
                
            } else {
                print("right")
                
                
            }
        }
        
        
    }
    
}



