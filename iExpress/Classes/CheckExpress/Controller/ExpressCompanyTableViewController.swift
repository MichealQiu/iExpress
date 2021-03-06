//
//  ExpressCompanyTableViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/26.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

// 闭包类型
typealias CompanyReturn = (companyName: String) -> Void

class ExpressCompanyTableViewController: UITableViewController {
    
    // 定义一个变量，将匿名函数当变量使用
    var companyReturn: CompanyReturn?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "选择快递公司"
        
//        注册cell
        tableView.registerClass(ExpressCompanyTableViewCell.self, forCellReuseIdentifier: expressCompanyReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCompanyName(result: CompanyReturn) {
        self.companyReturn = result
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
//        let identifier = "expressCompanyReuseIdentifier"
//        
//        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
//        
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
//        }
//        
////        cell?.textLabel?.text = expressCompanys[indexPath.row].com
//        
//        cell?.textLabel?.numberOfLines = 0
//        cell?.detailTextLabel?.text = expressCompanys[indexPath.row].phoneNum
//        return cell!
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

        if self.companyReturn != nil {
            self.companyReturn!(companyName: expressCompany.com)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    
//    MARK: - 懒加载
    lazy var expressCompanyGroups: [ExpressCompanyGroup] = {
        return ExpressCompanyGroup.expressCompanyGroups()
    }()

}
