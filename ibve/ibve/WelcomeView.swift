//
//  WelcomeView.swift
//  ibve
//
//  Created by yesway on 16/7/26.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    
    class func showWelcomeView() -> WelcomeView {
        
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        
        guard let v = nib.instantiate(withOwner: nil, options: nil)[0] as? WelcomeView else {
            return WelcomeView()
        }
        v.frame = UIScreen.main().bounds
        
        return v
    }
    
    

}
