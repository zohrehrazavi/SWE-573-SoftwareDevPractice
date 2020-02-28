//
//  YeniAnaSayfa.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 26.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class YeniAnaSayfa: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var menu_button: UIButton!
    @IBOutlet weak var menu_view: UIView!
    @IBOutlet weak var scroll_view: UIScrollView!
    
    @IBOutlet weak var wastage_spinner_ucgen: UIImageView!
    @IBOutlet weak var injections_spinner_ucgen: UIImageView!
    @IBOutlet weak var calculate_button: UIButton!
    @IBOutlet weak var ınjections_button: UIButton!
    @IBOutlet weak var wastage_button: UIButton!
    @IBOutlet weak var maintenance_button: UIButton!
    @IBOutlet weak var loading_button: UIButton!
    let sayılar = ["0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]
    
   

    
    var rotationAngle: CGFloat!
    
    var menu_kontrol = false
    
    let width:CGFloat = 100
    let height:CGFloat = 100
    let pickerView = UIPickerView()
    
    
    
    let gri_color = UIColor(red: 113/255.0, green: 113/255.0, blue: 113/255.0, alpha: 1)
    let lacivert_color = UIColor(red: 0/255.0, green: 62/255.0, blue: 112/255.0, alpha: 1)
    
    
    @IBOutlet weak var menu_sınır_contraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var asıl_view: UIView!
    @IBOutlet weak var bizim_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
        menu_sınır_contraint.constant = -280
        
        
        
      
        
      
        
        
        
        
        

        
        
      /*  pop_up_ana_view.layer.cornerRadius = 5
        pop_up_ust_view.layer.cornerRadius = 5
        pop_up_ana_view.layer.borderWidth = 1
        pop_up_ana_view.layer.borderColor = UIColor.white.cgColor
        
        
        q1_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q1_button.layer.borderWidth = 0.5
        
        
        q2_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q2_button.layer.borderWidth = 0.5
        
        
        
        q3_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q3_button.layer.borderWidth = 0.5
        
        
        q4_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q4_button.layer.borderWidth = 0.5
        
        
      
        
        
        
        cancel_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        cancel_button.layer.borderWidth = 1
        cancel_button.layer.cornerRadius = 5
       
        
        pop_up_ok_button.layer.cornerRadius = 5
        
        q4_button.isHidden = true
 
 */
        
        
        
        wastage_spinner_ucgen.isHidden = true
        injections_spinner_ucgen.isHidden = true
        
     //   pop_up_view_arka.isHidden = true
        
        
      
        
        
        
        let frm: CGRect = bizim_view.frame
        let bizim_view_dikey_konum = frm.origin.y
        let bizim_view_yükseklik = frm.size.height
        
        bizim_view.frame = frm
        let frm_2: CGRect = pickerView.frame
        let picker_view_yüksekliği = frm_2.size.height
        let picker_konumu  = (bizim_view_dikey_konum)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.layer.borderColor = UIColor.white.cgColor
        pickerView.layer.borderWidth = 0
        pickerView.showsSelectionIndicator = false
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle )
        pickerView.frame = CGRect(x: -1000 , y:  picker_konumu + 15  , width: asıl_view.frame.width + 2000   , height: 100 )
        // pickerView.center = self.view.center
        self.asıl_view.addSubview(pickerView)
        self.pickerView.selectRow(453, inComponent: 0, animated: false)

     
        
        
        loading_button.backgroundColor = .clear
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 1
        loading_button.layer.borderColor = gri_color.cgColor

        
        
        
        
        maintenance_button.backgroundColor = .clear
        maintenance_button.layer.cornerRadius = 5
        maintenance_button.layer.borderWidth = 1
        maintenance_button.layer.borderColor = gri_color.cgColor

        
        
        
        
        
        wastage_button.backgroundColor = .clear
        wastage_button.layer.cornerRadius = 5
        wastage_button.layer.borderWidth = 1
        wastage_button.layer.borderColor = gri_color.cgColor

       
        
        
        ınjections_button.backgroundColor = .clear
        ınjections_button.layer.cornerRadius = 5
        ınjections_button.layer.borderWidth = 1
        ınjections_button.layer.borderColor = gri_color.cgColor

        
        
        
        
        calculate_button.layer.cornerRadius = 5
        calculate_button.layer.borderColor = UIColor.black.cgColor
        


        
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
        
        pickerView.subviews[1].backgroundColor = UIColor.white
        pickerView.subviews[2].backgroundColor = UIColor.white
        
        return view
        
        
    }
    
    @IBAction func menu_action(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.2, animations:{
            
            self.menu_sınır_contraint.constant = 0
            self.view.layoutIfNeeded()
            self.menu_kontrol = true
            
            })

        
        
        
    }
    @IBAction func log_out_action(_ sender: Any) {
    }
    
    @IBAction func loading_action(_ sender: Any) {
        
        
        loading_button.backgroundColor = lacivert_color
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 0
        loading_button.setTitleColor(.white, for: .normal)
        
        
        maintenance_button.backgroundColor = .clear
        maintenance_button.layer.cornerRadius = 5
        maintenance_button.layer.borderWidth = 1
        maintenance_button.layer.borderColor = gri_color.cgColor
        maintenance_button.setTitleColor(getColorByHex(rgbHexValue: 0x717171, alpha: 0.8), for: .normal)
        
        wastage_spinner_ucgen.isHidden = true
        injections_spinner_ucgen.isHidden = true
        
        

        
}
    
    
    
    @IBAction func maintenance_action(_ sender: Any) {
        
        
        
        maintenance_button.backgroundColor = lacivert_color
        maintenance_button.layer.cornerRadius = 5
        maintenance_button.layer.borderWidth = 0
        maintenance_button.setTitleColor(.white, for: .normal)
        
        
        loading_button.backgroundColor = .clear
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 1
        loading_button.layer.borderColor = gri_color.cgColor
        loading_button.setTitleColor(getColorByHex(rgbHexValue: 0x717171, alpha: 0.8), for: .normal)
        
        
        wastage_spinner_ucgen.isHidden = false
        injections_spinner_ucgen.isHidden = false
        
        

        

    }
    

    @IBAction func wastage_action(_ sender: Any) {
        
        
        
        wastage_button.backgroundColor = lacivert_color
        wastage_button.layer.cornerRadius = 5
        wastage_button.layer.borderWidth = 0
        wastage_button.setTitleColor(.white, for: .normal)
        
        
        ınjections_button.backgroundColor = .clear
        ınjections_button.layer.cornerRadius = 5
        ınjections_button.layer.borderWidth = 1
        ınjections_button.layer.borderColor = gri_color.cgColor
        ınjections_button.setTitleColor(getColorByHex(rgbHexValue: 0x717171, alpha: 0.8), for: .normal)
        
        UIView.animate(withDuration: 0.2, animations:{
            
            
            self.menu_sınır_contraint.constant = -280
            self.view.layoutIfNeeded()
            
            
        })

        
        
        
    }
    
    @IBAction func ınjections_action(_ sender: Any) {
        
        ınjections_button.backgroundColor = lacivert_color
        ınjections_button.layer.cornerRadius = 5
        ınjections_button.layer.borderWidth = 0
        ınjections_button.setTitleColor(.white, for: .normal)
        
        
        wastage_button.backgroundColor = .clear
        wastage_button.layer.cornerRadius = 5
        wastage_button.layer.borderWidth = 1
        wastage_button.layer.borderColor = gri_color.cgColor
        wastage_button.setTitleColor(getColorByHex(rgbHexValue: 0x717171, alpha: 0.8), for: .normal)

        
       // pop_up_view_arka.isHidden = false

        
        
    }
    
    
    func getColorByHex(rgbHexValue:UInt32, alpha:Double = 1.0) -> UIColor {
        let red = Double((rgbHexValue & 0xFF0000) >> 16) / 256.0
        let green = Double((rgbHexValue & 0xFF00) >> 8) / 256.0
        let blue = Double((rgbHexValue & 0xFF)) / 256.0
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    
    
    
 
    
    
}
