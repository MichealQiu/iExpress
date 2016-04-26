//
//  ExpressResultTableViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/26.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit

class ExpressResultTableViewController: UITableViewController {
    
    var expressResult: ExpressResult?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "当前快递查询"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expressResult?.result?.list?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "expressResultReuseIdentifier"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        }

        cell?.textLabel?.text = expressResult?.result?.list?[indexPath.row].remark
        cell?.textLabel?.numberOfLines = 0
        cell?.detailTextLabel?.text = expressResult?.result?.list?[indexPath.row].datetime
        return cell!
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
