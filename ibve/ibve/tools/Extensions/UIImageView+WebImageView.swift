//
//  UIImageView+WebImageView.swift
//  ibve
//
//  Created by yesway on 16/8/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import SDWebImage

extension UIImageView {

    func cz_setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false) {
    
        guard let urlstring = urlString, url = URL(string: urlstring) else {
            
            image = placeholderImage
            
            return
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { [weak self] (image, _, _, _) in
            
            if isAvatar {
                self?.image = image?.cz_avatarImage(size: self?.bounds.size)
            }
        }
    }
}



