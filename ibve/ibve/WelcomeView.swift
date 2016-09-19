//
//  WelcomeView.swift
//  ibve
//
//  Created by yesway on 16/7/26.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import SDWebImage
class WelcomeView: UIView {
    
    @IBOutlet weak var ad_background: UIImageView!
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var tiplabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    class func showWelcomeView() -> WelcomeView {
        
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        
        guard let v = nib.instantiate(withOwner: nil, options: nil)[0] as? WelcomeView else {
            return WelcomeView()
        }
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    override func awakeFromNib() {
        
        guard let urlstring = NetworkManager.shared.userAccount.avatar_large,
              let url = URL(string: urlstring) else {
            return
        }
        
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        iconView.layer.cornerRadius = iconView.bounds.size.height * 0.5
        iconView.layer.masksToBounds = true
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.layoutIfNeeded()
        
        constraint.constant = bounds.size.height - 200
        
        UIView.animate(withDuration: 1.0, animations: { 
            self.layoutIfNeeded()
            }) { (_) in
                UIView.animate(withDuration: 1.0, animations: { 
                    self.iconView.alpha = 0
                    }, completion: { (_) in
                        self.removeFromSuperview()
                })
        }
        
    }

}
