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
    
//    MARK: - 懒加载
    lazy var expressCompanyGroups: [ExpressCompanyGroup] = {
        return ExpressCompanyGroup.expressCompanyGroups()
    }()
    
}
