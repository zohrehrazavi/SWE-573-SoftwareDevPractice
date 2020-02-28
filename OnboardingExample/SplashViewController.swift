//
//  SplashViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 4.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit



class SplashViewController: UIViewController  {

    

    @IBOutlet weak var image_gif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image_gif.loadGif(name: "loa_gif")
        
      
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
            
            
            
            if CheckInternet.Connection(){
                
                self.performSegue (withIdentifier: "splashden_introya", sender: self)
                
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
