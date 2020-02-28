//
//  AnaSayfa.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 9.01.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class AnaSayfa: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let sayılar = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
    
    
    
    
    
   
   
    
    

    
    @IBOutlet weak var bizim_view: UIView!
    
   
    
    
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBOutlet weak var calculate_button: UIButton!
    
    @IBOutlet weak var loading_button: UIButton!
    
    @IBOutlet weak var injections_button: UIButton!
    @IBOutlet weak var wastage_button: UIButton!
    @IBOutlet weak var maintenence_button: UIButton!
    let array=[UIImage(named:"centik_grup")]
    
    @IBOutlet weak var adminis_button: UIView!
    
    
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

        
       
        
      
       
        
       loading_button.backgroundColor = .clear
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 1
       
        
        
        
        maintenence_button.backgroundColor = .clear
        maintenence_button.layer.cornerRadius = 5
        maintenence_button.layer.borderWidth = 1
       
        
        
        
        
        wastage_button.backgroundColor = .clear
        wastage_button.layer.cornerRadius = 5
        wastage_button.layer.borderWidth = 1
        wastage_button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)

        
        
        injections_button.backgroundColor = .clear
        injections_button.layer.cornerRadius = 5
        injections_button.layer.borderWidth = 1
        injections_button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)

        
        
        
         calculate_button.layer.cornerRadius = 5
        
        calculate_button.layer.borderColor = UIColor.black.cgColor
        
        viewConstraint.constant = 280
        
      
     
       
    }
    
    
    
    
    @IBAction func click_loading(_ sender: Any) {
        
        
        loading_button.backgroundColor = UIColor(red: 24/255, green: 65/255, blue: 104/255, alpha: 1)
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 0
        loading_button.setTitleColor(.white, for: .normal)

        
        
        maintenence_button.backgroundColor = .clear
        maintenence_button.layer.cornerRadius = 5
        maintenence_button.layer.borderWidth = 1
        maintenence_button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        maintenence_button.setTitleColor(.black, for: .normal)

        
        
        
        
        
    }
    
    
    @IBAction func click_main(_ sender: Any) {
        
        
        maintenence_button.backgroundColor = UIColor(red: 24/255, green: 65/255, blue: 104/255, alpha: 1)
        maintenence_button.layer.cornerRadius = 5
        maintenence_button.layer.borderWidth = 0
        maintenence_button.setTitleColor(.white, for: .normal)

        
        
        
        
        loading_button.backgroundColor = .clear
        loading_button.layer.cornerRadius = 5
        loading_button.layer.borderWidth = 1
       loading_button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        loading_button.setTitleColor(.black, for: .normal)

        
}
    
    
    
   
    
    
    
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        
        
        if sender.state == .began {
            let vel = sender.velocity(in: view) // view is your UIView
            if vel.x > 0 {
                print("right")
            } else {
                print("left")
            }
        }
        
        if sender.state == .ended {
            let vel = sender.velocity(in: view)
            if vel.y > 0 {
                print("down")
            } else {
                print("up")
            }
        }
        
        let vel = sender.velocity(in: view) // view is your UIView

        if ( sender.state == .began || sender.state == .changed ){
            
            let translation = sender.translation(in: self.view).x
            
            if translation > 0 {
                
                
               // print(translation,viewConstraint.constant)
                
                if viewConstraint.constant > 0 && (vel.y < 0) {
                    
                    UIView.animate(withDuration: 0.2, animations:{
                        
                      
                        
                            
                            UIView.animate(withDuration: 0.2, animations:{
                                
                
                                self.viewConstraint.constant = 0
                                self.view.layoutIfNeeded()

                                
                            })
                            
                            
                            
                            
                        
                    })
                    
                    
                }
                }else{
                    
                    if viewConstraint.constant < 280 {
                        
                        UIView.animate(withDuration: 0.2, animations:{
                            
                           
                            self.viewConstraint.constant = 280
                                    self.view.layoutIfNeeded()
                                    
                                    
                        
                        })
                        
                         }
                    
                     }
                    
            } else if sender.state == .ended{
                
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
        
        
        label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 30)
        
        view.transform = CGAffineTransform( rotationAngle: 90 * (.pi/180) )
        
        view.addSubview(label)
        
        return view
        
        
    }
            
        }


    
    
    

