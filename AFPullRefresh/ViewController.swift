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
        }
    }
}

