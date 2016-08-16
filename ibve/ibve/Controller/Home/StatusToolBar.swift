//
//  StatusToolBar.swift
//  ibve
//
//  Created by yesway on 16/8/11.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class StatusToolBar: UIView {

    var viewModel: StatusViewModel? {
        didSet {
            
            retweetedButton.setTitle(viewModel?.retweetedStr, for: [])
            commentButton.setTitle(viewModel?.commentStr, for: [])
            likeButton.setTitle(viewModel?.likeStr, for: [])
            
        }
    }
    
    
    /// 转发
    @IBOutlet weak var retweetedButton: UIButton!
    /// 评论
    @IBOutlet weak var commentButton: UIButton!
    /// 点赞
    @IBOutlet weak var likeButton: UIButton!
}
