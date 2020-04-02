//
//  Result_Injections_3.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 17.03.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit
import Parse

class Result_Injections_3: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var ana_view_result: UIView!
    
    @IBOutlet weak var scroll_view: UIScrollView!
    
    @IBOutlet var pan_gesture: UIPanGestureRecognizer!
    @IBOutlet weak var menu_const: NSLayoutConstraint!
    
    let back_sky_blue = UIColor(red: 0/255.0, green: 159/255.0, blue: 205/255.0, alpha: 1)
    let back_puple = UIColor(red: 233/255.0, green: 0/255.0, blue: 160/255.0, alpha: 1)
    let back_turquoise = UIColor(red: 0/255.0, green: 216/255.0, blue: 177/255.0, alpha: 1)
    let back_orange = UIColor(red: 183/255.0, green: 82/255.0, blue: 26/255.0, alpha: 1)
    
    let çizgi_back_beyaz = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.4)
    let çizgi_back_siyah = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3)
    
    
    
    let gri = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
    
    let turuncu = UIColor(red: 237/255.0, green: 78/255.0, blue: 52/255.0, alpha: 1)
    
    let siyah_text_color = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    
    
    
    
    var aranacak_dizi:[Double] = []
    
    
    
    
    var kilo = 61
    
    
    var ilaç_harf_1 = "y"
    var ilaç_harf_2 = "y"
    var ilaç_harf_3 = "y"
    var ilaç_harf_4 = "y"
    var ilaç_sıralaması = ""
    
    let SkyBlue = "Sky Blue"
    let Purple = "Purple"
    let Turquoise = "Turquoise"
    let Orange = "Orange"
    
    
    
    let sky_blue_dose_değeri = "30 mg"
    let purple_dose_değeri = "60 mg"
    let turquoise_dose_değeri = "105 mg"
    let orange_dose_değeri = "150 mg"
    
    
    
    
    
    var total_volume_değeri = 0.0
    var bir_mg_syringe_değeri = 0.0
    var iki_üç_syringe_değeri = 0.0
    var sky_blue_vial_değeri = 0.0
    var sky_blue_volume_değeri = 0.0
    var purple_vial_değeri = 0.0
    var purple_volume_değeri = 0.0
    var orange_vial_değeri = 0.0
    var orange_volume_değeri = 0.0
    var turquoise_vial_değeri = 0.0
    var turquoise_volume_değeri = 0.0
    
    
    var total_dose_değeri_int = 0
    
    
    let Q1_WASTAGE_3   :[Double] =  [3,    18,    0.60,    1,    0.6,    999,    999,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_4   :[Double] =  [4,    24,    0.80,    1,    0.8,    999,    999,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_5   :[Double] =  [5,    30,    1.00,    1,    1,    999,    999,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_6   :[Double] =  [6,    36,    0.24,    999,    999,    1,    0.24,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_7   :[Double] =  [7,    42,    0.28,    999,    999,    1,    0.28,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_8   :[Double] =  [8,    48,    0.32,    999,    999,    1,    0.32,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_9   :[Double] =  [9,    54,    0.36,    999,    999,    1,    0.36,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_10  : [Double] = [10,    60,    0.40,    999,    999,    1,    0.4,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_11  : [Double] = [11,    66,    0.44,    999,    999,    999,    999,    1,    0.44,    999,    999,    1,    999 ]
    let Q1_WASTAGE_12  : [Double] = [12,    72,    0.48,    999,    999,    999,    999,    1,    0.48,    999,    999,    1,    999 ]
    let Q1_WASTAGE_13  : [Double] = [13,    78,    0.52,    999,    999,    999,    999,    1,    0.52,    999,    999,    1,    999 ]
    let Q1_WASTAGE_14  : [Double] = [14,    84,    0.56,    999,    999,    999,    999,    1,    0.56,    999,    999,    1,    999 ]
    let Q1_WASTAGE_15  : [Double] = [15,    90,    0.6,    999,    999,    999,    999,    1,    0.6,    999,    999,    1,    999 ]
    let Q1_WASTAGE_16  : [Double] = [16,    96,    0.64,    999,    999,    999,    999,    1,    0.64,    999,    999,    1,    999 ]
    let Q1_WASTAGE_17  : [Double] = [17,    102,    0.68,    999,    999,    999,    999,    1,    0.68,    999,    999,    1,    999 ]
    let Q1_WASTAGE_18  : [Double] = [18,    108,    0.72,    999,    999,    2,    0.72,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_19  : [Double] = [19,    114,    0.76,    999,    999,    2,    0.76,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_20  : [Double] = [20,    120,    0.80,    999,    999,    2,    0.8,    999,    999,    999,    999,    1,    999 ]
    let Q1_WASTAGE_21  : [Double] = [21,    126,    0.84,    999,    999,    999,    999,    999,    999,    1,    0.84,    1,    999 ]
    let Q1_WASTAGE_22  : [Double] = [22,    132,    0.88,    999,    999,    999,    999,    999,    999,    1,    0.88,    1,    999 ]
    let Q1_WASTAGE_23  : [Double] = [23,    138,    0.92,    999,    999,    999,    999,    999,    999,    1,    0.92,    1,    999 ]
    let Q1_WASTAGE_24  : [Double] = [24,    144,    0.96,    999,    999,    999,    999,    999,    999,    1,    0.96,    1,    999 ]
    let Q1_WASTAGE_25  : [Double] = [25,    150,    1.00,    999,    999,    999,    999,    999,    999,    1,    1,    1,    999 ]
    let Q1_WASTAGE_26  : [Double] = [26,    156,    1.04,    999,    999,    1,    0.34,    1,    0.7,    999,    999,    999,    1 ]
    let Q1_WASTAGE_27  : [Double] = [27,    162,    1.08,    999,    999,    1,    0.38,    1,    0.7,    999,    999,    999,    1 ]
    let Q1_WASTAGE_28  : [Double] = [28,    168,    1.12,    999,    999,    3,    1.12,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_29  : [Double] = [29,    174,    1.16,    999,    999,    3,    1.16,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_30  : [Double] = [30,    180,    1.20,    999,    999,    3,    1.2,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_31  : [Double] = [31,    186,    1.24,    999,    999,    1,    0.4,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_32  : [Double] = [32,    192,    1.28,    999,    999,    1,    0.4,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_33  : [Double] = [33,    198,    1.32,    999,    999,    999,    999,    2,    1.32,    999,    999,    999,    1 ]
    let Q1_WASTAGE_34  : [Double] = [34,    204,    1.36,    999,    999,    999,    999,    2,    1.36,    999,    999,    999,    1 ]
    let Q1_WASTAGE_35  : [Double] = [35,    210,    1.40,    999,    999,    999,    999,    2,    1.4,    999,    999,    999,    1 ]
    let Q1_WASTAGE_36  : [Double] = [36,    216,    1.44,    999,    999,    2,    0.74,    1,    0.7,    999,    999,    999,    1 ]
    let Q1_WASTAGE_37  : [Double] = [37,    222,    1.48,    999,    999,    2,    0.78,    1,    0.7,    999,    999,    999,    1 ]
    let Q1_WASTAGE_38  : [Double] = [38,    228,    1.52,    999,    999,    4,    1.52,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_39  : [Double] = [39,    234,    1.56,    999,    999,    4,    1.56,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_40  : [Double] = [40,    240,    1.60,    999,    999,    4,    1.6,    999,    999,    999,    999,    999,    1 ]
    let Q1_WASTAGE_41  : [Double] = [41,    246,    1.64,    999,    999,    999,    999,    1,    0.64,    1,    1,    999,    1 ]
    let Q1_WASTAGE_42  : [Double] = [42,    252,    1.68,    999,    999,    999,    999,    1,    0.68,    1,    1,    999,    1 ]
    let Q1_WASTAGE_43  : [Double] = [43,    258,    1.72,    999,    999,    2,    0.72,    999,    999,    1,    1,    999,    1 ]
    let Q1_WASTAGE_44  : [Double] = [44,    264,    1.76,    999,    999,    2,    0.76,    999,    999,    1,    1,    999,    1 ]
    let Q1_WASTAGE_45  : [Double] = [45,    270,    1.80,    999,    999,    2,    0.8,    999,    999,    1,    1,    999,    1 ]
    let Q1_WASTAGE_46  : [Double] = [46,    276,    1.84,    999,    999,    3,    1.14,    1,    0.7,    999,    999,    999,    1 ]
    let Q1_WASTAGE_47  : [Double] = [47,    282,    1.88,    999,    999,    3,    1.18,    1,    0.7,    999,    999,    999,    1 ]
    let Q1_WASTAGE_48  : [Double] = [48,    288,    1.92,    999,    999,    999,    999,    999,    999,    2,    1.92,    999,    1 ]
    let Q1_WASTAGE_49  : [Double] = [49,    294,    1.96,    999,    999,    999,    999,    999,    999,    2,    1.96,    999,    1 ]
    let Q1_WASTAGE_50  : [Double] = [50,    300,    2.00,    999,    999,    999,    999,    999,    999,    2,    2,    999,    1 ]
    let Q1_WASTAGE_51  : [Double] = [51,    306,    2.04,    999,    999,    999,    999,    3,    2.04,    999,    999,    1,    1 ]
    let Q1_WASTAGE_52  : [Double] = [52,    312,    2.08,    999,    999,    999,    999,    3,    2.08,    999,    999,    1,    1 ]
    let Q1_WASTAGE_53  : [Double] = [53,    318,    2.12,    999,    999,    2,    0.72,    2,    1.4,    999,    999,    1,    1 ]
    let Q1_WASTAGE_54  : [Double] = [54,    324,    2.16,    999,    999,    2,    0.76,    2,    1.4,    999,    999,    1,    1 ]
    let Q1_WASTAGE_55  : [Double] = [55,    330,    2.20,    999,    999,    2,    0.8,    2,    1.4,    999,    999,    1,    1 ]
    let Q1_WASTAGE_56  : [Double] = [56,    336,    2.24,    999,    999,    4,    1.54,    1,    0.7,    999,    999,    1,    1 ]
    let Q1_WASTAGE_57  : [Double] = [57,    342,    2.28,    999,    999,    4,    1.58,    1,    0.7,    999,    999,    1,    1 ]
    let Q1_WASTAGE_58  : [Double] = [58,    348,    2.32,    999,    999,    1,    0.32,    999,    999,    2,    2,    1,    1 ]
    let Q1_WASTAGE_59  : [Double] = [59,    354,    2.36,    999,    999,    1,    0.36,    999,    999,    2,    2,    1,    1 ]
    let Q1_WASTAGE_60  : [Double] = [60,    360,    2.40,    999,    999,    1,    0.4,    999,    999,    2,    2,    1,    1 ]
    let Q1_WASTAGE_61  : [Double] = [61,    366,    2.44,    999,    999,    1,    0.34,    3,    2.1,    999,    999,    1,    1 ]
    let Q1_WASTAGE_62  : [Double] = [62,    372,    2.48,    999,    999,    1,    0.38,    3,    2.1,    999,    999,    1,    1 ]
    let Q1_WASTAGE_63  : [Double] = [63,    378,    2.52,    999,    999,    4,    1.52,    999,    999,    1,    1,    1,    1 ]
    let Q1_WASTAGE_64  : [Double] = [64,    384,    2.56,    999,    999,    4,    1.56,    999,    999,    1,    1,    1,    1 ]
    let Q1_WASTAGE_65  : [Double] = [65,    390,    2.60,    999,    999,    4,    1.6,    999,    999,    1,    1,    1,    1 ]
    let Q1_WASTAGE_66  : [Double] = [66,    396,    2.64,    999,    999,    999,    999,    1,    0.64,    2,    2,    1,    1 ]
    let Q1_WASTAGE_67  : [Double] = [67,    402,    2.68,    999,    999,    999,    999,    1,    0.68,    2,    2,    1,    1 ]
    let Q1_WASTAGE_68  : [Double] = [68,    408,    2.72,    999,    999,    2,    0.72,    999,    999,    2,    2,    1,    1 ]
    let Q1_WASTAGE_69  : [Double] = [69,    414,    2.76,    999,    999,    2,    0.76,    999,    999,    2,    2,    1,    1 ]
    let Q1_WASTAGE_70  : [Double] = [70,    420,    2.80,    999,    999,    2,    0.8,    999,    999,    2,    2,    1,    1 ]
    let Q1_WASTAGE_71  : [Double] = [71,    426,    2.84,    999,    999,    2,    0.74,    3,    2.1,    999,    999,    1,    1 ]
    let Q1_WASTAGE_72  : [Double] = [72,    432,    2.88,    999,    999,    2,    0.78,    3,    2.1,    999,    999,    1,    1 ]
    let Q1_WASTAGE_73  : [Double] = [73,    438,    2.92,    999,    999,    999,    999,    999,    999,    3,    2.92,    1,    1 ]
    let Q1_WASTAGE_74  : [Double] = [74,    444,    2.96,    999,    999,    999,    999,    999,    999,    3,    2.96,    1,    1 ]
    let Q1_WASTAGE_75  : [Double] = [75,    450,    3.00,    999,    999,    999,    999,    999,    999,    3,    3,    1,    1 ]
    let Q1_WASTAGE_76  : [Double] = [76,    456,    3.04,    999,    999,    999,    999,    3,    2.04,    1,    1,    999,    2 ]
    let Q1_WASTAGE_77  : [Double] = [77,    462,    3.08,    999,    999,    999,    999,    3,    2.08,    1,    1,    999,    2 ]
    let Q1_WASTAGE_78  : [Double] = [78,    468,    3.12,    999,    999,    1,    0.32,    4,    2.8,    999,    999,    999,    2 ]
    let Q1_WASTAGE_79  : [Double] = [79,    474,    3.16,    999,    999,    1,    0.36,    4,    2.8,    999,    999,    999,    2 ]
    let Q1_WASTAGE_80  : [Double] = [80,    480,    3.20,    999,    999,    1,    0.4,    4,    2.8,    999,    999,    999,    2 ]
    let Q1_WASTAGE_81  : [Double] = [81,    486,    3.24,    999,    999,    3,    1.14,    3,    2.1,    999,    999,    999,    2 ]
    let Q1_WASTAGE_82  : [Double] = [82,    492,    3.28,    999,    999,    3,    1.18,    3,    2.1,    999,    999,    999,    2 ]
    let Q1_WASTAGE_83  : [Double] = [83,    498,    3.32,    999,    999,    1,    0.32,    999,    999,    3,    3,    999,    2 ]
    let Q1_WASTAGE_84  : [Double] = [84,    504,    3.36,    999,    999,    1,    0.36,    999,    999,    3,    3,    999,    2 ]
    let Q1_WASTAGE_85  : [Double] = [85,    510,    3.40,    999,    999,    1,    0.4,    999,    999,    3,    3,    999,    2 ]
    let Q1_WASTAGE_86  : [Double] = [86,    516,    3.44,    999,    999,    999,    999,    5,    3.44,    999,    999,    999,    2 ]
    let Q1_WASTAGE_87  : [Double] = [87,    522,    3.48,    999,    999,    999,    999,    5,    3.48,    999,    999,    999,    2 ]
    let Q1_WASTAGE_88  : [Double] = [88,    528,    3.52,    999,    999,    2,    0.72,    4,    2.8,    999,    999,    999,    2 ]
    let Q1_WASTAGE_89  : [Double] = [89,    534,    3.56,    999,    999,    2,    0.76,    4,    2.8,    999,    999,    999,    2 ]
    let Q1_WASTAGE_90  : [Double] = [90,    540,    3.60,    999,    999,    2,    0.8,    4,    2.8,    999,    999,    999,    2 ]
    let Q1_WASTAGE_91  : [Double] = [91,    546,    3.64,    999,    999,    999,    999,    1,    0.64,    3,    3,    999,    2 ]
    let Q1_WASTAGE_92  : [Double] = [92,    552,    3.68,    999,    999,    999,    999,    1,    0.68,    3,    3,    999,    2 ]
    let Q1_WASTAGE_93  : [Double] = [93,    558,    3.72,    999,    999,    999,    999,    4,    2.72,    1,    1,    999,    2 ]
    let Q1_WASTAGE_94  : [Double] = [94,    564,    3.76,    999,    999,    999,    999,    4,    2.76,    1,    1,    999,    2 ]
    let Q1_WASTAGE_95  : [Double] = [95,    570,    3.80,    999,    999,    999,    999,    4,    2.8,    1,    1,    999,    2 ]
    let Q1_WASTAGE_96  : [Double] = [96,    576,    3.84,    999,    999,    1,    0.34,    5,    3.5,    999,    999,    999,    2 ]
    let Q1_WASTAGE_97  : [Double] = [97,    582,    3.88,    999,    999,    1,    0.38,    5,    3.5,    999,    999,    999,    2 ]
    let Q1_WASTAGE_98  : [Double] = [98,    588,    3.92,    999,    999,    999,    999,    999,    999,    4,    3.92,    999,    2 ]
    let Q1_WASTAGE_99  : [Double] = [99,    594,    3.96,    999,    999,    999,    999,    999,    999,    4,    3.96,    999,    2 ]
    let Q1_WASTAGE_100 :[Double] =  [100,    600,    4.00,    999,    999,    999,    999,    999,    999,    4,    4,    999,    2 ]
    let Q1_WASTAGE_101 :[Double] =  [101,    606,    4.04,    999,    999,    999,    999,    3,    2.04,    2,    2,    1,    2 ]
    let Q1_WASTAGE_102 :[Double] =  [102,    612,    4.08,    999,    999,    999,    999,    3,    2.08,    2,    2,    1,    2 ]
    let Q1_WASTAGE_103 :[Double] =  [103,    618,    4.12,    999,    999,    999,    999,    6,    4.12,    999,    999,    1,    2 ]
    let Q1_WASTAGE_104 :[Double] =  [104,    624,    4.16,    999,    999,    999,    999,    6,    4.16,    999,    999,    1,    2 ]
    let Q1_WASTAGE_105 :[Double] =  [105,    630,    4.20,    999,    999,    999,    999,    6,    4.2,    999,    999,    1,    2 ]
    let Q1_WASTAGE_106 :[Double] =  [106,    636,    4.24,    999,    999,    3,    1.14,    3,    2.1,    1,    1,    1,    2 ]
    let Q1_WASTAGE_107 :[Double] =  [107,    642,    4.28,    999,    999,    3,    1.18,    3,    2.1,    1,    1,    1,    2 ]
    let Q1_WASTAGE_108 :[Double] =  [108,    648,    4.32,    999,    999,    1,    0.32,    999,    999,    4,    4,    1,    2 ]
    let Q1_WASTAGE_109 :[Double] =  [109,    654,    4.36,    999,    999,    1,    0.36,    999,    999,    4,    4,    1,    2 ]
    let Q1_WASTAGE_110 :[Double] =  [110,    660,    4.40,    999,    999,    1,    0.4,    999,    999,    4,    4,    1,    2 ]
    let Q1_WASTAGE_111 :[Double] =  [111,    666,    4.44,    999,    999,    1,    0.34,    3,    2.1,    2,    2,    1,    2 ]
    let Q1_WASTAGE_112 :[Double] =  [112,    672,    4.48,    999,    999,    1,    0.38,    3,    2.1,    2,    2,    1,    2 ]
    let Q1_WASTAGE_113 :[Double] =  [113,    678,    4.52,    999,    999,    1,    0.32,    6,    4.2,    999,    999,    1,    2 ]
    let Q1_WASTAGE_114 :[Double] =  [114,    684,    4.56,    999,    999,    1,    0.36,    6,    4.2,    999,    999,    1,    2 ]
    let Q1_WASTAGE_115 :[Double] =  [115,    690,    4.60,    999,    999,    1,    0.4,    6,    4.2,    999,    999,    1,    2 ]
    let Q1_WASTAGE_116 :[Double] =  [116,    696,    4.64,    999,    999,    999,    999,    1,    0.64,    4,    4,    1,    2 ]
    let Q1_WASTAGE_117 :[Double] =  [117,    702,    4.68,    999,    999,    999,    999,    1,    0.68,    4,    4,    1,    2 ]
    let Q1_WASTAGE_118 :[Double] =  [118,    708,    4.72,    999,    999,    2,    0.72,    999,    999,    4,    4,    1,    2 ]
    let Q1_WASTAGE_119 :[Double] =  [119,    714,    4.76,    999,    999,    2,    0.76,    999,    999,    4,    4,    1,    2 ]
    let Q1_WASTAGE_120 :[Double] =  [120,    720,    4.80,    999,    999,    2,    0.8,    999,    999,    4,    4,    1,    2 ]
    let Q1_WASTAGE_121 :[Double] =  [121,    726,    4.84,    999,    999,    999,    999,    7,    4.84,    999,    999,    1,    2 ]
    let Q1_WASTAGE_122 :[Double] =  [122,    732,    4.88,    999,    999,    999,    999,    7,    4.88,    999,    999,    1,    2 ]
    let Q1_WASTAGE_123 :[Double] =  [123,    738,    4.92,    999,    999,    999,    999,    999,    999,    5,    4.92,    1,    2 ]
    let Q1_WASTAGE_124 :[Double] =  [124,    744,    4.96,    999,    999,    999,    999,    999,    999,    5,    4.96,    1,    2 ]
    let Q1_WASTAGE_125 :[Double] =  [125,    750,    5.00,    999,    999,    999,    999,    999,    999,    5,    5,    1,    2 ]
    let Q1_WASTAGE_126 :[Double] =  [126,    756,    5.04,    999,    999,    999,    999,    3,    2.04,    3,    3,    999,    3 ]
    let Q1_WASTAGE_127 :[Double] =  [127,    762,    5.08,    999,    999,    999,    999,    3,    2.08,    3,    3,    999,    3 ]
    let Q1_WASTAGE_128 :[Double] =  [128,    768,    5.12,    999,    999,    3,    1.12,    999,    999,    4,    4,    999,    3 ]
    let Q1_WASTAGE_129 :[Double] =  [129,    774,    5.16,    999,    999,    3,    1.16,    999,    999,    4,    4,    999,    3 ]
    let Q1_WASTAGE_130 :[Double] =  [130,    780,    5.20,    999,    999,    3,    1.2,    999,    999,    4,    4,    999,    3 ]
    let Q1_WASTAGE_131 :[Double] =  [131,    786,    5.24,    999,    999,    1,    0.34,    7,    4.9,    999,    999,    999,    3 ]
    let Q1_WASTAGE_132 :[Double] =  [132,    792,    5.28,    999,    999,    1,    0.38,    7,    4.9,    999,    999,    999,    3 ]
    let Q1_WASTAGE_133 :[Double] =  [133,    798,    5.32,    999,    999,    1,    0.32,    999,    999,    5,    5,    999,    3 ]
    let Q1_WASTAGE_134 :[Double] =  [134,    804,    5.36,    999,    999,    1,    0.36,    999,    999,    5,    5,    999,    3 ]
    let Q1_WASTAGE_135 :[Double] =  [135,    810,    5.40,    999,    999,    1,    0.4,    999,    999,    5,    5,    999,    3 ]
    let Q1_WASTAGE_136 :[Double] =  [136,    816,    5.44,    999,    999,    999,    999,    5,    3.44,    2,    2,    999,    3 ]
    let Q1_WASTAGE_137 :[Double] =  [137,    822,    5.48,    999,    999,    999,    999,    5,    3.48,    2,    2,    999,    3 ]
    let Q1_WASTAGE_138 :[Double] =  [138,    828,    5.52,    999,    999,    999,    999,    8,    5.52,    999,    999,    999,    3 ]
    let Q1_WASTAGE_139 :[Double] =  [139,    834,    5.56,    999,    999,    999,    999,    8,    5.56,    999,    999,    999,    3 ]
    let Q1_WASTAGE_140 :[Double] =  [140,    840,    5.60,    999,    999,    999,    999,    8,    5.6,    999,    999,    999,    3 ]
    let Q1_WASTAGE_141 :[Double] =  [141,    846,    5.64,    999,    999,    999,    999,    1,    0.64,    5,    5,    999,    3 ]
    let Q1_WASTAGE_142 :[Double] =  [142,    852,    5.68,    999,    999,    999,    999,    1,    0.68,    5,    5,    999,    3 ]
    let Q1_WASTAGE_143 :[Double] =  [143,    858,    5.72,    999,    999,    2,    0.72,    999,    999,    5,    5,    999,    3 ]
    let Q1_WASTAGE_144 :[Double] =  [144,    864,    5.76,    999,    999,    2,    0.76,    999,    999,    5,    5,    999,    3 ]
    let Q1_WASTAGE_145 :[Double] =  [145,    870,    5.80,    999,    999,    2,    0.8,    999,    999,    5,    5,    999,    3 ]
    let Q1_WASTAGE_146 :[Double] =  [146,    876,    5.84,    999,    999,    999,    999,    7,    4.84,    1,    1,    999,    3 ]
    let Q1_WASTAGE_147 :[Double] =  [147,    882,    5.88,    999,    999,    999,    999,    7,    4.88,    1,    1,    999,    3 ]
    let Q1_WASTAGE_148 :[Double] =  [148,    888,    5.92,    999,    999,    999,    999,    999,    999,    6,    5.92,    999,    3 ]
    let Q1_WASTAGE_149 :[Double] =  [149,    894,    5.96,    999,    999,    999,    999,    999,    999,    6,    5.96,    999,    3 ]
    let Q1_WASTAGE_150 :[Double] =  [150,    900,    6.00,    999,    999,    999,    999,    999,    999,    6,    6,    999,    3 ]
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menu_const.constant = -280
        pan_gesture.delegate = self

       
        let ekran_boyutu: CGRect = UIScreen.main.bounds
        
        
        
        
        
        
        
        
        
        let birinci_ilaç_layout = UIView(frame: CGRect(x: 50, y: 20 , width: ekran_boyutu.width - 70 , height: ekran_boyutu.height / 4 ))
        birinci_ilaç_layout.layer.cornerRadius = 10
        
        
        
        let birinci_ilaç_image = UIImageView()
        birinci_ilaç_image.frame = CGRect(x: -35, y: 15, width: ((ekran_boyutu.height / 4 ) - 30) / 2, height: (ekran_boyutu.height / 4 ) - 30  )
        birinci_ilaç_image.image = UIImage(named: "pill_orange")
        birinci_ilaç_layout.addSubview(birinci_ilaç_image)
        
        
        
        let frm_ilaç_1: CGRect = birinci_ilaç_image.frame
        let birinci_ilaç_image_dikey_konum = frm_ilaç_1.origin.y
        let birinci_ilaç_image_yatay_konum = frm_ilaç_1.origin.x
        
        
        
        
        
        
        
        
        
        
        
        
        var dose_1_başlık: UILabel!
        var dose_label_1: UILabel!
        
        
        var amount_1_başlık: UILabel!
        var amount_label_1: UILabel!
        
        var form_1_başlık: UILabel!
        var form_label_1: UILabel!
        
        var ilaç_adı_label_1: UILabel!
        
        
        
        
        
        var dose_2_başlık: UILabel!
        var dose_label_2: UILabel!
        
        
        var amount_2_başlık: UILabel!
        var amount_label_2: UILabel!
        
        var form_2_başlık: UILabel!
        var form_label_2: UILabel!
        
        var ilaç_adı_label_2: UILabel!
        
        
        
        
        
        
        var dose_3_başlık: UILabel!
        var dose_label_3: UILabel!
        
        
        var amount_3_başlık: UILabel!
        var amount_label_3: UILabel!
        
        var form_3_başlık: UILabel!
        var form_label_3: UILabel!
        
        var ilaç_adı_label_3: UILabel!
        
        
        
        
        
        ilaç_adı_label_1 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.21 , width: 300, height: birinci_ilaç_layout.frame.height * 0.13))
        ilaç_adı_label_1.text = "Sky Blue"
        ilaç_adı_label_1.textColor = .white
        ilaç_adı_label_1.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        ilaç_adı_label_1.font = ilaç_adı_label_1.font.withSize(birinci_ilaç_layout.frame.height * 0.13)
        birinci_ilaç_layout.addSubview(ilaç_adı_label_1)
        
        
        
        
        let cizgi_1_1 = UIView(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.42 , width: ekran_boyutu.width - 80 - birinci_ilaç_image.frame.maxX - 40 , height: 1 ))
        
        cizgi_1_1.backgroundColor = çizgi_back_beyaz
        birinci_ilaç_layout.addSubview(cizgi_1_1)
        
        
        
        
        
        dose_1_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        dose_1_başlık.text = "DOSE"
        dose_1_başlık.textColor = .white
        dose_1_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        dose_1_başlık.font = dose_1_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        birinci_ilaç_layout.addSubview(dose_1_başlık)
        
        
        
        
        dose_label_1 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        dose_label_1.text = "30 mg"
        dose_label_1.textColor = .white
        dose_label_1.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        dose_label_1.font = dose_1_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        birinci_ilaç_layout.addSubview(dose_label_1)
        
        
        
        amount_1_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.46 , y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        amount_1_başlık.text = "AMOUNT"
        amount_1_başlık.textColor = .white
        amount_1_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        amount_1_başlık.font = amount_1_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        birinci_ilaç_layout.addSubview(amount_1_başlık)
        
        
        
        amount_label_1 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.46 , y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        amount_label_1.text = "0.22 mL"
        amount_label_1.textColor = .white
        amount_label_1.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        amount_label_1.font = amount_label_1.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        birinci_ilaç_layout.addSubview(amount_label_1)
        
        
        
        
        
        form_1_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.76 , y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        form_1_başlık.text = "FORM"
        form_1_başlık.textColor = .white
        form_1_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        form_1_başlık.font = form_1_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        birinci_ilaç_layout.addSubview(form_1_başlık)
        
        
        
        form_label_1 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.76 , y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        form_label_1.text = "1.0 Vial"
        form_label_1.textColor = .white
        form_label_1.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        form_label_1.font = form_label_1.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        birinci_ilaç_layout.addSubview(form_label_1)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let ikinci_ilaç_layout = UIView(frame: CGRect(x: 50, y: (ekran_boyutu.height / 4 ) + 30  , width: ekran_boyutu.width - 70, height: ekran_boyutu.height / 4  ))
        ikinci_ilaç_layout.layer.cornerRadius = 10
        
        
        
        
        
        
        
        
        let ikinci_ilaç_image = UIImageView()
        ikinci_ilaç_image.frame = CGRect(x: -35 , y: 15, width: ((ekran_boyutu.height / 4 ) - 30) / 2, height: (ekran_boyutu.height / 4 ) - 30  )
        ikinci_ilaç_image.image = UIImage(named: "pill_sky_blue")
        ikinci_ilaç_layout.addSubview(ikinci_ilaç_image)
        
        
        
        ilaç_adı_label_2 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.21 , width: 300, height: birinci_ilaç_layout.frame.height * 0.13))
        ilaç_adı_label_2.text = "Sky Blue"
        ilaç_adı_label_2.textColor = .white
        ilaç_adı_label_2.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        ilaç_adı_label_2.font = ilaç_adı_label_2.font.withSize(birinci_ilaç_layout.frame.height * 0.13)
        ikinci_ilaç_layout.addSubview(ilaç_adı_label_2)
        
        
        
        
        let cizgi_1_2 = UIView(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.42 , width: ekran_boyutu.width - 60 - birinci_ilaç_image.frame.maxX - 40 , height: 1 ))
        
        cizgi_1_2.backgroundColor = çizgi_back_beyaz
        ikinci_ilaç_layout.addSubview(cizgi_1_2)
        
        
        
        
        
        dose_2_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        dose_2_başlık.text = "DOSE"
        dose_2_başlık.textColor = .white
        dose_2_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        dose_2_başlık.font = dose_2_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        ikinci_ilaç_layout.addSubview(dose_2_başlık)
        
        
        
        
        dose_label_2 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        dose_label_2.text = "30 mg"
        dose_label_2.textColor = .white
        dose_label_2.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        dose_label_2.font = dose_label_2.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        ikinci_ilaç_layout.addSubview(dose_label_2)
        
        
        
        amount_2_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.46 , y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        amount_2_başlık.text = "AMOUNT"
        amount_2_başlık.textColor = .white
        amount_2_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        amount_2_başlık.font = amount_2_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        ikinci_ilaç_layout.addSubview(amount_2_başlık)
        
        
        
        amount_label_2 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.46 , y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        amount_label_2.text = "0.22 mL"
        amount_label_2.textColor = .white
        amount_label_2.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        amount_label_2.font = amount_label_2.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        ikinci_ilaç_layout.addSubview(amount_label_2)
        
        
        
        
        
        form_2_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.76 , y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        form_2_başlık.text = "FORM"
        form_2_başlık.textColor = .white
        form_2_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        form_2_başlık.font = form_2_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        ikinci_ilaç_layout.addSubview(form_2_başlık)
        
        
        
        form_label_2 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.76 , y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        form_label_2.text = "1.0 Vial"
        form_label_2.textColor = .white
        form_label_2.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        form_label_2.font = form_2_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        ikinci_ilaç_layout.addSubview(form_label_2)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let üçüncü_ilaç_layout = UIView(frame: CGRect(x: 50, y: ((ekran_boyutu.height / 4) * 2) + 40   , width: ekran_boyutu.width - 70, height: ekran_boyutu.height / 4  ))
        üçüncü_ilaç_layout.layer.cornerRadius = 10
        
        
        
        let üçüncü_ilaç_image = UIImageView()
        üçüncü_ilaç_image.frame = CGRect(x: -35, y: 15, width: ((ekran_boyutu.height / 4 ) - 30) / 2, height: (ekran_boyutu.height / 4 ) - 30  )
        üçüncü_ilaç_image.image = UIImage(named: "pill_turquoise")
        üçüncü_ilaç_layout.addSubview(üçüncü_ilaç_image)
        
        
        
        
        ilaç_adı_label_3 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.21 , width: 300, height: birinci_ilaç_layout.frame.height * 0.13))
        ilaç_adı_label_3.text = "Sky Blue"
        ilaç_adı_label_3.textColor = .white
        ilaç_adı_label_3.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        ilaç_adı_label_3.font = ilaç_adı_label_3.font.withSize(birinci_ilaç_layout.frame.height * 0.13)
        üçüncü_ilaç_layout.addSubview(ilaç_adı_label_3)
        
        
        
        
        let cizgi_1_3 = UIView(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.42 , width: ekran_boyutu.width - 60 - birinci_ilaç_image.frame.maxX - 40 , height: 1 ))
        
        cizgi_1_3.backgroundColor = çizgi_back_beyaz
        üçüncü_ilaç_layout.addSubview(cizgi_1_3)
        
        
        
        
        
        dose_3_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        dose_3_başlık.text = "DOSE"
        dose_3_başlık.textColor = .white
        dose_3_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        dose_3_başlık.font = dose_3_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        üçüncü_ilaç_layout.addSubview(dose_3_başlık)
        
        
        
        
        dose_label_3 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.height * 0.38, y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        dose_label_3.text = "30 mg"
        dose_label_3.textColor = .white
        dose_label_3.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        dose_label_3.font = dose_label_3.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        üçüncü_ilaç_layout.addSubview(dose_label_3)
        
        
        
        amount_3_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.46 , y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        amount_3_başlık.text = "AMOUNT"
        amount_3_başlık.textColor = .white
        amount_3_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        amount_3_başlık.font = amount_3_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        üçüncü_ilaç_layout.addSubview(amount_3_başlık)
        
        
        
        amount_label_3 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.46 , y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        amount_label_3.text = "0.22 mL"
        amount_label_3.textColor = .white
        amount_label_3.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        amount_label_3.font = amount_label_3.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        üçüncü_ilaç_layout.addSubview(amount_label_3)
        
        
        
        
        
        form_3_başlık = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.76 , y: birinci_ilaç_layout.frame.height * 0.53 , width: 300, height: birinci_ilaç_layout.frame.height * 0.1))
        form_3_başlık.text = "FORM"
        form_3_başlık.textColor = .white
        form_3_başlık.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        form_3_başlık.font = form_3_başlık.font.withSize(birinci_ilaç_layout.frame.height * 0.09)
        üçüncü_ilaç_layout.addSubview(form_3_başlık)
        
        
        
        form_label_3 = UILabel(frame: CGRect(x: birinci_ilaç_layout.frame.width * 0.76 , y: birinci_ilaç_layout.frame.height * 0.653 , width: 300, height: birinci_ilaç_layout.frame.height * 0.15))
        form_label_3.text = "1.0 Vial"
        form_label_3.textColor = .white
        form_label_3.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 19)
        form_label_3.font = form_label_3.font.withSize(birinci_ilaç_layout.frame.height * 0.11)
        üçüncü_ilaç_layout.addSubview(form_label_3)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        ana_view_result.addSubview(birinci_ilaç_layout)
        ana_view_result.addSubview(ikinci_ilaç_layout)
        ana_view_result.addSubview(üçüncü_ilaç_layout)
        
        
        let alt_layout = UIView(frame: CGRect(x: 15, y: ((ekran_boyutu.height / 4) * 3) + 40, width: ekran_boyutu.width - 30, height: ekran_boyutu.height - 50 ))
        alt_layout.backgroundColor = gri
        
        
        
        
        
        let example_label = UILabel(frame: CGRect(x: 10, y: 10, width: ekran_boyutu.width - 30, height: 60 ))
        example_label.textAlignment = .left
        example_label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 48)
        example_label.text = "EXAMPLE"
        example_label.textColor = siyah_text_color
        alt_layout.addSubview(example_label)
        
        
        let vial_comb_label = UILabel(frame: CGRect(x: 10, y: 65, width: ekran_boyutu.width - 30, height: 60 ))
        vial_comb_label.textAlignment = .left
        vial_comb_label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 48)
        vial_comb_label.text = "VIAL COMBINATION"
        vial_comb_label.textColor = siyah_text_color
        
        alt_layout.addSubview(vial_comb_label)
        
        
        let ekran_genişliği = view.frame.width
        let ekran_yüksekliği = view.frame.height
        
        
        
        if ((ekran_genişliği == 320.0) && (ekran_yüksekliği == 568.0)){
            
            
            example_label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 40)
            vial_comb_label.font = UIFont(name: "TradeGothicLT-BoldCondTwenty", size: 40)
            
            
        }
        
        
        
        let total_dose_baslık = UILabel(frame: CGRect(x: 10, y: 120, width: ekran_boyutu.width / 2, height: 60 ))
        total_dose_baslık.textAlignment = .left
        total_dose_baslık.font = UIFont(name: "OpenSans-Bold", size: 17)
        total_dose_baslık.text = "Total Dose(mg):"
        total_dose_baslık.textColor = siyah_text_color
        alt_layout.addSubview(total_dose_baslık)
        
        
        
        let total_dose = UILabel(frame: CGRect(x: ekran_boyutu.width / 2 - 40 , y: 120, width: ekran_boyutu.width / 2, height: 60 ))
        total_dose.textAlignment = .right
        total_dose.font = UIFont(name: "OpenSans-Bold", size: 17)
        total_dose.text = "6.0 mG"
        total_dose.textColor = siyah_text_color
        alt_layout.addSubview(total_dose)
        
        
        let cizgi_1 = UIView(frame: CGRect(x: 10, y: 185, width: ekran_boyutu.width - 50, height: 1 ))
        cizgi_1.backgroundColor = çizgi_back_siyah
        alt_layout.addSubview(cizgi_1)
        
        
        
        
        let tota_volume_baslık = UILabel(frame: CGRect(x: 10, y: 190, width: ekran_boyutu.width / 2, height: 60 ))
        tota_volume_baslık.textAlignment = .left
        tota_volume_baslık.font = UIFont(name: "OpenSans-Bold", size: 17)
        tota_volume_baslık.text = "Total Volume(mL):"
        tota_volume_baslık.textColor = siyah_text_color
        alt_layout.addSubview(tota_volume_baslık)
        
        
        
        let total_volume_label = UILabel(frame: CGRect(x: ekran_boyutu.width / 2 - 40 , y: 190, width: ekran_boyutu.width / 2, height: 60 ))
        total_volume_label.textAlignment = .right
        total_volume_label.font = UIFont(name: "OpenSans-Bold", size: 17)
        total_volume_label.text = "0.2 mL"
        total_volume_label.textColor = siyah_text_color
        alt_layout.addSubview(total_volume_label)
        
        
        let cizgi_2 = UIView(frame: CGRect(x: 10, y: 250, width: ekran_boyutu.width - 50, height: 1 ))
        cizgi_2.backgroundColor = çizgi_back_siyah
        alt_layout.addSubview(cizgi_2)
        
        
        
        let bir_syringe_başlık = UILabel(frame: CGRect(x: 10, y: 255, width: ekran_boyutu.width / 2, height: 60 ))
        bir_syringe_başlık.textAlignment = .left
        bir_syringe_başlık.font = UIFont(name: "OpenSans-Bold", size: 17)
        bir_syringe_başlık.text = "1 mgL Syringe"
        bir_syringe_başlık.textColor = siyah_text_color
        alt_layout.addSubview(bir_syringe_başlık)
        
        
        
        let bir_syringe_label = UILabel(frame: CGRect(x: ekran_boyutu.width / 2 - 40 , y: 255, width: ekran_boyutu.width / 2, height: 60 ))
        bir_syringe_label.textAlignment = .right
        bir_syringe_label.font = UIFont(name: "OpenSans-Bold", size: 17)
        bir_syringe_label.text = "1"
        bir_syringe_label.textColor = siyah_text_color
        alt_layout.addSubview(bir_syringe_label)
        
        
        let cizgi_3 = UIView(frame: CGRect(x: 10, y: 320, width: ekran_boyutu.width - 50, height: 1 ))
        cizgi_3.backgroundColor = çizgi_back_siyah
        alt_layout.addSubview(cizgi_3)
        
        
        
        let iki_syringe_başlık = UILabel(frame: CGRect(x: 10, y: 325, width: ekran_boyutu.width / 2, height: 60 ))
        iki_syringe_başlık.textAlignment = .left
        iki_syringe_başlık.font = UIFont(name: "OpenSans-Bold", size: 17)
        iki_syringe_başlık.text = "2 or 3 mgL Syringe"
        iki_syringe_başlık.textColor = siyah_text_color
        alt_layout.addSubview(iki_syringe_başlık)
        
        
        
        let iki_syringe_label = UILabel(frame: CGRect(x: ekran_boyutu.width / 2 - 40 , y: 325, width: ekran_boyutu.width / 2, height: 60 ))
        iki_syringe_label.textAlignment = .right
        iki_syringe_label.font = UIFont(name: "OpenSans-Bold", size: 17)
        iki_syringe_label.text = "0"
        iki_syringe_label.textColor = siyah_text_color
        alt_layout.addSubview(iki_syringe_label)
        
        
        let cizgi_4 = UIView(frame: CGRect(x: 10, y: 390, width: ekran_boyutu.width - 50, height: 1 ))
        cizgi_4.backgroundColor = çizgi_back_siyah
        alt_layout.addSubview(cizgi_4)
        
        
        
        let calculate_again_button = UIButton()
        calculate_again_button.frame = CGRect(x: 10, y: 405, width: ekran_boyutu.width - 50, height: 60)
        calculate_again_button.backgroundColor = turuncu
        calculate_again_button.layer.cornerRadius = 5
        calculate_again_button.layer.borderWidth = 0
        calculate_again_button.setTitleColor(.white, for: .normal)
        
        calculate_again_button.titleLabel?.font =  UIFont(name: "OpenSans-Bold", size: 17)
        
        
        calculate_again_button.setTitle("Calculate Again", for: .normal)
        calculate_again_button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        alt_layout.addSubview(calculate_again_button)
        
        
        
        
        
        
        
        
        
        self.ana_view_result.addSubview(alt_layout)
        
        
        total_dose_değeri_int = kilo * 6
        
        
        if (kilo==3  ){
            
            aranacak_dizi = Q1_WASTAGE_3
            
            
        }
        else  if (kilo == 4 ){
            
            aranacak_dizi = Q1_WASTAGE_4
            
        }else if (kilo==5  ){
            
            aranacak_dizi = Q1_WASTAGE_5
            
            
        }
        else  if (kilo == 6 ){
            
            aranacak_dizi = Q1_WASTAGE_6
            
        }else  if (kilo == 7 ){
            
            aranacak_dizi = Q1_WASTAGE_7
            
        }else if (kilo==8  ){
            
            aranacak_dizi = Q1_WASTAGE_8
            
            
        }
        else  if (kilo == 9 ){
            
            aranacak_dizi = Q1_WASTAGE_9
            
        }else  if (kilo == 10 ){
            
            aranacak_dizi = Q1_WASTAGE_10
            
        } else if (kilo == 11 ){
            
            aranacak_dizi = Q1_WASTAGE_11
            
            
        }
        else  if (kilo == 12 ){
            
            aranacak_dizi = Q1_WASTAGE_12
            
        }else if (kilo == 13  ){
            
            aranacak_dizi = Q1_WASTAGE_5
            
            
        }
        else  if (kilo == 14 ){
            
            aranacak_dizi = Q1_WASTAGE_14
            
        }else  if (kilo == 15 ){
            
            aranacak_dizi = Q1_WASTAGE_15
            
        }else if (kilo == 16  ){
            
            aranacak_dizi = Q1_WASTAGE_16
            
            
        }else  if (kilo == 17 ){
            
            aranacak_dizi = Q1_WASTAGE_17
            
        }else  if (kilo == 18 ){
            
            aranacak_dizi = Q1_WASTAGE_18
            
        }else  if (kilo == 19 ){
            
            aranacak_dizi = Q1_WASTAGE_19
            
        }else  if (kilo == 20 ){
            
            aranacak_dizi = Q1_WASTAGE_20
            
        }else  if (kilo == 21 ){
            
            aranacak_dizi = Q1_WASTAGE_21
            
        }else if (kilo == 22  ){
            
            aranacak_dizi = Q1_WASTAGE_22
            
            
        }
        else  if (kilo == 23 ){
            
            aranacak_dizi = Q1_WASTAGE_23
            
        }else  if (kilo == 24 ){
            
            aranacak_dizi = Q1_WASTAGE_24
            
        }else if (kilo == 25  ){
            
            aranacak_dizi = Q1_WASTAGE_25
            
            
        }
        else  if (kilo == 26 ){
            
            aranacak_dizi = Q1_WASTAGE_26
            
        }else  if (kilo == 27 ){
            
            aranacak_dizi = Q1_WASTAGE_27
            
        } else if (kilo == 28 ){
            
            aranacak_dizi = Q1_WASTAGE_28
            
            
        }
        else  if (kilo == 29 ){
            
            aranacak_dizi = Q1_WASTAGE_29
            
        }else if (kilo == 30  ){
            
            aranacak_dizi = Q1_WASTAGE_30
            
            
        }
        else  if (kilo == 31 ){
            
            aranacak_dizi = Q1_WASTAGE_31
            
        }else  if (kilo == 32 ){
            
            aranacak_dizi = Q1_WASTAGE_32
            
        }else if (kilo == 33  ){
            
            aranacak_dizi = Q1_WASTAGE_33
            
            
        }
        else  if (kilo == 34 ){
            
            aranacak_dizi = Q1_WASTAGE_34
            
        }else  if (kilo == 35 ){
            
            aranacak_dizi = Q1_WASTAGE_35
            
        }else  if (kilo == 36 ){
            
            aranacak_dizi = Q1_WASTAGE_36
            
        }else  if (kilo == 37 ){
            
            aranacak_dizi = Q1_WASTAGE_37
            
        }else  if (kilo == 38 ){
            
            aranacak_dizi = Q1_WASTAGE_38
            
        }else if (kilo == 39  ){
            
            aranacak_dizi = Q1_WASTAGE_39
            
            
        }
        else  if (kilo == 40 ){
            
            aranacak_dizi = Q1_WASTAGE_40
            
        }else  if (kilo == 41 ){
            
            aranacak_dizi = Q1_WASTAGE_41
            
        }else if (kilo == 42  ){
            
            aranacak_dizi = Q1_WASTAGE_42
            
            
        }
        else  if (kilo == 43 ){
            
            aranacak_dizi = Q1_WASTAGE_43
            
        }else  if (kilo == 44 ){
            
            aranacak_dizi = Q1_WASTAGE_45
            
        } else if (kilo == 46 ){
            
            aranacak_dizi = Q1_WASTAGE_46
            
            
        }
        else  if (kilo == 47 ){
            
            aranacak_dizi = Q1_WASTAGE_47
            
        }else if (kilo == 48  ){
            
            aranacak_dizi = Q1_WASTAGE_48
            
            
        }
        else  if (kilo == 49 ){
            
            aranacak_dizi = Q1_WASTAGE_49
            
        }else  if (kilo == 50 ){
            
            aranacak_dizi = Q1_WASTAGE_50
            
        }else if (kilo == 51  ){
            
            aranacak_dizi = Q1_WASTAGE_51
            
            
        }
        else  if (kilo == 52 ){
            
            aranacak_dizi = Q1_WASTAGE_52
            
        }else  if (kilo == 53 ){
            
            aranacak_dizi = Q1_WASTAGE_53
            
        }else  if (kilo == 54 ){
            
            aranacak_dizi = Q1_WASTAGE_54
            
        }else  if (kilo == 55 ){
            
            aranacak_dizi = Q1_WASTAGE_55
            
        }else  if (kilo == 56 ){
            
            aranacak_dizi = Q1_WASTAGE_56
            
        }else if (kilo == 57  ){
            
            aranacak_dizi = Q1_WASTAGE_57
            
            
        }
        else  if (kilo == 58 ){
            
            aranacak_dizi = Q1_WASTAGE_58
            
        }else  if (kilo == 59 ){
            
            aranacak_dizi = Q1_WASTAGE_59
            
        }else if (kilo == 60  ){
            
            aranacak_dizi = Q1_WASTAGE_60
            
            
        }else if (kilo == 61  ){
            
            aranacak_dizi = Q1_WASTAGE_61
            
            
        }else if (kilo == 62  ){
            
            aranacak_dizi = Q1_WASTAGE_62
            
            
        }else if (kilo == 63  ){
            
            aranacak_dizi = Q1_WASTAGE_63
            
            
        }else if (kilo == 64  ){
            
            aranacak_dizi = Q1_WASTAGE_64
            
            
        }else if (kilo == 65  ){
            
            aranacak_dizi = Q1_WASTAGE_65
            
            
        }else if (kilo == 66  ){
            
            aranacak_dizi = Q1_WASTAGE_66
            
            
        }else if (kilo == 67  ){
            
            aranacak_dizi = Q1_WASTAGE_67
            
            
        }else if (kilo == 68  ){
            
            aranacak_dizi = Q1_WASTAGE_68
            
            
        }else if (kilo == 69  ){
            
            aranacak_dizi = Q1_WASTAGE_69
            
            
        }
            
        else  if (kilo == 70 ){
            
            aranacak_dizi = Q1_WASTAGE_70
            
        }else  if (kilo == 71 ){
            
            aranacak_dizi = Q1_WASTAGE_71
            
        } else if (kilo == 72 ){
            
            aranacak_dizi = Q1_WASTAGE_72
            
            
        }
        else  if (kilo == 73 ){
            
            aranacak_dizi = Q1_WASTAGE_73
            
        }else if (kilo == 74  ){
            
            aranacak_dizi = Q1_WASTAGE_74
            
            
        }
        else  if (kilo == 75 ){
            
            aranacak_dizi = Q1_WASTAGE_75
            
        }else  if (kilo == 76 ){
            
            aranacak_dizi = Q1_WASTAGE_76
            
        }else if (kilo == 77  ){
            
            aranacak_dizi = Q1_WASTAGE_77
            
            
        }
        else  if (kilo == 78 ){
            
            aranacak_dizi = Q1_WASTAGE_78
            
        }else  if (kilo == 79 ){
            
            aranacak_dizi = Q1_WASTAGE_79
            
        }else  if (kilo == 80 ){
            
            aranacak_dizi = Q1_WASTAGE_80
            
        }else  if (kilo == 81 ){
            
            aranacak_dizi = Q1_WASTAGE_81
            
        }else  if (kilo == 82 ){
            
            aranacak_dizi = Q1_WASTAGE_82
            
        }else if (kilo == 83  ){
            
            aranacak_dizi = Q1_WASTAGE_83
            
            
        }
        else  if (kilo == 84 ){
            
            aranacak_dizi = Q1_WASTAGE_84
            
        }else  if (kilo == 85 ){
            
            aranacak_dizi = Q1_WASTAGE_85
            
        }else if (kilo == 86 ){
            
            aranacak_dizi = Q1_WASTAGE_86
            
            
        }
        else  if (kilo == 87 ){
            
            aranacak_dizi = Q1_WASTAGE_87
            
        }else  if (kilo == 88 ){
            
            aranacak_dizi = Q1_WASTAGE_88
            
        } else if (kilo == 89 ){
            
            aranacak_dizi = Q1_WASTAGE_89
            
            
        }
        else  if (kilo == 90 ){
            
            aranacak_dizi = Q1_WASTAGE_90
            
        }else if (kilo == 91  ){
            
            aranacak_dizi = Q1_WASTAGE_91
            
            
        }
        else  if (kilo == 92 ){
            
            aranacak_dizi = Q1_WASTAGE_92
            
        }else  if (kilo == 93 ){
            
            aranacak_dizi = Q1_WASTAGE_93
            
        }else if (kilo == 94  ){
            
            aranacak_dizi = Q1_WASTAGE_94
            
            
        }
        else  if (kilo == 95 ){
            
            aranacak_dizi = Q1_WASTAGE_95
            
        }else  if (kilo == 96 ){
            
            aranacak_dizi = Q1_WASTAGE_96
            
        }else  if (kilo == 97 ){
            
            aranacak_dizi = Q1_WASTAGE_97
            
        }else  if (kilo == 98 ){
            
            aranacak_dizi = Q1_WASTAGE_98
            
        }else  if (kilo == 99 ){
            
            aranacak_dizi = Q1_WASTAGE_99
            
        }else if (kilo == 100  ){
            
            aranacak_dizi = Q1_WASTAGE_100
            
            
        }
        else  if (kilo == 101 ){
            
            aranacak_dizi = Q1_WASTAGE_101
            
        }else  if (kilo == 102 ){
            
            aranacak_dizi = Q1_WASTAGE_102
            
        }else if (kilo == 103  ){
            
            aranacak_dizi = Q1_WASTAGE_103
            
            
        }
        else  if (kilo == 104 ){
            
            aranacak_dizi = Q1_WASTAGE_104
            
        }else  if (kilo == 105 ){
            
            aranacak_dizi = Q1_WASTAGE_105
            
        } else if (kilo == 106 ){
            
            aranacak_dizi = Q1_WASTAGE_106
            
            
        }
        else  if (kilo == 107 ){
            
            aranacak_dizi = Q1_WASTAGE_107
            
        }else if (kilo == 108  ){
            
            aranacak_dizi = Q1_WASTAGE_108
            
            
        }
        else  if (kilo == 109 ){
            
            aranacak_dizi = Q1_WASTAGE_109
            
        }else  if (kilo == 110 ){
            
            aranacak_dizi = Q1_WASTAGE_110
            
        }else if (kilo == 111  ){
            
            aranacak_dizi = Q1_WASTAGE_111
            
            
        }
        else  if (kilo == 112 ){
            
            aranacak_dizi = Q1_WASTAGE_112
            
        }else  if (kilo == 113 ){
            
            aranacak_dizi = Q1_WASTAGE_113
            
        }else  if (kilo == 114 ){
            
            aranacak_dizi = Q1_WASTAGE_115
            
        }else  if (kilo == 116 ){
            
            aranacak_dizi = Q1_WASTAGE_117
            
        }else  if (kilo == 118 ){
            
            aranacak_dizi = Q1_WASTAGE_118
            
        }else if (kilo == 119  ){
            
            aranacak_dizi = Q1_WASTAGE_119
            
            
        }
        else  if (kilo == 120 ){
            
            aranacak_dizi = Q1_WASTAGE_120
            
        }else  if (kilo == 121 ){
            
            aranacak_dizi = Q1_WASTAGE_121
            
        }else if (kilo == 122  ){
            
            aranacak_dizi = Q1_WASTAGE_122
            
            
        }
        else  if (kilo == 123 ){
            
            aranacak_dizi = Q1_WASTAGE_123
            
        }else  if (kilo == 124 ){
            
            aranacak_dizi = Q1_WASTAGE_124
            
        } else if (kilo == 125 ){
            
            aranacak_dizi = Q1_WASTAGE_125
            
            
        }
        else  if (kilo == 126 ){
            
            aranacak_dizi = Q1_WASTAGE_126
            
        }else if (kilo == 127  ){
            
            aranacak_dizi = Q1_WASTAGE_127
            
            
        }
        else  if (kilo == 128 ){
            
            aranacak_dizi = Q1_WASTAGE_128
            
        }else  if (kilo == 129 ){
            
            aranacak_dizi = Q1_WASTAGE_129
            
        }else if (kilo == 130  ){
            
            aranacak_dizi = Q1_WASTAGE_130
            
            
        }
        else  if (kilo == 131 ){
            
            aranacak_dizi = Q1_WASTAGE_131
            
        }else  if (kilo == 132 ){
            
            aranacak_dizi = Q1_WASTAGE_132
            
        }else  if (kilo == 133 ){
            
            aranacak_dizi = Q1_WASTAGE_133
            
        }else  if (kilo == 134 ){
            
            aranacak_dizi = Q1_WASTAGE_134
            
        }else  if (kilo == 135 ){
            
            aranacak_dizi = Q1_WASTAGE_135
            
        }else  if (kilo == 136 ){
            
            aranacak_dizi = Q1_WASTAGE_136
            
        }else if (kilo == 137  ){
            
            aranacak_dizi = Q1_WASTAGE_137
            
            
        }
        else  if (kilo == 138 ){
            
            aranacak_dizi = Q1_WASTAGE_138
            
        }else  if (kilo == 139 ){
            
            aranacak_dizi = Q1_WASTAGE_139
            
        } else if (kilo == 140 ){
            
            aranacak_dizi = Q1_WASTAGE_140
            
            
        }
        else  if (kilo == 141 ){
            
            aranacak_dizi = Q1_WASTAGE_141
            
        }else if (kilo == 142  ){
            
            aranacak_dizi = Q1_WASTAGE_142
            
            
        }
        else  if (kilo == 143 ){
            
            aranacak_dizi = Q1_WASTAGE_143
            
        }else  if (kilo == 144 ){
            
            aranacak_dizi = Q1_WASTAGE_144
            
        }else if (kilo == 145  ){
            
            aranacak_dizi = Q1_WASTAGE_145
            
            
        }
        else  if (kilo == 146 ){
            
            aranacak_dizi = Q1_WASTAGE_146
            
        }else  if (kilo == 147 ){
            
            aranacak_dizi = Q1_WASTAGE_147
            
        }else  if (kilo == 148 ){
            
            aranacak_dizi = Q1_WASTAGE_148
            
        }else  if (kilo == 149 ){
            
            aranacak_dizi = Q1_WASTAGE_149
            
        }else  if (kilo == 150 ){
            
            aranacak_dizi = Q1_WASTAGE_150
            
        }
        
        
        
        
        
        
        
        if (aranacak_dizi[3] != 999  ) {
            
            
            total_volume_değeri = (aranacak_dizi[2]);
            bir_mg_syringe_değeri = aranacak_dizi[11];
            iki_üç_syringe_değeri = (aranacak_dizi[12]);
            
            sky_blue_vial_değeri = aranacak_dizi[3]
            sky_blue_volume_değeri = aranacak_dizi[4]
            
            
            if ((aranacak_dizi[11]) == 999.0 ){
                
                bir_mg_syringe_değeri = 0;
                
            }
            if ((aranacak_dizi[12]) == 999.0 ){
                
                iki_üç_syringe_değeri = 0;
                
            }
            
            ilaç_harf_1 = "S";
        }
        
        
        
        
        
        
        if (aranacak_dizi[5] != 999  ) {
            
            
            total_volume_değeri = (aranacak_dizi[2]);
            bir_mg_syringe_değeri = aranacak_dizi[11];
            iki_üç_syringe_değeri = (aranacak_dizi[12]);
            
            purple_vial_değeri = aranacak_dizi[5]
            purple_volume_değeri = aranacak_dizi[6]
            
            
            if ((aranacak_dizi[11]) == 999.0 ){
                
                bir_mg_syringe_değeri = 0;
                
            }
            if ((aranacak_dizi[12]) == 999.0 ){
                
                iki_üç_syringe_değeri = 0;
                
            }
            
            ilaç_harf_2 = "P";
        }
        
        
        
        if (aranacak_dizi[7] != 999  ) {
            
            
            total_volume_değeri = (aranacak_dizi[2]);
            bir_mg_syringe_değeri = aranacak_dizi[11];
            iki_üç_syringe_değeri = (aranacak_dizi[12]);
            
            turquoise_vial_değeri = aranacak_dizi[7]
            turquoise_volume_değeri = aranacak_dizi[8]
            
            
            if ((aranacak_dizi[11]) == 999.0 ){
                
                bir_mg_syringe_değeri = 0;
                
            }
            if ((aranacak_dizi[12]) == 999.0 ){
                
                iki_üç_syringe_değeri = 0;
                
            }
            
            ilaç_harf_3 = "T";
        }
        
        
        
        if (aranacak_dizi[9] != 999  ) {
            
            
            total_volume_değeri = (aranacak_dizi[2]);
            bir_mg_syringe_değeri = aranacak_dizi[11];
            iki_üç_syringe_değeri = (aranacak_dizi[12]);
            
            orange_vial_değeri = aranacak_dizi[9]
            orange_volume_değeri = aranacak_dizi[10]
            
            
            if ((aranacak_dizi[11]) == 999.0 ){
                
                bir_mg_syringe_değeri = 0;
                
            }
            if ((aranacak_dizi[12]) == 999.0 ){
                
                iki_üç_syringe_değeri = 0;
                
            }
            
            ilaç_harf_4 = "O";
        }
        
        
        ilaç_sıralaması = ilaç_harf_1 + ilaç_harf_2 + ilaç_harf_3 + ilaç_harf_4
        
        print(ilaç_sıralaması)
        
        
        
        if (ilaç_sıralaması.contains("Syyy")){
            
            
            ikinci_ilaç_layout.isHidden = true
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = SkyBlue
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            var sky_blue_vial_str_değeri = "\(sky_blue_vial_değeri)"
            var sky_blue_volume_str_değeri = "\(sky_blue_volume_değeri)"
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            dose_label_1.text = sky_blue_dose_değeri
            amount_label_1.text = sky_blue_volume_str_değeri + " mL"
            form_label_1.text = sky_blue_vial_str_değeri + " Vial"
            
            birinci_ilaç_image.image = UIImage(named: "pill_sky_blue")
            birinci_ilaç_layout.backgroundColor = back_sky_blue
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height + 30  , width: ekran_boyutu.width - 30 , height: ekran_boyutu.height - 50 )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
            
            
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("yPyy")){
            
            
            
            ikinci_ilaç_layout.isHidden = true
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = Purple
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            var purple_vial_str_değeri = "\(purple_vial_değeri)"
            var purple_volume_str_değeri = "\(purple_volume_değeri)"
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            dose_label_1.text = purple_dose_değeri
            amount_label_1.text = purple_volume_str_değeri + " mL"
            form_label_1.text = purple_vial_str_değeri + " Vial"
            
            birinci_ilaç_image.image = UIImage(named: "pill_purple")
            birinci_ilaç_layout.backgroundColor = back_puple
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("SPyy")){
            
            
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = SkyBlue
            ilaç_adı_label_2.text = Purple
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            var purple_vial_str_değeri = "\(purple_vial_değeri)"
            var purple_volume_str_değeri = "\(purple_volume_değeri)"
            
            var sky_blue_vial_str_değeri = "\(sky_blue_vial_değeri)"
            var sky_blue_volume_str_değeri = "\(sky_blue_volume_değeri)"
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            dose_label_1.text = sky_blue_dose_değeri
            amount_label_1.text = sky_blue_volume_str_değeri + " mL"
            form_label_1.text = sky_blue_vial_str_değeri + " Vial"
            
            dose_label_2.text = purple_dose_değeri
            amount_label_2.text = purple_volume_str_değeri + " mL"
            form_label_2.text = purple_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_sky_blue")
            birinci_ilaç_layout.backgroundColor = back_sky_blue
            
            
            ikinci_ilaç_image.image = UIImage(named: "pill_purple")
            ikinci_ilaç_layout.backgroundColor = back_puple
            
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height * 2 + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("yyTy")){
            
            
            ikinci_ilaç_layout.isHidden = true
            
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = Turquoise
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            var turquoise_vial_str_değeri = "\(turquoise_vial_değeri)"
            var turquoise_volume_str_değeri = "\(turquoise_volume_değeri)"
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            dose_label_1.text = turquoise_dose_değeri
            amount_label_1.text = turquoise_volume_str_değeri + " mL"
            form_label_1.text = turquoise_vial_str_değeri + " Vial"
            
            birinci_ilaç_image.image = UIImage(named: "pill_turquoise")
            birinci_ilaç_layout.backgroundColor = back_turquoise
            
            
            
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("SyTy")){
            
            
            
            
            
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = SkyBlue
            ilaç_adı_label_2.text = Turquoise
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            
            
            var turquoise_vial_str_değeri = "\(turquoise_vial_değeri)"
            var turquoise_volume_str_değeri = "\(turquoise_volume_değeri)"
            
            var sky_blue_vial_str_değeri = "\(sky_blue_vial_değeri)"
            var sky_blue_volume_str_değeri = "\(sky_blue_volume_değeri)"
            
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            dose_label_1.text = sky_blue_dose_değeri
            amount_label_1.text = sky_blue_volume_str_değeri + " mL"
            form_label_1.text = sky_blue_vial_str_değeri + " Vial"
            
            dose_label_2.text = turquoise_dose_değeri
            amount_label_2.text = turquoise_volume_str_değeri + " mL"
            form_label_2.text = turquoise_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_sky_blue")
            birinci_ilaç_layout.backgroundColor = back_sky_blue
            
            
            ikinci_ilaç_image.image = UIImage(named: "pill_turquoise")
            ikinci_ilaç_layout.backgroundColor = back_turquoise
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height * 2 + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("yyyO")){
            
            
            
            ikinci_ilaç_layout.isHidden = true
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = Orange
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            var orange_vial_str_değeri = "\(orange_vial_değeri)"
            var orange_volume_str_değeri = "\(orange_volume_değeri)"
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            dose_label_1.text = orange_dose_değeri
            amount_label_1.text = orange_volume_str_değeri + " mL"
            form_label_1.text = orange_vial_str_değeri + " Vial"
            
            birinci_ilaç_image.image = UIImage(named: "pill_orange")
            birinci_ilaç_layout.backgroundColor = back_orange
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("yPTy")){
            
            
            
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = Purple
            ilaç_adı_label_2.text = Turquoise
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            
            
            var turquoise_vial_str_değeri = "\(turquoise_vial_değeri)"
            var turquoise_volume_str_değeri = "\(turquoise_volume_değeri)"
            
            var purple_vial_str_değeri = "\(purple_vial_değeri)"
            var purple_volume_str_değeri = "\(purple_volume_değeri)"
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            
            
            dose_label_1.text = purple_dose_değeri
            amount_label_1.text = purple_volume_str_değeri + " mL"
            form_label_1.text = purple_vial_str_değeri + " Vial"
            
            dose_label_2.text = turquoise_dose_değeri
            amount_label_2.text = turquoise_volume_str_değeri + " mL"
            form_label_2.text = turquoise_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_purple")
            birinci_ilaç_layout.backgroundColor = back_puple
            
            
            ikinci_ilaç_image.image = UIImage(named: "pill_turquoise")
            ikinci_ilaç_layout.backgroundColor = back_turquoise
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height * 2 + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("SyyO")){
            
            
            
            
            
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = SkyBlue
            ilaç_adı_label_2.text = Orange
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            
            
            var orange_vial_str_değeri = "\(orange_vial_değeri)"
            var orange_volume_str_değeri = "\(orange_volume_değeri)"
            
            var sky_blue_vial_str_değeri = "\(sky_blue_vial_değeri)"
            var sky_blue_volume_str_değeri = "\(sky_blue_volume_değeri)"
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            dose_label_1.text = sky_blue_dose_değeri
            amount_label_1.text = sky_blue_volume_str_değeri + " mL"
            form_label_1.text = sky_blue_vial_str_değeri + " Vial"
            
            dose_label_2.text = orange_dose_değeri
            amount_label_2.text = orange_volume_str_değeri + " mL"
            form_label_2.text = orange_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_sky_blue")
            birinci_ilaç_layout.backgroundColor = back_sky_blue
            
            ikinci_ilaç_image.image = UIImage(named: "pill_orange")
            ikinci_ilaç_layout.backgroundColor = back_orange
            
            
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height * 2  + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
            
            
            
        }
        else if (ilaç_sıralaması.contains("SPTy")){
            
            ilaç_adı_label_1.text = SkyBlue
            ilaç_adı_label_2.text = Purple
            ilaç_adı_label_3.text = Turquoise
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            
            var purple_vial_str_değeri = "\(purple_vial_değeri)"
            var purple_volume_str_değeri = "\(purple_volume_değeri)"
            
            var sky_blue_vial_str_değeri = "\(sky_blue_vial_değeri)"
            var sky_blue_volume_str_değeri = "\(sky_blue_volume_değeri)"
            
            
            var turquoise_vial_str_değeri = "\(turquoise_vial_değeri)"
            var turquoise_volume_str_değeri = "\(turquoise_volume_değeri)"
            
            
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            dose_label_1.text = sky_blue_dose_değeri
            amount_label_1.text = sky_blue_volume_str_değeri + " mL"
            form_label_1.text = sky_blue_vial_str_değeri + " Vial"
            
            dose_label_2.text = purple_dose_değeri
            amount_label_2.text = purple_volume_str_değeri + " mL"
            form_label_2.text = purple_vial_str_değeri + " Vial"
            
            dose_label_3.text = turquoise_dose_değeri
            amount_label_3.text = turquoise_volume_str_değeri + " mL"
            form_label_3.text = turquoise_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_sky_blue")
            birinci_ilaç_layout.backgroundColor = back_sky_blue
            
            ikinci_ilaç_image.image = UIImage(named: "pill_purple")
            ikinci_ilaç_layout.backgroundColor = back_puple
            
            
            üçüncü_ilaç_image.image = UIImage(named: "pill_turquoise")
            üçüncü_ilaç_layout.backgroundColor = back_turquoise
            
            
            
        }
            
        else if (ilaç_sıralaması.contains("yyTO")){
            
            
            
            
            üçüncü_ilaç_layout.isHidden = true
            
            ilaç_adı_label_1.text = Turquoise
            ilaç_adı_label_2.text = Orange
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            
            
            var orange_vial_str_değeri = "\(orange_vial_değeri)"
            var orange_volume_str_değeri = "\(orange_volume_değeri)"
            
            var turquoise_vial_str_değeri = "\(turquoise_vial_değeri)"
            var turquoise_volume_str_değeri = "\(turquoise_volume_değeri)"
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            dose_label_1.text = turquoise_dose_değeri
            amount_label_1.text = turquoise_volume_str_değeri + " mL"
            form_label_1.text = turquoise_vial_str_değeri + " Vial"
            
            dose_label_2.text = orange_dose_değeri
            amount_label_2.text = orange_volume_str_değeri + " mL"
            form_label_2.text = orange_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_turquoise")
            birinci_ilaç_layout.backgroundColor = back_turquoise
            
            
            ikinci_ilaç_image.image = UIImage(named: "pill_orange")
            ikinci_ilaç_layout.backgroundColor = back_orange
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height * 2 + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
        }
            
        else if (ilaç_sıralaması.contains("yPyO")){
            
            
            
            
            üçüncü_ilaç_layout.isHidden = true
            ilaç_adı_label_1.text = Purple
            ilaç_adı_label_2.text = Orange
            
            
            
            var bir_syringe_int = Int(bir_mg_syringe_değeri)
            var iki_üç_syringe_değeri_int = Int(iki_üç_syringe_değeri)
            
            var total_volume_str_değeri = "\(total_volume_değeri)"
            var bir_mg_syringe_str_değeri = "\(bir_syringe_int)"
            var iki_üç_syringe_str_değeri = "\(iki_üç_syringe_değeri_int)"
            
            
            var orange_vial_str_değeri = "\(orange_vial_değeri)"
            var orange_volume_str_değeri = "\(orange_volume_değeri)"
            
            var purple_vial_str_değeri = "\(purple_vial_değeri)"
            var purple_volume_str_değeri = "\(purple_volume_değeri)"
            
            total_volume_label.text = total_volume_str_değeri + " mL"
            bir_syringe_label.text = bir_mg_syringe_str_değeri
            iki_syringe_label.text = iki_üç_syringe_str_değeri
            total_dose.text = "\(total_dose_değeri_int) mG"
            
            
            
            dose_label_1.text = purple_dose_değeri
            amount_label_1.text = purple_volume_str_değeri + " mL"
            form_label_1.text = purple_vial_str_değeri + " Vial"
            
            dose_label_2.text = orange_dose_değeri
            amount_label_2.text = orange_volume_str_değeri + " mL"
            form_label_2.text = orange_vial_str_değeri + " Vial"
            
            
            
            
            birinci_ilaç_image.image = UIImage(named: "pill_purple")
            birinci_ilaç_layout.backgroundColor = back_puple
            
            
            ikinci_ilaç_image.image = UIImage(named: "pill_orange")
            ikinci_ilaç_layout.backgroundColor = back_orange
            
            
            
            alt_layout.frame = CGRect(x: 15 , y:  birinci_ilaç_layout.frame.height * 2 + 30  , width: view.frame.width - 30 , height: ana_view_result.frame.height )
            self.ana_view_result.addSubview(alt_layout)
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    @objc func buttonAction(sender: UIButton!) {
        
        
        
        
        performSegue(withIdentifier: "injections_3_ana", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( segue.identifier == "injections_3_ana" ){
            
            let vc = segue.destination as! YeniAnaSayfa
            vc.kilo = kilo
            
        }
        
        
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer == scroll_view.panGestureRecognizer { // or tableView.panGestureRecognizer
            return false
        } else {
            return false
        }
        
    }
    
    
    @IBAction func menu_action(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, animations:{
            
            
            self.menu_const.constant = 0
            self.view.layoutIfNeeded()
            
            
        })
    }
    
    
    @IBAction func pan_action_1(_ sender: UIPanGestureRecognizer) {
        
        
        
        
        if sender.state == .began {
        let vel = sender.velocity(in: view) // view is your UIView
        if vel.x > 10 {
        print("right")
        
        
        UIView.animate(withDuration: 0.2, animations:{
        
        
        self.menu_const.constant = -280
        self.view.layoutIfNeeded()
        
        
        })
        
        
        
        } else {
        print("left")
        
        
        
        UIView.animate(withDuration: 0.2, animations:{
        
        
        self.menu_const.constant = 0
        self.view.layoutIfNeeded()
        
        
        })
        
        
        }
        }
        
    }
    
    @IBAction func log_out_button(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in
            if (error == nil){
                
                self.performSegue(withIdentifier: "injections_3_login", sender: nil)
                print("çıkıldı")
                
                
                
                
                
                
            }else{
                if let descrip = error?.localizedDescription{
                    
                    print(descrip)
                    
                    
                }else{
                    
                    
                }
                
            }
        }
    }
    }
    

