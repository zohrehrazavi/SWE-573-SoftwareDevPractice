//
//  LoginViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 22.01.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit
import  Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goz_image_view: UIImageView!
    @IBOutlet weak var kilt_icon: UIImageView!
    @IBOutlet weak var mail_icon: UIImageView!
    @IBOutlet weak var sign_in_button: UIButton!
    @IBOutlet weak var password_text_field: UITextField!
    @IBOutlet weak var e_mail_text_field: UITextField!
    
    @IBOutlet weak var forgot_button: UIButton!
    
    @IBOutlet weak var login_error_label: UILabel!
    
    @IBOutlet weak var goz_button: UIButton!
    
    
    var goz_kontrol = false
    
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        
        
        activityIndicator.color = UIColor.black
        activityIndicator.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        
       
        
        
       
        
       
        
        login_error_label.isHidden = true
       
        e_mail_text_field.layer.cornerRadius = 30.0
        password_text_field.layer.cornerRadius=30.0
        
        sign_in_button.layer.cornerRadius=30.0
       
        
        e_mail_text_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: e_mail_text_field.frame.height))
        e_mail_text_field.leftViewMode = .always
        
        password_text_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: password_text_field.frame.height))
        password_text_field.leftViewMode = .always
        
        
        e_mail_text_field.addTarget(self, action: #selector(e_mail_func), for: .editingDidBegin)
        
      

        password_text_field.addTarget(self, action: #selector(pas_func), for: .editingDidBegin)
        
        
      
        e_mail_text_field.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

       
    }
    
   
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        if e_mail_text_field.text!.isEmpty {
            print("enter email address") //prompt ALert or toast
        }
        else if self.isValidEmail(testStr: e_mail_text_field.text!) {
            print("Geçerli") // prompt alert for invalid email
            
            mail_icon.image = UIImage(named: "mail_turuncu")
            
             sign_in_button.backgroundColor = UIColor(red: 255/255, green: 116/255, blue: 79/255, alpha: 1)

        }
        else {
            
            print("Geçersiz") // prompt alert for invalid email

            }
        
        
       
    }
    
    
   
    @objc func e_mail_func(textField: UITextField) {
        e_mail_text_field.placeholder = ""
        
       

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
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        
       
        
        return emailTest.evaluate(with: testStr)
    }

    @IBAction func goz_action(_ sender: Any) {
        
       
        if goz_kontrol == false {
            goz_kontrol = true

            password_text_field.isSecureTextEntry = false
            
            goz_button.setImage(UIImage(named: "goz_turuncu"), for: UIControlState.normal)

        }
        else if goz_kontrol == true  {
            
            goz_kontrol = false
            
            password_text_field.isSecureTextEntry = true
            goz_button.setImage(UIImage(named: "goz"), for: UIControlState.normal)

            }
        
        
        
        
        
    }
    
    @IBAction func login_action(_ sender: Any) {
        
        
        
        
        if e_mail_text_field.text != "" && password_text_field.text != "" {
            
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            PFUser.logInWithUsername(inBackground: e_mail_text_field.text!, password: password_text_field.text!) { (user, error) in
                
                if error != nil {
                    
                    self.activityIndicator.stopAnimating()

                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                } else {
                    
                    self.performSegue(withIdentifier: "login_video_segue", sender: nil)

                    
                }
                
            }
            
            
        } else {
            let alert = UIAlertController(title: "Error", message: "username/password needed", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        
        
        
}
    
  
    
  }
        


    
    


