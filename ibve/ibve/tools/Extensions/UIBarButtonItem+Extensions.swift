//
//  UIBarButtonItem+Extensions.swift
//  ibve
//
//  Created by yesway on 16/7/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    
    convenience init(title: String, fontSize: CGFloat = 16,target: AnyObject?, action: Selector, isBack: Bool = false) {
        
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: UIControlState(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
    
}
