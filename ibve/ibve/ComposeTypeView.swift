//
//  ComposeTypeView.swift
//  ibve
//
//  Created by yesway on 16/8/12.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class ComposeTypeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func composeTypeView() ->ComposeTypeView {
        
        let nib = UINib(nibName: "ComposeTypeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! ComposeTypeView
        
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
        
    }
}

extension ComposeTypeView {
    func setupUI() {
        
    }
}
