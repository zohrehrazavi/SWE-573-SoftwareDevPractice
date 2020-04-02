//
//  YeniAnaSayfa.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 26.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit
import Parse
class YeniAnaSayfa: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var üst_view: UIView!
    
    @IBOutlet weak var ana_view: UIView!
    @IBOutlet weak var ok_button: UIButton!
    @IBOutlet weak var cancel_button: UIButton!
    @IBOutlet weak var q_4_button: UIButton!
    @IBOutlet weak var q_3_button: UIButton!
    @IBOutlet weak var pop_up_layout: UIView!
    
    @IBOutlet weak var q_2_button: UIButton!
    @IBOutlet weak var q_1_button: UIButton!
    @IBOutlet var pan_gesture: UIPanGestureRecognizer!
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
    let sayılar = ["0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","0","1","2","3", "4", "5", "6", "7", "8", "9","10","11", "12", "13", "14", "15", "16", "17", "18", "19","20","21", "22", "23", "24", "25", "26", "27", "28", "29","30","31", "32", "33", "34", "35", "36", "37", "38", "39","40","41", "42", "43", "44", "45", "46", "47", "48", "49","50","51", "52", "53", " 54", "55", "56", "57", "58", "59","60","61", "62", "63", "64", "65", "66", "67", "68", "69","70","71", "72", "73", "74", "75", "76", "77", "78", "79","80","81", "82", "83", "84", "85", "86", "87", "88", "89","90","91", "92", "93", "94", "95", "96", "97", "98", "99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"]
    
   

    
    var rotationAngle: CGFloat!
    
    var menu_kontrol = false
    
    let width:CGFloat = 100
    let height:CGFloat = 100
    let pickerView = UIPickerView()
    
    let açık_turuncu = UIColor(red: 255/255.0, green: 149/255.0, blue: 127/255.0, alpha: 1)
    let turuncu = UIColor(red: 237/255.0, green: 78/255.0, blue: 57/255.0, alpha: 1)

    
    let gri_color = UIColor(red: 113/255.0, green: 113/255.0, blue: 113/255.0, alpha: 1)
    let lacivert_color = UIColor(red: 0/255.0, green: 62/255.0, blue: 112/255.0, alpha: 1)
    @IBOutlet weak var menu_sınır_contraint: NSLayoutConstraint!
    @IBOutlet weak var asıl_view: UIView!
    @IBOutlet weak var bizim_view: UIView!
    
    
    
    var kilo = 0
    
    var loading_aktif = false
    var maintenance_aktif = false
    var wastage_aktif = false
    var injections_aktif = false
    
    
    var q_1_aktif = false
    var q_2_aktif = false
    var q_4_aktif = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       wastage_spinner_ucgen.isHidden = true
        injections_spinner_ucgen.isHidden = true
        

        
        ana_view.layer.cornerRadius = 5
        üst_view.layer.cornerRadius = 5
        ana_view.layer.borderWidth = 1
        ana_view.layer.borderColor = UIColor.white.cgColor
        
        
        q_1_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_1_button.layer.borderWidth = 0.5
        
        
        q_2_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_2_button.layer.borderWidth = 0.5
        
        
        
        q_3_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_3_button.layer.borderWidth = 0.5
        
        
        q_4_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        q_4_button.layer.borderWidth = 0.5
        
        
        
        
        cancel_button.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        cancel_button.layer.borderWidth = 1
        cancel_button.layer.cornerRadius = 5
        
        
        
        ok_button.layer.cornerRadius = 5
        
        
      
        
        menu_sınır_contraint.constant = -280
        
      
        pan_gesture.delegate = self

      
        
        let ekran_genişliği = view.frame.width
        let ekran_yüksekliği = view.frame.height
        
        print(ekran_genişliği, ekran_yüksekliği)
        
       
        
        
      
        
        let frm: CGRect = bizim_view.frame
        let bizim_view_dikey_konum = frm.origin.y
        let bizim_view_yatay_konum = frm.origin.x

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
        pickerView.frame = CGRect(x: -250 , y:  picker_konumu + 15   , width: view.frame.width + 500  , height: 100 )
        self.asıl_view.addSubview(pickerView)
        
        if( kilo == 0){
            
            self.pickerView.selectRow(453, inComponent: 0, animated: false)

        }else{
            
            self.pickerView.selectRow(kilo, inComponent: 0, animated: false)

            
            
        }
        
        
      /*
         iPhone XS Max
         
         if ((ekran_genişliği == 414.0 ) && (ekran_yüksekliği == 896.0 )){
            
            bizim_view.frame = CGRect(x: bizim_view_yatay_konum , y:  bizim_view_dikey_konum  , width: view.frame.width   , height: 200 )
            
            
        }
 
 */

     
        
        
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
        
        if( kilo == 0 || kilo == 1 || kilo == 2 || kilo == 453 ){
            
            calculate_button.backgroundColor = açık_turuncu
        }else{
            
            calculate_button.backgroundColor = turuncu
        }
        


        
    }
    
    
   
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag==0){

            
           
            
            
            if( row >= 0 && row <= 150 ){
                
                kilo = row
                
            }else if( row >= 151 && row < 302 ){
                
                kilo = row - 151
                
            }else if( row >= 302 && row < 453 ){
                
                kilo = row - 302
                
                
            }else if( row >= 453 && row < 604 ){
                
                kilo = row - 453
                
                
            }else if( row >= 604 && row < 755 ){
                
                kilo = row - 604
                
                
            }else if( row >= 755 && row < 908 ){
                
                kilo = row - 756
                
                
            }else if( row >= 908 && row < 1060 ){
                
                kilo = row - 908
                
                
            }
            
            
            
            if( kilo == 0 || kilo == 1 || kilo == 2 ){
                
                calculate_button.backgroundColor = açık_turuncu
                
            }else{
                
                calculate_button.backgroundColor = turuncu
            }
            
            
            print(kilo, row)
            
            

        }
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
        
        PFUser.logOutInBackground { (error: Error?) in
            if (error == nil){
                
                self.performSegue(withIdentifier: "ana_login", sender: nil)
                print("çıkıldı")
                
                
                

                
                
            }else{
                if let descrip = error?.localizedDescription{
                    
                    print(descrip)
                    

                }else{
                    
                    
                }
                
            }
        }
    }
    
    @IBAction func loading_action(_ sender: Any) {
        
        loading_aktif = true
        maintenance_aktif = false
        
        
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
        
        ınjections_button.setTitle("Least Injections", for: .normal)
        wastage_button.setTitle("Least Wastage", for: .normal)


        
        

        
}
    
    
    
    
    @IBAction func maintenance_action(_ sender: Any) {
        
        
        loading_aktif = false
        maintenance_aktif = true
        
        
        
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
        
        wastage_aktif = true
        injections_aktif = false
        
        
        wastage_button.backgroundColor = lacivert_color
        wastage_button.layer.cornerRadius = 5
        wastage_button.layer.borderWidth = 0
        wastage_button.setTitleColor(.white, for: .normal)
        
        
        ınjections_button.backgroundColor = .clear
        ınjections_button.layer.cornerRadius = 5
        ınjections_button.layer.borderWidth = 1
        ınjections_button.layer.borderColor = gri_color.cgColor
        ınjections_button.setTitleColor(getColorByHex(rgbHexValue: 0x717171, alpha: 0.8), for: .normal)

        
        
        
        
        if (maintenance_aktif == true){
            
            pop_up_layout.isHidden = false
            
            }

        
        
        
    }
    
    @IBAction func ınjections_action(_ sender: Any) {
        
        injections_aktif = true
        wastage_aktif = false
        
        ınjections_button.backgroundColor = lacivert_color
        ınjections_button.layer.cornerRadius = 5
        ınjections_button.layer.borderWidth = 0
        ınjections_button.setTitleColor(.white, for: .normal)
        
        
        wastage_button.backgroundColor = .clear
        wastage_button.layer.cornerRadius = 5
        wastage_button.layer.borderWidth = 1
        wastage_button.layer.borderColor = gri_color.cgColor
        wastage_button.setTitleColor(getColorByHex(rgbHexValue: 0x717171, alpha: 0.8), for: .normal)

        
        if (maintenance_aktif == true){
            
            pop_up_layout.isHidden = false
            
        }

        
        
    }
    
    
    func getColorByHex(rgbHexValue:UInt32, alpha:Double = 1.0) -> UIColor {
        let red = Double((rgbHexValue & 0xFF0000) >> 16) / 256.0
        let green = Double((rgbHexValue & 0xFF00) >> 8) / 256.0
        let blue = Double((rgbHexValue & 0xFF)) / 256.0
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    
    /*@IBAction func pan_performed(_ sender: UIPanGestureRecognizer) {
        
        
        
        
        if sender.state == .began {
            let vel = sender.velocity(in: view) // view is your UIView
            if vel.x > 0 {
                print("right")
                
                
                UIView.animate(withDuration: 0.2, animations:{
                    
                    
                    self.menu_sınır_contraint.constant = -280
                    self.view.layoutIfNeeded()
                    
                    
                })
                
                
                
            } else {
                print("left")
                
                
                
                UIView.animate(withDuration: 0.2, animations:{
                    
                    
                    self.menu_sınır_contraint.constant = 0
                    self.view.layoutIfNeeded()
                    
                    
                })
                
                
            }
        }
        
        
}
 
 */
    @IBAction func pan_action_1(_ sender: UIPanGestureRecognizer) {
        
        
        
        
        if sender.state == .began {
            let vel = sender.velocity(in: view) // view is your UIView
            if vel.x > 0 {
                print("right")
                
                
                UIView.animate(withDuration: 0.2, animations:{
                    
                    
                    self.menu_sınır_contraint.constant = -280
                    self.view.layoutIfNeeded()
                    
                    
                })
                
                
                
            } else {
                print("left")
                
                
                
                UIView.animate(withDuration: 0.2, animations:{
                    
                    
                    self.menu_sınır_contraint.constant = 0
                    self.view.layoutIfNeeded()
                    
                    
                })
                
                
            }
        }
        
    }
    
    
   
    
    
    
   
    
    
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer == scroll_view.panGestureRecognizer { // or tableView.panGestureRecognizer
            return false
        } else {
            return false
        }
        
}

    @IBAction func pop_up_cancel_action(_ sender: Any) {
        
        pop_up_layout.isHidden = true
        q_1_aktif = false
        q_2_aktif = false
        q_4_aktif = false
        
        
    }
    
    
    
    
    @IBAction func q1_action(_ sender: Any) {
        
        q_1_button.setTitleColor(getColorByHex(rgbHexValue: 0xED4E34, alpha: 1), for: .normal)
        q_2_button.setTitleColor(getColorByHex(rgbHexValue: 0x333333, alpha: 1), for: .normal)
        q_3_button.setTitleColor(getColorByHex(rgbHexValue: 0x333333, alpha: 1), for: .normal)


        q_1_aktif = true
        q_2_aktif = false
        q_4_aktif = false
        
        
    }
    @IBAction func q_2_action(_ sender: Any) {
        
        
        q_1_aktif = false
        q_2_aktif = true
        q_4_aktif = false
        
        q_1_button.setTitleColor(getColorByHex(rgbHexValue: 0x333333, alpha: 1), for: .normal)
        q_2_button.setTitleColor(getColorByHex(rgbHexValue: 0xED4E34, alpha: 1), for: .normal)
        q_3_button.setTitleColor(getColorByHex(rgbHexValue: 0x333333, alpha: 1), for: .normal)

    }
    @IBAction func q_3_action(_ sender: Any) {
        
        
        q_1_aktif = false
        q_2_aktif = false
        q_4_aktif = true
        
        q_1_button.setTitleColor(getColorByHex(rgbHexValue: 0x333333, alpha: 1), for: .normal)
        q_2_button.setTitleColor(getColorByHex(rgbHexValue: 0x333333, alpha: 1), for: .normal)
        q_3_button.setTitleColor(getColorByHex(rgbHexValue: 0xED4E34, alpha: 1), for: .normal)

        
    }
    @IBAction func ok_action(_ sender: Any) {
        
        if(q_1_aktif == true && wastage_aktif == true ){
            
            
            wastage_button?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

            wastage_button.setTitle("Least Wastage\n          Q1W", for: .normal)
            wastage_button.contentVerticalAlignment = .center
            pop_up_layout.isHidden = true
            
            ınjections_button.setTitle("Least Injections", for: .normal)

            
            


        }else if ( q_2_aktif == true && wastage_aktif == true){
            
            wastage_button?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            wastage_button.setTitle("Least Wastage\n          Q2W", for: .normal)
            wastage_button.contentVerticalAlignment = .center
            pop_up_layout.isHidden = true
            ınjections_button.setTitle("Least Injections", for: .normal)


            
            
        }else if ( q_4_aktif == true && wastage_aktif == true ){
            
            wastage_button?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            wastage_button.setTitle("Least Wastage\n          Q4W", for: .normal)
            wastage_button.contentVerticalAlignment = .center
            pop_up_layout.isHidden = true
            ınjections_button.setTitle("Least Injections", for: .normal)


            
            
        }
        
        
        
        
        if(q_1_aktif == true && injections_aktif == true ){
            
            
            ınjections_button?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            ınjections_button.setTitle("Least Injections\n          Q1W", for: .normal)
            ınjections_button.contentVerticalAlignment = .center
            pop_up_layout.isHidden = true
            wastage_button.setTitle("Least Wastage", for: .normal)

            
            
        }else if ( q_2_aktif == true && injections_aktif == true){
            
            ınjections_button?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            ınjections_button.setTitle("Least Injections\n          Q2W", for: .normal)
            ınjections_button.contentVerticalAlignment = .center
            pop_up_layout.isHidden = true
            wastage_button.setTitle("Least Wastage", for: .normal)

            
            
            
        }else if ( q_4_aktif == true && injections_aktif == true ){
            
            ınjections_button?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            ınjections_button.setTitle("Least Injections\n          Q4W", for: .normal)
            ınjections_button.contentVerticalAlignment = .center
            pop_up_layout.isHidden = true
            wastage_button.setTitle("Least Wastage", for: .normal)

            
            
            
        }
        
        }
    
    
    
    
    
    @IBAction func click_calculate_button(_ sender: Any) {
        
        
        
        if( kilo == 0 || kilo == 1 || kilo == 2 ){
            
            
        }else{
            
            
            if(loading_aktif==true && wastage_aktif == true ){
                
                performSegue(withIdentifier: "loading_wastage_segue", sender: self)
                
                
            }else if( loading_aktif == true && injections_aktif == true){
                
                performSegue(withIdentifier: "Loading_Injections_Segue", sender: self)
                
                
            }else if( loading_aktif == false && maintenance_aktif == true && wastage_aktif == true && q_1_aktif == true){
                
                performSegue(withIdentifier: "wastage_1_segue", sender: self)
                
            }else if( loading_aktif == false && maintenance_aktif == true && wastage_aktif == true && q_2_aktif == true){
                
                performSegue(withIdentifier: "wastage_2_segue", sender: self)
                
            }else if( loading_aktif == false && maintenance_aktif == true && wastage_aktif == true && q_4_aktif == true){
                
                performSegue(withIdentifier: "wastage_3_segue", sender: self)
                
            }else if( loading_aktif == false && maintenance_aktif == true && injections_aktif == true && q_1_aktif == true){
                
                performSegue(withIdentifier: "injections_1_segue", sender: self)
                
            }else if( loading_aktif == false && maintenance_aktif == true && injections_aktif == true && q_2_aktif == true){
                
                performSegue(withIdentifier: "injections_2_segue", sender: self)
                
            }else if( loading_aktif == false && maintenance_aktif == true && injections_aktif == true && q_4_aktif == true){
                
                performSegue(withIdentifier: "injections_3_segue", sender: self)
                
            }
            
            
            
        }
        
        
        

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( segue.identifier == "loading_wastage_segue" ){
            
            let vc = segue.destination as! Result_Loading_Wastage
            vc.kilo = kilo
            
        }else if( segue.identifier == "Loading_Injections_Segue"  ){
            
            let vc = segue.destination as! Result_Loading_Injections
            vc.kilo = kilo
            
        }else if( segue.identifier == "wastage_1_segue"  ){
            
            let vc = segue.destination as! Result_Wastage_1
            vc.kilo = kilo
            
        }else if( segue.identifier == "wastage_2_segue"  ){
            
            let vc = segue.destination as! Result_Wastage_2
            vc.kilo = kilo
            
        }else if( segue.identifier == "wastage_3_segue"  ){
            
            let vc = segue.destination as! Result_Wastage_3
            vc.kilo = kilo
            
        }else if( segue.identifier == "injections_1_segue"  ){
            
            let vc = segue.destination as! Result_Injections_1
            vc.kilo = kilo
            
        }else if( segue.identifier == "injections_2_segue"  ){
            
            let vc = segue.destination as! Result_Injections_2
            vc.kilo = kilo
            
        }else if( segue.identifier == "injections_3_segue"  ){
            
            let vc = segue.destination as! Result_Injections_3
            vc.kilo = kilo
            
        }
        
        
    }
}
 
 






