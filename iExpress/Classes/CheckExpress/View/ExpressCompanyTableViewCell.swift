//
//  ExpressCompanyTableViewCell.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/26.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import SnapKit

let expressCompanyReuseIdentifier = "expressCompanyReuseIdentifier"

class ExpressCompanyTableViewCell: UITableViewCell {

    var expressCompany: ExpressCompany? {
        didSet {
            pictureView.image = UIImage(named: expressCompany!.no)
            expressCompanyNameLabel.text = expressCompany!.com
            expressPhoneNumLabel.text = expressCompany!.phoneNum
        }
    }
    
    
    /**
     *  自定义一个类需要重写的init方法是 designated
     */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //        初始化UI
        setupUI()
    }
    


//    MARK: - Method add by myself
    
    func setupUI() {
        
//        1.添加子控件
        contentView.addSubview(pictureView)
        contentView.addSubview(expressCompanyNameLabel)
        contentView.addSubview(expressPhoneNumLabel)
        
//        2.布局子控件
        pictureView.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        expressCompanyNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(pictureView.snp_right).offset(15)
            make.top.equalTo(15)
            make.right.equalTo(10)
            make.height.equalTo(20)
        }
        
        expressPhoneNumLabel.snp_makeConstraints { (make) in
            make.left.equalTo(expressCompanyNameLabel.snp_left)
            make.top.equalTo(expressCompanyNameLabel.snp_bottom).offset(10)
            make.right.equalTo(10)
            make.height.equalTo(10)
        }
    }
    
//    MARK: - 懒加载
    
    // 快递图片
    lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // 快递公司名称
    lazy var expressCompanyNameLabel: UILabel = {
        let label = UILabel.createLabel(UIColor.blackColor(), fontSize: 17)
        return label
    }()
    
    lazy var expressPhoneNumLabel: UILabel = {
        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 14)
        return label
    }()

    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
