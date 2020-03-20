//
//  VideoViewController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 3.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit
import  AVKit

class VideoViewController: UIViewController {

    
    var ilk_giriş_bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "video_bool")

        
        ilk_giriş_bool = defaults.bool(forKey: "video_bool")
        
        if ilk_giriş_bool == true{
            
            
            
            self.performSegue(withIdentifier: "video_ana_segue", sender: nil)

            
            
        }else{
            
            
        }
      
     
    }
    
    
   
   
   

    
    @IBAction func play_button_action(_ sender: Any) {
        
        
        
        if let path = Bundle.main.path(forResource: "adm_video", ofType: "mp4")
        {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
                {
                    video.play()
                    print("asfas")
            })
        }
    }
    
  
    
    
  

}


