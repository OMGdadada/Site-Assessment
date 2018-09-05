
//
//  THTool.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/8/26.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

enum AlertClickType {
    case defualt  // 默认点击确定
    case cannel   // 点击取消
}

class THTool: NSObject {
    
    /// 提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 副标题
    ///   - confirm: 确定
    ///   - cannel: 取消
    ///   - selfVC: viewcontroller
    ///   - completion: 回调
    class func alert(title:String? , 
                     message:String?,
                     confirm:String?,
                     cannel:String?,
                     selfVC:Any,
                     completion:((_ type:AlertClickType) -> Void)?)
    {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: cannel, style: .cancel, handler: {
            action in
            print("点击了取消")
            completion!(.cannel)
            
        }))
        alertController.addAction(UIAlertAction(title: confirm, style: .default,
                                                handler: {
                                                    action in
                                                    print("点击了确定")
                                                    completion!(.defualt)
                                                    
        }))
        (selfVC as! UIViewController).present(alertController, animated: true, completion: nil)
    }
    
    /// 下面弹出提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 副标题
    ///   - items: item集合
    ///   - selfVC: viewcontroller
    ///   - completion: 回调
    class func aheet(title:String? , 
                     message:String?,
                     items:Array<String>,
                     itemView:UITableView,
                     indexPath:IndexPath,
                     selfVC:Any,
                     completion:((_ index:Int) -> Void)?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for item in 0..<items.count {
            alertController.addAction(UIAlertAction(title: items[item], style: .default, handler: {
                action in
                print("点击了\(item)")
                completion!(item)
            }))
        }

        //alertController.addAction(UIAlertAction(title: "取消", style: .cancel,
                                               // handler: nil))
        alertController.popoverPresentationController?.sourceView = (selfVC as! UIViewController).view
        alertController.popoverPresentationController?.sourceRect = (itemView.cellForRow(at: indexPath)?.frame)!
        (selfVC as! UIViewController).present(alertController, animated: true, completion: nil)
    }
}
