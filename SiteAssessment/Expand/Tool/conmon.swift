//
//  conmon.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/8/28.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import Foundation

let Screen_W = UIScreen.main.bounds.width
let Screen_H = UIScreen.main.bounds.height
let radio_N:UIImage = UIImage(named: "radio_N")!
let radio_Y:UIImage = UIImage(named: "radio_Y")!
let ico_expand:UIImage = UIImage(named: "icon_mr")!
let ico_expand1:UIImage = UIImage(named: "icon_xl")!
let Kappdelegate = UIApplication.shared.delegate as! AppDelegate

var  projectid:String? = nil
var  projectid_id:String? = nil
var  iswifi:Bool = false

//保存数据
func savePlistData(project:String ,dic:NSDictionary) {
    
    //获取路径
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let filePath = path.appendingFormat("/\(project).plist")
    if FileManager.default.fileExists(atPath: filePath) == false {
        dic.write(toFile: filePath, atomically: true)
    }else{
        dic.write(toFile: filePath, atomically: true)
    }
    print(filePath)
    print("保存成功")
}

//删除数据
func deletePlistData(project:String) -> Bool {
    
    //获取路径
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let filePath = path.appendingFormat("/\(project).plist")
    if !FileManager.default.fileExists(atPath: filePath) {
        let tDic = NSMutableDictionary(contentsOfFile: filePath) //根
        tDic?.removeAllObjects()
        tDic?.write(toFile: filePath, atomically: true)
        return true
    }else{
        let tDic = NSMutableDictionary(contentsOfFile: filePath) //根
        tDic?.removeAllObjects()
        tDic!.write(toFile: filePath, atomically: true)
        return false
    }
}

