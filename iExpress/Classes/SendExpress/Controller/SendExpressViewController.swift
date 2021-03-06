//
//  SendExpressViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/22.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

class SendExpressViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.darkWhiteColor()
//        注册cell
        tableView.registerClass(ExpressCompanyTableViewCell.self, forCellReuseIdentifier: expressCompanyReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    MARK: - TableView的delegate方法
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return expressCompanyGroups.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expressCompanyGroups[section].companys!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let expressCompany = expressCompanyGroups[indexPath.section].companys![indexPath.row]
        
//        获取cell
        let cell = tableView.dequeueReusableCellWithIdentifier(expressCompanyReuseIdentifier, forIndexPath: indexPath) as! ExpressCompanyTableViewCell
        
//        设置数据
        cell.expressCompany = expressCompany
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let expressCompanyGroup = expressCompanyGroups[section]
        return expressCompanyGroup.title
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return (expressCompanyGroups as NSArray).valueForKeyPath("title")! as? [String]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let expressCompany = expressCompanyGroups[indexPath.section].companys![indexPath.row]
        
        let alert = UIAlertController(title: "呼叫\(expressCompany.com)", message: "\(expressCompany.phoneNum)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "呼叫", style: UIAlertActionStyle.Default) { (action) in
            print("---呼叫---")
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(expressCompany.phoneNum)")!)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
//    MARK: - Method add by myself
    
    
//    MARK: - 懒加载
    lazy var expressCompanyGroups: [ExpressCompanyGroup] = {
        return ExpressCompanyGroup.expressCompanyGroups()
    }()
    
}
