//
//  UILabel+Category.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/26.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     *  快速创建一个UILabel
     */
    class func createLabel(color: UIColor, fontSize: CGFloat) -> UILabel {
        
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
        
    }
    
}
