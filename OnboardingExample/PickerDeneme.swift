//
//  PickerDeneme.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 12.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class PickerDeneme: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var stack_view: UIStackView!
    let sayılar = ["1","2","2","2","2","2","2","2","2","2","2","2","2","2","2","2"]
    
    let pickerView = UIPickerView()
    
    var rotationAngle: CGFloat!
    
    let width:CGFloat = 100
    let height:CGFloat = 100
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.layer.borderColor = UIColor.white.cgColor
        
        pickerView.layer.borderWidth = 0
        
       
        pickerView.showsSelectionIndicator = false
     
        
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle )
        
        
        

        pickerView.frame = CGRect(x: 0 - 150 , y: 0 , width: view.frame.width + 300 , height: 100)
        pickerView.center = self.view.center
        self.stack_view.addSubview(pickerView)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sayılar.count
    }
    
    
   
    
   /* func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sayılar[row]
    }
 
 */
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: width , height: height)
        let label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        label.textAlignment = .center

        label.text = sayılar[row]
        
        
        label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 30)
        
        view.transform = CGAffineTransform( rotationAngle: 90 * (.pi/180) )
        
        view.addSubview(label)
        
        return view

        
    }
    

   

}
