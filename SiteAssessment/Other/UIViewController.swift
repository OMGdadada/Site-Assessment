//
//  UIViewController.swift
//  Site Assessment
//
//  Created by OMGdadada on 2018/7/5.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

extension UIViewController{
    
    
    func SetTableView() {
        
        
        let tableView:UITableView = UITableView(frame:UIScreen.main.bounds, style:UITableViewStyle.plain)
        
        // 表单添加到view上
        self.view.addSubview(tableView)
       
    }
    
}
