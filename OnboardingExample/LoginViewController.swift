//
//  LoginViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 22.01.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goz_icon: UIImageView!
    @IBOutlet weak var kilt_icon: UIImageView!
    @IBOutlet weak var mail_icon: UIImageView!
    @IBOutlet weak var sign_in_button: UIButton!
    @IBOutlet weak var password_text_field: UITextField!
    @IBOutlet weak var e_mail_text_field: UITextField!
    
    @IBOutlet weak var forgot_button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
       
        e_mail_text_field.layer.cornerRadius = 30.0
        password_text_field.layer.cornerRadius=30.0
        sign_in_button.layer.cornerRadius=30.0
       
        
        e_mail_text_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: e_mail_text_field.frame.height))
        e_mail_text_field.leftViewMode = .always
        
        password_text_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: password_text_field.frame.height))
        password_text_field.leftViewMode = .always
        
        
        e_mail_text_field.addTarget(self, action: #selector(e_mail_func), for: .editingDidBegin)
        
      

        password_text_field.addTarget(self, action: #selector(pas_func), for: .editingDidBegin)
        
        
      
        
       
    }
    
   
    
   
    @objc func e_mail_func(textField: UITextField) {
        e_mail_text_field.placeholder = ""
        
        sign_in_button.backgroundColor = UIColor(red: 255/255, green: 116/255, blue: 79/255, alpha: 1)

    }
    
    


    
    
    @objc func pas_func(textField: UITextField) {
        password_text_field.placeholder = ""
        
        sign_in_button.backgroundColor = UIColor(red: 255/255, green: 116/255, blue: 79/255, alpha: 1)
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        e_mail_text_field.resignFirstResponder()
        
        password_text_field.resignFirstResponder()

        
        return true
    }
    
    
    
    

}


