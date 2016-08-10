//
//  StatusPicture.swift
//  ibve
//
//  Created by yesway on 16/8/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class StatusPicture: NSObject {
    
    /// 缩略图地址 - 新浪返回的缩略图令人发指
    var thumbnail_pic: String? {
        didSet {
            // print(thumbnail_pic)
            // 设置大尺寸图片
            largePic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/large/")
            
            // 更改缩略图地址
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }

    /// 大尺寸图片
    var largePic: String?
    
    override var description: String {
        return yy_modelDescription()
    }

    
}
