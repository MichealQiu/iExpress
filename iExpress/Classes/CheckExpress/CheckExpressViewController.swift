//
//  CheckExpressViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import SnapKit

class CheckExpressViewController: UIViewController {
    
    var observer: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let leftView = UIView(frame: CGRectMake(0, 0, 20,44))
        field.leftView = leftView
        field.leftViewMode = .Always
        field.rightView = self.scanButton
        field.rightViewMode = .Always

        field.keyboardType = .NumberPad
        field.placeholder = "请输入快递单号"
        
        return field
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
        
//        添加子控件
        view.addSubview(expressIDTextField)
        view.addSubview(searchButton)
        
//        设置约束
        expressIDTextField.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(150)
            make.right.equalTo(-30)
            make.height.equalTo(44)
        }
        searchButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(expressIDTextField.snp_bottom).offset(40)
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
    
    func searchButtonClick() {
        print(#function)
    }
    

}
