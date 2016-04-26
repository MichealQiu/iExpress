//
//  ExpressCompany.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/26.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

class ExpressCompany: NSObject {
    
    // 快递名称
    var com = ""
    // 快递代码
    var no = ""
    // 是否常用
    var isUsually: Bool = true
    // 电话号码
    var phoneNum = ""
    // 网址
    var web = ""
    
    static let properties = ["com", "no", "isUsually", "phoneNum", "web"]
    
    init(dict: [String: AnyObject]) {
        super.init()
        for key in ExpressCompany.properties {
            if dict[key] != nil {
                setValue(dict[key], forKey: key)
            }
        }
    }
    
    class func expressCompanys() -> [ExpressCompany] {
        let expressDictArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("express.plist", ofType: nil)!)
        var expressModel = [ExpressCompany]()
        
        for expressDict in expressDictArray! {
            let express = ExpressCompany(dict: expressDict as! [String: AnyObject])
            expressModel.append(express)
        }
        return expressModel
        
    }
    
}
