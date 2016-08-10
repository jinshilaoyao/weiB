//
//  NewFeatureView.swift
//  ibve
//
//  Created by yesway on 16/7/26.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class NewFeatureView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterButton: UIButton!

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func enterGO(_ sender: UIButton) {
    }
    
    class func newFeatureView() -> NewFeatureView {
        
        let nib = UINib(nibName: "NewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! NewFeatureView
        
        v.frame = UIScreen.main().bounds
        
        return v
    }
    
    override func awakeFromNib() {
        
        let count = 4
        let rect = UIScreen.main().bounds
        
        for i in 0..<count {
            let imageName = "new_feature_\(i + 1)"
            let image = UIImageView(image: UIImage(named: imageName))
            
            image.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(image)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(count - 1) * rect.width, height: rect.height)
        
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        
        scrollView.delegate = self
        
        enterButton.isHidden = true
        
    }
}

extension NewFeatureView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        enterButton.isHidden = true
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
        
        pageControl.currentPage = page
        
        pageControl.isHidden = (page == scrollView.subviews.count)
        
    }
    
}
