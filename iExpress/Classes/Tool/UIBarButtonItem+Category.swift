//
//  UIBarButtonItem+Category.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
//    如果在func前加上class，就相当于OC中的+
    class func creatBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName: String, target: AnyObject?, action: String?) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        if action != nil {
//            如果是自己封装一个按钮，最好传入字符串，再自己包装成Selector
            btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        }
        btn.sizeToFit()
        self.init(customView: btn)
    }
    
}
