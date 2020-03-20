//
//  ForgotPassword.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 8.03.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit
import Parse

class ForgotPassword: UIViewController {

    @IBOutlet weak var error_text: UILabel!
    @IBOutlet weak var send_e_mail: UIButton!
    @IBOutlet weak var e_mail_text_field: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        error_text.isHidden = true
        
        e_mail_text_field.layer.cornerRadius = 30.0
        
        send_e_mail.layer.cornerRadius = 30.0
        
        e_mail_text_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: e_mail_text_field.frame.height))
        e_mail_text_field.leftViewMode = .always
        
        

        
    }
    
    @IBAction func send_e_mail_action(_ sender: Any) {
        
       
        PFUser.requestPasswordResetForEmail(inBackground: e_mail_text_field.text ?? "as", block: { (success, error) -> Void in
            if error == nil {
                
               
                
                self.error_text.isHidden = false
                
                self.error_text.text = "E-mail sent, check your inbox..."
                
            } else {
                
                
                self.error_text.isHidden = false
                self.error_text.text = error?.localizedDescription
                
                
            }
        })
        
        
    }
    
}
