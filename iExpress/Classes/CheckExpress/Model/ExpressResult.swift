//
//  expressResult.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/25.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import ObjectMapper


class BaseData: NSObject, Mappable {
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        
    }
}

class ExpressResult: BaseData {

    // 返回标识码
    var resultcode: String = ""
    // 状态原因
    var reason: String = ""
    // 结果
    var result: Result?
    
    override func mapping(map: Map) {
        resultcode <- map["resultcode"]
        reason <- map["reason"]
        result <- map["result"]
    }
}

class Result: BaseData {
    
    // 快递公司
    var company: String?
    // 快递公司编号
    var com: String?
    // 快递单号
    var no: String?
    //
    var list: [List]?
    // 0或1
    // 0表示此单号信息还有更新的可能；
    // 1表示此单号信息不会再更新（签收、退回等最终状态），您可将单号信息存入数据库，不必再次往聚合发送更新请求。
    var status: String?
    
    override func mapping(map: Map) {
        company <- map["company"]
        com <- map["com"]
        no <- map["no"]
        list <- map["list"]
        status <- map["status"]
    }
}

class List: BaseData {
    // 时间
    var datetime: String?
    // 描述
    var remark: String?
    // 区域，视快递公司情况，不保证一定有信息
    var listZone: String?
    

    override func mapping(map: Map) {
        datetime <- map["datetime"]
        remark <- map["remark"]
        listZone <- map["zone"]
    }
}
