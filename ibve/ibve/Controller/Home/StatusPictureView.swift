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
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
}

extension StatusPictureView {
    
    func setupUI() {
        
        backgroundColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        clipsToBounds = true
        
        let count = 3
        
        let iv = UIImageView()
        
        iv.clipsToBounds = true
        
        iv.contentMode = .scaleAspectFill
        
        let rect = CGRect(x: 0, y: StatusPictureViewOutterMargin, width: StatusPictureItemWidth, height: StatusPictureItemWidth)
        
        for i in 0..<count * count {
            
            let row = CGFloat( i / count )
            
            let col = CGFloat( i % count )
            
            let xOffset = row * (StatusPictureItemWidth + StatusPictureViewInnerMargin)
            let yOffset = col * (StatusPictureItemWidth + StatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            addSubview(iv)
            
        }
    }
}
