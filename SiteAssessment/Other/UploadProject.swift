//
//  UploadProject.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/27.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import Foundation
import GoogleSignIn

class UploadProject{
    let user :GIDGoogleUser
    fileprivate let service = GTLRDriveService()
    private var drive: UploadGoogleDrive?
    private init(){
        user = ProductListViewController.userList
        service.authorizer = user.authentication.fetcherAuthorizer()
        drive = UploadGoogleDrive(service)
    }
    static let Uploadshared = UploadProject()
    func UploadProjectdata(_ Project_Id:String){
        _ = makePostCall(Project_Id)
    }
    func UploadProjectToGoogleDrive(_ Project_Id:String){
        var ProjectInformation :NSMutableDictionary
        ProjectInformation = NSMutableDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(Project_Id).plist")!
        if(ProjectInformation["Datauploaded"] as? Bool == false){
            _ = makePostCall(Project_Id)
        }else if(ProjectInformation["uploaded"] as? Bool == false){
            
            var ImgList:[String: Any] = (ProjectInformation["Img"] as? Dictionary)!
            var ProjectImg_Total = 0
            var ProjectImg_schedule = 0
            for (offset: _ ,element: (key: key,value: _)) in ImgList.enumerated(){
                let ImgInformationList = ImgList[key] as! NSMutableArray
                ProjectImg_Total += ImgInformationList.count
            }
            print("ProjectImg_Total:\(ProjectImg_Total)")
            let porjectinformation = ProjectListViewController.ProjectInformationList["\(Project_Id)"] as! ProjectInformation
            porjectinformation.setValue(ProjectImg_Total, forKey: "Total")
            
            drive?.uploadParentFolder("\(Project_Id)", onCompleted: { (folderID, error) in
                if let err = error {
                    print("Error: \(err.localizedDescription)")
                }
                if let fid = folderID {
                    print("Upload file ID: \(fid)")
                    var ImgList:[String: Any] = (ProjectInformation["Img"] as? Dictionary)!
                    for (offset: _ ,element: (key: key,value: _)) in ImgList.enumerated(){
                        //print("\(key)===\(value)")
                        
                        self.drive?.uploadFile("\(Project_Id)/\(key)", onCompleted: { (fileID, error) in
                            if let err = error {
                                print("Error: \(err.localizedDescription)")
                            }
                            if let Subfolder = fileID {
                                print("Upload Subfolder ID: \(Subfolder)")
                                print("建立子文件夹完成")
                                let ImgInformationList = ImgList[key] as! NSMutableArray
                                for i in 0...ImgInformationList.count{
                                    if(i == ImgInformationList.count){
                                        break
                                    }
                                    var ImgInformation = ImgInformationList[i] as! Dictionary<String,Any>
                                    if(ImgInformation["uploaded"] as? Bool == false){
                                        if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
                                            
                                            let ImgName = ImgInformation["ImgName"] as? String
                                            print("上传图片\(ImgName!)")
                                            let testFilePath = documentsDir.appendingPathComponent("\(Project_Id)/\(ImgName!).jpg").path
                                            print(testFilePath)
                                            self.drive?.uploadIntoFolder(Subfolder, filePath: testFilePath, MIMEType: "image/jpeg") { (fileID, error) in
                                                if let err = error {
                                                    print("Error: \(err.localizedDescription)")
                                                }
                                                if let fid = fileID {
                                                    print("Upload file ID: \(fid)")
                                                    print("上传文件完成")
                                                    ImgInformation["uploaded"] = true
                                                    ImgInformationList[i] = ImgInformation
                                                    ImgList[key] = ImgInformationList
                                                    ProjectInformation["Img"] = ImgList
                                                    
                                                    let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
                                                    NSDictionary(dictionary: ProjectInformation).write(toFile: filePath, atomically: true)
                                                    
                                                    print(filePath)
                                                    ProjectImg_schedule += 1
                                                    porjectinformation.setValue(ProjectImg_schedule, forKey: "schedule")
                                                    if(ProjectImg_Total == ProjectImg_schedule){
                                                        print("项目上传完成")
                                                        ProjectInformation["uploaded"] = true
                                                        let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
                                                        NSDictionary(dictionary: ProjectInformation).write(toFile: filePath, atomically: true)
                                                        self.scheduleNotification(itemID: Project_Id )
                                                    }
                                                }
                                            }
                                        }
                                    }else{
                                        ProjectImg_schedule += 1
                                        
                                        //ProjectListViewController.UpdateTableView()
                                        if(ProjectImg_Total == ProjectImg_schedule){
                                            print("项目上传完成")
                                            ProjectInformation["uploaded"] = true
                                            let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
                                            NSDictionary(dictionary: ProjectInformation).write(toFile: filePath, atomically: true)
                                            self.scheduleNotification(itemID: Project_Id )
                                        }
                                        porjectinformation.setValue(ProjectImg_schedule, forKey: "schedule")
                                    }
                                }
                            }
                        })
                        
                    }
                }
            })
            
            
            return
        }
        
        
        
