//
//  StatusPictureView.swift
//  ibve
//
//  Created by yesway on 16/8/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class StatusPictureView: UIView {

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    var viewModel: StatusViewModel? {
        didSet {
            calViewSize()
            
            urls = viewModel?.picURLs
        }
    }
    
    private func calViewSize() {
        
        // 处理宽度
        // 1> 单图，根据配图视图的大小，修改 subviews[0] 的宽高
        if viewModel?.picURLs?.count == 1 {
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            
            // a) 获取第0个图像视图
            let v = subviews[0]
            v.frame = CGRect(x: 0,
                             y: StatusPictureViewOutterMargin,
                             width: viewSize.width,
                             height: viewSize.height - StatusPictureViewOutterMargin)
        } else {
            // 2> 多图(无图)，回复 subview[0] 的宽高，保证九宫格布局的完整
            
            let v = subviews[0]
            v.frame = CGRect(x: 0,
                             y: StatusPictureViewOutterMargin,
                             width: StatusPictureItemWidth,
                             height: StatusPictureItemWidth)
        }

        heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    private var urls: [StatusPicture]? {
        didSet {
            
            for v in subviews {
                v.isHidden = true
            }

            var index = 0
            for url in urls ?? [] {
                
                let iv = subviews[index] as! UIImageView
                
 
                
                iv.cz_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                
                // 判断是否是 gif，根据扩展名
                iv.subviews[0].isHidden = (((url.thumbnail_pic ?? "") as NSString).pathExtension.lowercased() != "gif")
                
                // 显示图像
                iv.isHidden = false
                
                index += 1
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
}

extension StatusPictureView {
    
    func setupUI() {
        
        backgroundColor = UIColor.clear
        
        clipsToBounds = true
        
        let count = 3
        
        let rect = CGRect(x: 0, y: StatusPictureViewOutterMargin, width: StatusPictureItemWidth, height: StatusPictureItemWidth)
        
        for i in 0..<count * count {
            let iv = UIImageView()
            
            iv.clipsToBounds = true
            
            iv.contentMode = .scaleAspectFill
            
            let row = CGFloat( i / count )
            
            let col = CGFloat( i % count )
            
            
            let xOffset = col * (StatusPictureItemWidth + StatusPictureViewInnerMargin)
            let yOffset = row * (StatusPictureItemWidth + StatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            //print("\(row) -- \(col) -- \(iv.frame)")
            addSubview(iv)
            
            iv.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
            
            iv.addGestureRecognizer(tap)
            
            iv.tag = i
            
            addGifView(iv: iv)
        }
    }
    
    private func addGifView(iv: UIImageView) {
        
        let gifImageView = UIImageView(image: UIImage(named: "timeline_image_gif"))
        
        iv.addSubview(gifImageView)
        
        // 自动布局
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iv.addConstraint(NSLayoutConstraint(
            item: gifImageView,
            attribute: .right,
            relatedBy: .equal,
            toItem: iv,
            attribute: .right,
            multiplier: 1.0,
            constant: 0))
        iv.addConstraint(NSLayoutConstraint(
            item: gifImageView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: iv,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0))
    }

    
    @objc private func tapImageView(tap: UITapGestureRecognizer) {
        
        guard let iv = tap.view,
            let picURLs = viewModel?.picURLs
            else {
                return
        }
        
        var selectedIndex = iv.tag
        
        // 针对四张图处理
        if picURLs.count == 4 && selectedIndex > 1 {
            selectedIndex -= 1
        }
        
        let urls = (picURLs as NSArray).value(forKey: "largePic") as! [String]
        
        // 处理可见的图像视图数组
        var imageViewList = [UIImageView]()
        
        for iv in subviews as! [UIImageView] {
            
            if !iv.isHidden {
                imageViewList.append(iv)
            }
        }
        
        // 发送通知
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: StatusCellBrowserPhotoNotification),
            object: self,
            userInfo: [StatusCellBrowserPhotoURLsKey: urls,
                       StatusCellBrowserPhotoSelectedIndexKey: selectedIndex,
                       StatusCellBrowserPhotoImageViewsKey: imageViewList])
    }
    
    
}
