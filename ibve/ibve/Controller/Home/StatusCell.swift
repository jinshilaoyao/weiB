//
//  StatusCell.swift
//  ibve
//
//  Created by yesway on 16/8/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit


@objc protocol StatusCellDelegate: NSObjectProtocol {
    
    @objc optional func statusCellDidSelectedURLString(cell: StatusCell, urlString: String)
    
}


class StatusCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var menberIconView: UIImageView!
    
    @IBOutlet weak var statusLabel: FFLabel!
    
    @IBOutlet weak var pictureView: StatusPictureView!
    
    @IBOutlet weak var vipIconView: UIImageView!
    
    @IBOutlet weak var retweetedLabel: FFLabel?
    
    weak var delegate: StatusCellDelegate?
    
    var viewModel: StatusViewModel? {
        didSet {
            
            iconView.cz_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            
            nameLabel.text = viewModel?.status.user?.screen_name
            
            timeLabel.text = viewModel?.status.createdDate?.cz_dateDescription
            
            sourceLabel.text = viewModel?.status.source
            
            menberIconView.image = viewModel?.memberIcon
            
            statusLabel.attributedText = viewModel?.statusAttrText
            
            pictureView.viewModel = viewModel
            
            vipIconView.image = viewModel?.vipIcon
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        // cell 优化，要尽量减少图层的数量，相当于就只有一层！
        // 停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        // 使用 `栅格化` 必须注意指定分辨率
        self.layer.rasterizationScale = UIScreen.main().scale
        
        statusLabel.delegate = self
        retweetedLabel?.delegate = self
    }
}

extension StatusCell: FFLabelDelegate {
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        
        if !text.hasPrefix("http://") { return }
        
        delegate?.statusCellDidSelectedURLString?(cell: self, urlString: text)
    }
}
