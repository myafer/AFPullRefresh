//
//  ViewController.swift
//  AFPullRefresh
//
//  Created by 口贷网 on 16/4/13.
//  Copyright © 2016年 Afer. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addRefreshHeaderWithHandle { 
            print("biibibibi")
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(4 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.tableView.endRefresh()
            })

        }
       
        

    }
}

