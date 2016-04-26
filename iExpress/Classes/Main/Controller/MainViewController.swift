//
//  MainViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()

        addChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: - Method add by myself
    private func addChildViewControllers() {
        
//        获取json文件路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
//        创建NSData
        if let jsonPath = path {
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do {
//                序列化json数据 -> Array
                let dictArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
//                遍历数组，动态创建控制器，设置数据
                for dict in dictArray as! [[String : String]] {
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
            } catch {
                print("错误")
//                从本地创建控制器
                addChildViewController("MyExpressViewController", title: "我的快递", imageName: "tabbar_me")
                addChildViewController("CheckExpressViewController", title: "查找快递", imageName: "tabbar_check")
                addChildViewController("SendExpressViewController", title: "寄快递", imageName: "tabbar_send")
            }
        }
    }
    
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        
//        动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
//        将字符串转换为类
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        
//        设置tabbar对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        vc.title = title
        vc.tabBarItem.title = title
        
//        包装到导航控制器里
        let nav = MyNavigationController(rootViewController: vc)
        nav.navigationBar.barTintColor = UIColor.lightGreenColor()
        nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav.navigationBar.tintColor = UIColor.whiteColor()
        
        addChildViewController(nav)
    }

}
