//
//  Calculate.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 13.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class Calculate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var calculate_button: UIButton!
    @IBOutlet weak var least_injections_button: UIButton!
    @IBOutlet weak var least_wastage_button: UIButton!
    @IBOutlet weak var maintenance_button: UIButton!
    @IBOutlet weak var loading_button: UIButton!
    @IBOutlet weak var bizim_view: UIView!
    
    let sayılar = ["1","200000","2","2","2","2","2","2","2","2","2","2","2","2","2","2"]
    
    
    var rotationAngle: CGFloat!
    
    let width:CGFloat = 300
    let height:CGFloat = 300
    
    
    let pickerView = UIPickerView()

    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        pickerView.layer.borderColor = UIColor.white.cgColor
        pickerView.layer.borderWidth = 0
        pickerView.showsSelectionIndicator = false
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle )
        
        
        let y = pickerView.frame.origin.y
        let x = pickerView.frame.origin.x
        

     
        pickerView.frame = CGRect(x: -150 , y: 0 , width: view.frame.width + 300 , height: 100)
        pickerView.center = self.bizim_view.center
       pickerView.reloadAllComponents()
        pickerView.reloadInputViews()
       self.view.addSubview(pickerView)
        
       
        
        loading_button.backgroundColor = .clear
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 1
        loading_button.layer.borderColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0).cgColor
        
        
        
        least_injections_button.backgroundColor = .clear
        least_injections_button.layer.cornerRadius = 5
        least_injections_button.layer.borderWidth = 1
        least_injections_button.layer.borderColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0).cgColor

        
        
        least_wastage_button.backgroundColor = .clear
        least_wastage_button.layer.cornerRadius = 5
        least_wastage_button.layer.borderWidth = 1
        least_wastage_button.layer.borderColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0).cgColor

        
       
        maintenance_button.backgroundColor = .clear
        maintenance_button.layer.cornerRadius = 5
        maintenance_button.layer.borderWidth = 1
        maintenance_button.layer.borderColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0).cgColor

        
        calculate_button.layer.cornerRadius = 5
        
        
        
        
        
        
        
        
        
        
      

        
       
        
        
        
        
        
       
        

        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sayılar.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 414
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 414
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: width     , height: height)
        
        let label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        label.textAlignment = .center
        
        label.text = sayılar[row]
        
        label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 60)
        
        view.transform = CGAffineTransform( rotationAngle: 90 * (.pi/180) )
        
        view.addSubview(label)
        
        return view
        
        
    }
    
    
    
    @IBAction func loading_action(_ sender: Any) {
        
        
        
        
        loading_button.backgroundColor = UIColor(red: 24/255, green: 65/255, blue: 104/255, alpha: 1)
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 0
        loading_button.setTitleColor(.white, for: .normal)
        
        
        
        maintenance_button.backgroundColor = .clear
        maintenance_button.layer.cornerRadius = 5
        maintenance_button.layer.borderWidth = 1
        maintenance_button.setTitleColor(.black, for: .normal)
        
        
    }
    
    
    @IBAction func maintenance_action(_ sender: Any) {
        
        
        let spinner_image = UIImage(named: "spinner_back") as UIImage?
        least_wastage_button.setImage(spinner_image, for: .normal)
        least_injections_button.setImage(spinner_image, for: .normal)
        least_injections_button.backgroundColor = .clear
        least_wastage_button.backgroundColor = .clear
        least_injections_button.layer.borderWidth = 0
        least_wastage_button.layer.borderWidth = 0
        
        
        
        
        maintenance_button.backgroundColor = UIColor(red: 24/255, green: 65/255, blue: 104/255, alpha: 1)
        maintenance_button.layer.cornerRadius = 5
        maintenance_button.layer.borderWidth = 0
        maintenance_button.setTitleColor(.white, for: .normal)
        
        
        
        loading_button.backgroundColor = .clear
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 1
        loading_button.setTitleColor(.black, for: .normal)




    }
    
    @IBAction func wastage_action(_ sender: Any) {
    }
    
    @IBAction func injections_action(_ sender: Any) {
    }
}
