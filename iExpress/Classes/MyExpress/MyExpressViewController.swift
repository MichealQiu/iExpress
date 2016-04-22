//
//  MyExpressViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import MMDrawerController

class MyExpressViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    MARK: - Method add by myself
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_setting", target: self, action: #selector(MyExpressViewController.leftItemClick))
    }
    
    func leftItemClick() {
        
        print(#function)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
}