        /*
        
        var RoofShinglePhotoCheckList = ImgList["RoofShinglePhotoCheckList"] as! NSMutableArray
        for i in 0...RoofShinglePhotoCheckList.count{
            if(i == RoofShinglePhotoCheckList.count){
                break
            }
            var ImgInformation = RoofShinglePhotoCheckList[i] as! Dictionary<String,Any>
            if(ImgInformation["uploaded"] as? Bool == false){
                if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
                    
                    let ImgName = ImgInformation["ImgName"] as? String
                    print("上传图片\(ImgName!)")
                    let testFilePath = documentsDir.appendingPathComponent("\(Project_Id)/\(ImgName!).jpg").path
                    print(testFilePath)
                    drive?.uploadFile("\(Project_Id)/RoofShinglePhotoCheckList", filePath: testFilePath, MIMEType: "image/jpeg") { (fileID, error) in
                        if let err = error {
                            print("Error: \(err.localizedDescription)")
                        }
                        if let fid = fileID {
                            print("Upload file ID: \(fid)")
                            print("上传文件完成")
                            ImgInformation["uploaded"] = true
                            RoofShinglePhotoCheckList[i] = ImgInformation
                            ImgList["RoofShinglePhotoCheckList"] = RoofShinglePhotoCheckList
                            ProjectInformation["Img"] = ImgList
                            
                            let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
                            NSDictionary(dictionary: ProjectInformation).write(toFile: filePath, atomically: true)
                            print(filePath)
                        }
                    }
                }
            }
        }
        */
    }
    
    
    func makePostCall(_ Project_Id:String) {
        guard let url = URL(string: "https://creator.zoho.com/api/mohanwang/json/crm/form/Site_Assessment/record/add?authtoken=6be21a290c7115b73ff7df767a84ac34&scope=creatorapi") else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        /* ------- Change Here ------- */
        
        var ProjectInformation :NSMutableDictionary
        ProjectInformation = NSMutableDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(Project_Id).plist")!
        if(ProjectInformation["Datauploaded"] as? Bool == true){
            return
        }
        print(NSHomeDirectory()+"/Documents/\(Project_Id).plist")
        let SENDDATA: [String: Any] = (ProjectInformation["Answer"] as? Dictionary)!
        let sendData: [String: Any] = SENDDATA
        print(sendData)
        /* --------------------------- */
        
        let urlParams = sendData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        
        urlRequest.httpBody = urlParams.data(using: .utf8)
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            guard let string = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue) else {
                print("Error: data is wrong")
                return
            }
            print("responseData = \(string)")
            
        }
        task.resume()
        ProjectInformation["Datauploaded"] = true
        let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
        NSDictionary(dictionary: ProjectInformation).write(toFile: filePath, atomically: true)
    }
    
    
    func scheduleNotification(itemID:String){
        //如果已存在该通知消息，则先取消
        cancelNotification(itemID: itemID)
        
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        //推送时间（设置为30秒以后）
        localNotification.fireDate = Date(timeIntervalSinceNow: 1)
        //时区
        localNotification.timeZone = NSTimeZone.default
        //推送内容
        localNotification.alertBody = "Project \(itemID) 上传成功"
        //声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //额外信息
        localNotification.userInfo = ["ItemID":itemID]
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    //取消通知消息
    func cancelNotification(itemID:String){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(itemID: itemID)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.shared.cancelLocalNotification(existingNotification!)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
    func notificationForThisItem(itemID:String)-> UILocalNotification? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:String]
            let number = info["ItemID"]
            if number != nil && number == itemID {
                return notification as UILocalNotification
            }
        }
        return nil
    }
    
    
}

