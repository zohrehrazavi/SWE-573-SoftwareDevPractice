//
//  SplashViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 4.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit
import Parse



class SplashViewController: UIViewController  {

    var splash_bool = false

    @IBOutlet weak var image_gif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image_gif.loadGif(name: "loa_gif")
        
      
        
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
        
            let defaults = UserDefaults.standard
            
            
            
            if CheckInternet.Connection(){
                
                self.splash_bool = defaults.bool(forKey: "splash_bool")
                
                if self.splash_bool == true{
                    
                    
                    let user = PFUser.current()
                    if user == nil
                    {
                        
                         self.performSegue (withIdentifier: "splashden_logine", sender: self)
                    }
                    else
                    {
                        self.performSegue(withIdentifier: "splash_ana", sender: nil)
                        
                    }
                    
                    
                   

                    
                }else{
                    
                    
                    self.performSegue (withIdentifier: "splashden_introya", sender: self)
                    defaults.set(true, forKey: "splash_bool")

                    


                }

               
                
               
                
            }
                
            else{
                
                self.Alert(Message: "Please check your internet connection!")
                
                self.image_gif.isHidden = true
            }
            
            
   }
        
    }
    
    
    
  
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            exit(0)

        }
        
        alert.addAction(okAction)

        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
     
   

    

}
