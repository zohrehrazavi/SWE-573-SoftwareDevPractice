//
//  Intro2ViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 15.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class Intro2ViewController: UIViewController {

    @IBOutlet weak var text_2: UITextView!
    @IBOutlet weak var text_1: UILabel!
    @IBOutlet weak var gif_image_view: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
 gif_image_view.loadGif(name: "tedavi_asamasi_gif")
        
        let ekran_genişliği = view.frame.width
        let ekran_yüksekliği = view.frame.height
        
        
        
        if ((ekran_genişliği == 320.0) && (ekran_yüksekliği == 568.0)){
            
            
            text_1.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 40)
            text_2.font = UIFont(name: "OpenSans", size: 19)
            
        }
        
    }
    

    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        
        
        
        if sender.state == .began {
            let vel = sender.velocity(in: view) // view is your UIView
            if vel.x > 0 {
                print("right")
                
               self.performSegue (withIdentifier: "ikiden_bire_1", sender: self)
                
                
            } else {
                print("left")
                
                 self.performSegue (withIdentifier: "ikiden_üçe", sender: self)
                
                
            }
        }
        
        
    }
    }
    

