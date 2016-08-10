//
//  StatusViewModel.swift
//  ibve
//
//  Created by yesway on 16/8/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation

class StatusViewModel {
    /// 微博模型
    var status: Status
    
    /// 会员图标 - 存储型属性(用内存换 CPU)
    var memberIcon: UIImage?
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var vipIcon: UIImage?
    /// 转发文字
    var retweetedStr: String?
    /// 评论文字
    var commentStr: String?
    /// 点赞文字
    var likeStr: String?
    
    /// 配图视图大小
    var pictureViewSize = CGSize()
    
    /// 如果是被转发的微博，原创微博一定没有图
    var picURLs: [StatusPicture]? {
        // 如果有被转发的微博，返回被转发微博的配图
        // 如果没有被转发的微博，返回原创微博的配图
        // 如果都没有，返回 nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    /// 微博正文的属性文本
    var statusAttrText: AttributedString?
    /// 转发文字的属性文本
    var retweetedAttrText: AttributedString?
    
    /// 行高
    var rowHeight: CGFloat = 0

    
    init(model: Status) {
        self.status = model
        
        // 直接计算出会员图标/会员等级 0-6
        if model.user?.mbrank > 0 && model.user?.mbrank < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            
            memberIcon = UIImage(named: imageName)
        }
        
        // 认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
        pictureViewSize = calcpictureViewSize(count: picURLs?.count)
        
        // --- 设置微博文本 ---
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        // 微博正文的属性文本
        statusAttrText = CZEmoticonManager.shared.emoticonString(string: model.text ?? "", font: originalFont)
        
        // 设置被转发微博的属性文本
        let rText = "@" + (status.retweeted_status?.user?.screen_name ?? "")
            + ":"
            + (status.retweeted_status?.text ?? "")
        retweetedAttrText = CZEmoticonManager.shared.emoticonString(string: rText, font: retweetedFont)
        
        updateRowHeight()

    }
    
    var description: String {
        return status.description
    }
    
    private func updateRowHeight() {
        
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolbarheight: CGFloat = 35
        
        var height: CGFloat = 0
        
        let viewSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
    }
    
    private func calcpictureViewSize(count: Int?) -> CGSize {
        
        if count == 0 || count == nil { return CGSize() }

        let row = (count! - 1)/3 + 1
        
        var height = StatusPictureViewOutterMargin
        height += CGFloat(row) * StatusPictureItemWidth
        height += CGFloat(row - 1) * StatusPictureViewInnerMargin
        
        return CGSize(width: StatusPictureViewWidth, height: height)
        
    }
    
    private func countString(count: Int, defaultStr: String) -> String {
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万", Double(count) / 10000)
    }
}













