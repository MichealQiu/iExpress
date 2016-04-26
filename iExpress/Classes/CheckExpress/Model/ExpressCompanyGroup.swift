//
//  ExpressCompanyGroup.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/26.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

class ExpressCompanyGroup: NSObject {

    // 组名
    var title = ""
    // 公司
    var companys: [ExpressCompany]?
    
    static let properties = ["title", "companys"]

    init(dict: [String: AnyObject]) {
        super.init()
        
        self.title = dict["title"] as! String
        var tmpCompanys = [ExpressCompany]()
        for dict in dict["companys"] as! NSArray {
            let comDict = dict as! [String: AnyObject]
            let company = ExpressCompany(dict: comDict)
            tmpCompanys.append(company)
        }
        self.companys = tmpCompanys
    }
    
    class func expressCompanyGroups() -> [ExpressCompanyGroup] {
        let expressGroupDictArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("express.plist", ofType: nil)!)
        var expressGroupModel = [ExpressCompanyGroup]()
        
        for expressGroupDict in expressGroupDictArray! {
            let expressGroup = ExpressCompanyGroup(dict: expressGroupDict as! [String: AnyObject])
            expressGroupModel.append(expressGroup)
        }
        return expressGroupModel
        
    }


}
