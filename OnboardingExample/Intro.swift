//
//  Intro.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 3.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class Intro: UIViewController , UIScrollViewDelegate {

    @IBOutlet weak var next_button: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.scrollView.delegate = self
        
       
        
    }
    
    func scrollRight() {
        
        if scrollView.contentOffset.x > self.view.bounds.width {
            scrollView.contentOffset.x +=  self.view.bounds.width
            
            var frame: CGRect = self.scrollView.frame
            frame.origin.x = scrollView.contentOffset.x
            frame.origin.y = 0
            self.scrollView.setContentOffset(CGPoint(x: frame.origin.x, y: frame.origin.y), animated: true)
        }
        
        
        if scrollView.contentOffset.x < self.view.bounds.width {
            scrollView.contentOffset.x +=  self.view.bounds.width
            
            var frame: CGRect = self.scrollView.frame
            frame.origin.x = scrollView.contentOffset.x
            frame.origin.y = 0
            self.scrollView.setContentOffset(CGPoint(x: frame.origin.x, y: frame.origin.y), animated: true)
        }
        
        
        if scrollView.contentOffset.x == self.view.bounds.width {
            scrollView.contentOffset.x +=  self.view.bounds.width
            
            var frame: CGRect = self.scrollView.frame
            frame.origin.x = scrollView.contentOffset.x
            frame.origin.y = 0
            self.scrollView.setContentOffset(CGPoint(x: frame.origin.x, y: frame.origin.y), animated: true)
        }
    }
    
   
   
    @IBAction func ileri_func(_ sender: Any) {
        
        scrollRight()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let pageIndex = Int(scrollView.contentOffset.x/375)
        
        pageControl.currentPage = pageIndex

    }

    @IBAction func ileri(_ sender: Any) {
    }
    @IBAction func skip(_ sender: Any) {
    }
    
}






