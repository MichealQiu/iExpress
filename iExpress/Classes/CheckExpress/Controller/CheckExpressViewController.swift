//
//  CheckExpressViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import ObjectMapper

class CheckExpressViewController: UIViewController {
    
    var observer: AnyObject!
    
    var expressResult: ExpressResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jhOpenidSupplier = JHOpenidSupplier.shareSupplier()
        jhOpenidSupplier.registerJuheAPIByOpenId("JHf3cf8c139d6836016d9a6b037ddf5905")
        
        initUI()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckExpressViewController.hideKeyboard(_:)))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)

        listenForBackgroundNotification()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }

//    MARK: - 懒加载
//    订单号文本框
    private lazy var expressIDTextField: UITextField = {
        let field = UITextField(frame: CGRect.zero)
        
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGrayColor().CGColor
        field.backgroundColor = UIColor.whiteColor()
        field.layer.cornerRadius = 5
        field.backgroundColor = UIColor.clearColor()
        
        let leftView = UIView(frame: CGRectMake(0, 0, 20,44))
        field.leftView = leftView
        field.leftViewMode = .Always
        field.rightView = self.scanButton
        field.rightViewMode = .Always

        field.keyboardType = .NumberPad
        field.placeholder = "请输入快递单号(*)"
        
        return field
    }()
    
    private lazy var expressCompanyButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clearColor()
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.lightGrayColor().CGColor
        btn.setTitle("请选择快递公司", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(16)
        btn.titleLabel?.textAlignment = .Left
        btn.contentHorizontalAlignment = .Left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(CheckExpressViewController.showExpressCompany), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
//    二维码按钮
    private lazy var scanButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 44, 44)
        
        btn.setImage(UIImage(named: "check_scan"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "scan_highlighted") , forState: UIControlState.Highlighted)
        
        btn.addTarget(self, action: #selector(CheckExpressViewController.scanButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    
//    查询按钮
    private lazy var searchButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orangeColor()
        btn.setTitle("查快递", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.layer.cornerRadius = 5
        
        btn.addTarget(self, action: #selector(CheckExpressViewController.searchButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
//    MARK: - Method add by myself
    
    private func initUI() {
        
        view.backgroundColor = UIColor.darkWhiteColor()
        
//        添加子控件
        view.addSubview(expressIDTextField)
        view.addSubview(expressCompanyButton)
        view.addSubview(searchButton)
        
//        设置约束
        expressIDTextField.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(150)
            make.right.equalTo(-30)
            make.height.equalTo(44)
        }
        
        expressCompanyButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(expressIDTextField.snp_bottom).offset(30)
            make.right.equalTo(-30)
            make.height.equalTo(44)
        }
        
        searchButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(expressCompanyButton.snp_bottom).offset(40)
            make.right.equalTo(-30)
            make.height.equalTo(44)
        }
        
    }
    
    func hideKeyboard(gestureRecognizer: UIGestureRecognizer) {
        expressIDTextField.resignFirstResponder()
    }
    
    func listenForBackgroundNotification() {
        observer = NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidEnterBackgroundNotification, object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] _ in
            if let strongSelf = self {
                if strongSelf.presentedViewController != nil {
                    strongSelf.dismissViewControllerAnimated(false, completion: nil)
                }
                strongSelf.expressIDTextField.resignFirstResponder()
            }
        }
    }

    
    func scanButtonClick() {
        print(#function)
    }
    
    
    func showExpressCompany() {
        print(#function)
        
        let nav = self.navigationController
        let vc = ExpressCompanyTableViewController()
        
        nav?.pushViewController(vc, animated: true)

    }
    
    func searchButtonClick() {
        print(#function)
        
        // 接口地址
        let path = "http://v.juhe.cn/exp/index"
        // api编号
        let api_id = "43"
        // 需要查询的快递公司编号
        let com = "yd"
        // 需要查询的订单号
        let no = "3948130072238"
        // 请求方式
        let method = "GET"
        // 返回数据的格式
        let dtype = "json"
        let params = ["com": com, "no": no, "dtypt": dtype]

        let juhepai = JHAPISDK.shareJHAPISDK()
        
        juhepai.executeWorkWithAPI(path, APIID: api_id, parameters: params, method: method, success: { (responseObject) in
            print("responseObject = \(responseObject)")
        self.expressResult = Mapper<ExpressResult>().map(responseObject!)
            print("expressResult = \(self.expressResult)")
//            let json = JSON(data: responseObject as! NSData)
//            print("json = \(json)")

            let nav = self.navigationController
            let vc = ExpressResultTableViewController()
            vc.expressResult = self.expressResult

            nav?.pushViewController(vc, animated: true)
            
            
        }) { (error) in
                print(error)
        }
    }
    

}
