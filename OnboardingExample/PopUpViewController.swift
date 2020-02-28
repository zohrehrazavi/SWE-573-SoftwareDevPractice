//
//  PopUpViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 15.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var arka_view: UIView!
    @IBOutlet weak var ok_button: UIButton!
    @IBOutlet weak var cancel_button: UIButton!
    @IBOutlet weak var q_4_button: UIButton!
    @IBOutlet weak var q_3_button: UIButton!
    @IBOutlet weak var q_2_button: UIButton!
    @IBOutlet weak var ana_view: UIView!
    @IBOutlet weak var üst_view: UIView!
    @IBOutlet weak var q_1_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ana_view.layer.cornerRadius = 5
        üst_view.layer.cornerRadius = 5
        ana_view.layer.borderWidth = 1
        ana_view.layer.borderColor = UIColor.white.cgColor
        
        
        q_1_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_1_button.layer.borderWidth = 0.5
        
        
        q_2_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_2_button.layer.borderWidth = 0.5
        
        
        
        q_3_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_3_button.layer.borderWidth = 0.5
        
        
        q_4_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_4_button.layer.borderWidth = 0.5
        
        
        
        
        cancel_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        cancel_button.layer.borderWidth = 1
        cancel_button.layer.cornerRadius = 5
        
        
       
        ok_button.layer.cornerRadius = 5
        
        
        
    }
    
    
    
    @IBAction func cancel_action(_ sender: Any) {
        
        ana_view.isHidden = true
        
        arka_view.layer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 5.0).cgColor

        
    }
    
    
    


}
