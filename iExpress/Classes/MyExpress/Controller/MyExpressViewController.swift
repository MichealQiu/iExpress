//
//  MyExpressViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import MMDrawerController
import SVProgressHUD

class MyExpressViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        initUI()
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
    
    private func initUI() {
        
        view.addSubview(searchTabelView)
        
        searchTabelView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-44)
        }
        
    }
    
//    MARK: - 懒加载
    private lazy var searchController: UISearchController = {
        let controller = UISearchController.init(searchResultsController: nil)
        controller.delegate = self
        controller.searchResultsUpdater = self
        controller.searchBar.placeholder = "搜索"
        return controller
    }()
    
    private lazy var searchTabelView: UITableView = {
        let tabelView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 64))
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.separatorStyle = .None
        tabelView.backgroundColor = UIColor.darkWhiteColor()
        tabelView.tableHeaderView = self.searchController.searchBar
        return tabelView
    }()
    
}

extension MyExpressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "expressCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.None
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
        if indexPath.row % 2 == 0 {
            cell!.backgroundColor = UIColor.smallLightGrayColor()
        }
        cell!.textLabel!.textColor = UIColor.blackColor()
        return cell!
    }
    
}

extension MyExpressViewController: UISearchControllerDelegate {
    
    func presentSearchController(searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = true
        var cancelBtn: UIButton?
        let topView: UIView = searchController.searchBar.subviews[0] 
        for view in topView.subviews {
            if view.isKindOfClass(NSClassFromString("UINavigationButton")!) {
                cancelBtn = view as? UIButton
            }
        }
        if cancelBtn != nil {
            cancelBtn?.setTitle("取消", forState: UIControlState.Normal)
            cancelBtn?.setTitleColor(UIColor.appBlueColor(), forState: UIControlState.Normal)
        }
        
        print("presentSearchController \(searchController.active)");
    }
    
    func willPresentSearchController(searchController: UISearchController) {
        print("willPresentSearchController \(searchController.active)");
    }
    func didPresentSearchController(searchController: UISearchController) {
        print("didPresentSearchController \(searchController.active)");
    }
    func willDismissSearchController(searchController: UISearchController) {
        print("willDismissSearchController \(searchController.active)");
    }
    
}

extension MyExpressViewController: UISearchResultsUpdating {
//    处理搜索逻辑
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        print(#function)
        
        let searchText = searchController.searchBar.text
        print(searchText)
    }
}