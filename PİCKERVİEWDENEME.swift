//
//  PİCKERVİEWDENEME.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 25.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class PI_CKERVI_EWDENEME: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var bizim_view: UIView!
    let sayılar = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
    
    var rotationAngle: CGFloat!
    
    let width:CGFloat = 100
    let height:CGFloat = 100
    let pickerView = UIPickerView()
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var frm: CGRect = bizim_view.frame
       var bizim_view_yatay_konum = frm.origin.x
        
        var bizim_view_dikey_konum = frm.origin.y
        
        var bizim_view_yükseklik = frm.size.height
        
        var bizim_view_genişlik = frm.size.width
        
        bizim_view.frame = frm
        
        
        var frm_2: CGRect = pickerView.frame
        var picker_view_yüksekliği = frm_2.size.height
        
        
        let picker_konumu  = (bizim_view_dikey_konum) 

        
        print("KONUMLAR",picker_konumu , bizim_view_dikey_konum , bizim_view_yükseklik , picker_view_yüksekliği)
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.layer.borderColor = UIColor.white.cgColor
        pickerView.layer.borderWidth = 0
        pickerView.showsSelectionIndicator = false
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle )
        pickerView.frame = CGRect(x: 0  , y:  picker_konumu , width: view.frame.width   , height: 100 )
       // pickerView.center = self.view.center
        self.view.addSubview(pickerView)

       
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sayılar.count
    }

    
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
        
        
        label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 60)
        
        view.transform = CGAffineTransform( rotationAngle: 90 * (.pi/180) )
        
        view.addSubview(label)
        
        return view
        
        
    }
    
}


    

   









