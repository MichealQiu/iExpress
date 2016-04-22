//
//  MenuViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import MMDrawerController

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let backgroundView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.maxX * 0.8, UIScreen.mainScreen().bounds.height))
        backgroundView.image = UIImage(named: "bottleNightBkg")
        view.addSubview(backgroundView)

        setTableView()
    }
    
    func setTableView(){
        
        
        tableView = UITableView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height / 3.0, UIScreen.mainScreen().bounds.maxX * 0.8, view.frame.height), style: UITableViewStyle.Plain)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
        
        //设置headView
        tableView.separatorStyle = .None
//        tableView.tableHeaderView = headImageView
        //去掉下部空白格
        self.tableView.tableFooterView = UIView()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil {
            cell=UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.row == 0{
            cell!.imageView!.image = UIImage(named: "tabbar_me_highlighted")
            cell!.textLabel?.text = "我的主页"
        }
        else{
            cell!.imageView!.image = UIImage(named: "navigationbar_setting_highlighted")
            cell!.textLabel?.text = "设置"
        }
        cell!.backgroundColor = UIColor.clearColor()
        cell!.textLabel!.textColor = UIColor.whiteColor()
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        switch (indexPath.row){
//        case 0:
//            let centerViewController = MainViewController()
//            let centerNavigationController = UINavigationController(rootViewController: centerViewController)
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            appDelegate.drawerController.centerViewController = centerNavigationController
//            appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
//        default:
//            
//            let otherViewController = MainViewController()
//            let otherNavigationController = UINavigationController(rootViewController: otherViewController)
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            appDelegate.drawerController.centerViewController = otherNavigationController
//            appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
//        }
        
    }
    
}