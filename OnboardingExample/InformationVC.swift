//
//  InformationVC.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 9.03.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
}
    
    @IBAction func web_button(_ sender: Any) {
        
        if let url = NSURL(string: "http://www.hemlibra.com") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
}


