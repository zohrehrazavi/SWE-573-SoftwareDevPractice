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

    override func viewDidLoad() {
        super.viewDidLoad()

      
     
    }
    
    
   
   
   

    @IBAction func buttonAction(_ sender: Any) {
        
        if let path = Bundle.main.path(forResource: "roche_video", ofType: "mp4")
        {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
                {
                    video.play()
            })
        }
        
    }
    
  
  
    
    
  

}


