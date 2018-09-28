//
//  UploadProject.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/27.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

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
    func UploadProjectdata(_ Project_Id:String , model:HistoyDto){
        _ = makePostCall(Project_Id ,update: model.Datauploaded)
    }
    
    func getSearchResults(completion:@escaping ((_ str:String) -> Void)) {
        if var urlComponents = URLComponents(string: "https://creator.zoho.com/api/json/crm/view/Site_Assessment_Report") {
            urlComponents.query = "authtoken=6be21a290c7115b73ff7df767a84ac34&zc_ownername=mohanwang&scope=creatorapi&raw=true"
            
            guard let url = urlComponents.url else { return }
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) {
                (data, response, error) in
                guard error == nil else {
                    print("error calling POST on /todos/1")
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
                completion(string as String)
                print(string)
            }
            
            task.resume()
        }
    }
    
    func UploadProjectToGoogleDrive(_ Project_Id:String , model:HistoyDto?){
        var ProjectInformation :NSMutableDictionary
        ProjectInformation = NSMutableDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(model?.projectID ?? "").plist")!
        if(ProjectInformation["Datauploaded"] as! Bool == false){
            makePostCall(Project_Id , update: (model?.Datauploaded)!)
        }else if(ProjectInformation["uploaded"] as! Bool == false){
            
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
                                                    ImgInformation["ststus"] = 1
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
                                                        ImgInformation["ststus"] = 1
                                                        let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
                                                        self.saveFile(dic: ProjectInformation, filepath: filePath ,projectID: Project_Id)
                                                self.scheduleNotification(itemID: Project_Id )
                                                    }
                                                }
                                            }
                                        }
                                    }else{
                                        ProjectImg_schedule += 1
                                        ImgInformation["ststus"] = 1
                                        //ProjectListViewController.UpdateTableView()
                                        if(ProjectImg_Total == ProjectImg_schedule){
                                            print("项目上传完成")
                                            ProjectInformation["uploaded"] = true
                                            let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id).plist"
                                            
                                            self.saveFile(dic: ProjectInformation, filepath: filePath ,projectID: Project_Id)
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
    
    
    func makePostCall(_ Project_Id:String ,update:Bool) {
        guard let url = URL(string: "https://creator.zoho.com/api/mohanwang/json/crm/form/Site_Assessment/record/add?authtoken=6be21a290c7115b73ff7df767a84ac34&scope=creatorapi") else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        /* ------- Change Here ------- */
        
        var ProjectInformation :NSMutableDictionary
        ProjectInformation = NSMutableDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(Project_Id).plist")!
        if(update == true){
            return
        }
        print(NSHomeDirectory()+"/Documents/\(Project_Id).plist")
        let SENDDATA: [String: String] = addAnswer(Project_Id) as! [String : String]
        let sendData: [String: String] = SENDDATA
        print(sendData)
        /* --------------------------- */
        
        let urlParams = sendData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        //        ({ (key, value) -> String in
        //            
        //        })
        
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
        saveFile(dic: ProjectInformation, filepath: filePath ,projectID: Project_Id)
    }
    
    fileprivate func saveFile(dic:NSMutableDictionary , filepath:String , projectID:String) {
        deletePlistData(project: projectID)
        
        savePlistData(project: projectID, dic: dic)
        
//        NSDictionary(dictionary: dic).write(toFile: filepath, atomically: true)
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
    
    fileprivate func addAnswer(_ Project_Id:String) -> [String : Any?] {
        
        var answer:[String:String] = [:]
        answer["sa_prj"] = Project_Id
        var ProjectInformation :NSDictionary
        ProjectInformation = NSDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(Project_Id).plist")!
        var dataSoure:NSMutableArray = NSMutableArray()
        dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: ProjectInformation["questionList"])
        for i  in 0..<dataSoure.count {
            let  model:SiteRootModel = dataSoure[i] as! SiteRootModel
            for j in 0..<model.questionList.count {
                let question:QuestionModel = model.questionList[j]
                switch i {
                case 0:
                    switch j {
                    case 0 :
                        answer["sa_shingleMaterial"] = question.other! == "" ?"No":question.other!
                        break
                    case 1 :
                        answer["sa_missingShingles"] = question.other! == "" ?"No":question.other!
                        break
                    case 2 :
                        answer["sa_missingRidgeCap"] = question.other! == "" ?"No":question.other!
                        break
                    case 3 :
                        answer["sa_curvedPlywood"] = question.other! == "" ?"No":question.other!
                        break
                    case 4 :
                        answer["sa_overallRoofCondition"] = question.other! == "" ?"No":question.other!
                        break
                    case 5 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_full3DSiteImaging"] = "Yes"  
                        }else{ 
                            answer["sa_full3DSiteImaging"] = "No"
                        }
                        break
                    case 6 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_shinglePhotoCloseUp"] = "Yes"  
                        }else{ 
                            answer["sa_shinglePhotoCloseUp"] = "No"
                        }
                        break
                    case 7 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_shinglePhotoTopView"] = "Yes"  
                        }else{ 
                            answer["sa_shinglePhotoTopView"] = "No"
                        }
                        break
                    case 8 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_shinglePhotoBackView"] = "Yes"  
                        }else{ 
                            answer["sa_shinglePhotoBackView"] = "No"
                        }
                        break
                    default: break
                    }
                    break
                case 1:
                    switch j {
                    case 0:
                        answer["sa_meterLocation"] = question.other! == "" ?"No":question.other!
                        break
                    case 1:
                        answer["sa_connectionType"] = question.other! == "" ?"No":question.other!
                        break
                    case 2:
                        answer["sa_exteriorWallMaterial"] = question.other! == "" ?"No":question.other!
                        break
                    case 3:
                        answer["sa_meterHeight"] = question.other! == "" ?"No":question.other!
                        break
                    case 4:
                        answer["sa_gasMeterLocation"] = question.other! == "" ?"No":question.other!
                        break
                    case 5:
                        answer["sa_meterObstruction"] = question.other! == "" ?"No":question.other!
                        break
                    case 6:
                        answer["sa_obstructionType1"] = question.other! == "" ?"No":question.other!
                        break
                    case 7:
                        answer["sa_obstructionDistance"] = question.other! == "" ?"No":question.other!
                        break
                    case 8:
                        answer["sa_trenchingRequired"] = question.other! == "" ?"No":question.other!
                        break
                    case 9:
                        answer["sa_trenchingOverDriveway"] = question.other! == "" ?"No":question.other!
                        break
                    case 10:
                        answer["sa_trenchingMaterial"] = question.other! == "" ?"No":question.other!
                        break
                    case 11:
                        answer["sa_trenchingObstructions"] = question.other! == "" ?"No":question.other!
                        break
                    case 12:
                        answer["sa_trenchingObstructionType"] = question.other! == "" ?"No":question.other!
                        break
                    case 13:
                        answer["sa_trenchingDistance"] = question.other! == "" ?"No":question.other!
                        break
                    case 14 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_meterPhotoCloseUp"] = "Yes"  
                        }else{ 
                            answer["sa_meterPhotoCloseUp"] = "No"
                        }
                        break
                    case 15 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_meterPhotoWideAngle"] = "Yes"  
                        }else{ 
                            answer["sa_meterPhotoWideAngle"] = "No"
                        }
                        break
                    case 16 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_meterHeightMeasurementPhoto"] = "Yes"  
                        }else{ 
                            answer["sa_meterHeightMeasurementPhoto"] = "No"
                        }
                        break
                    case 17 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_meterSurroundingAreaPhoto"] = "Yes"  
                        }else{ 
                            answer["sa_meterSurroundingAreaPhoto"] = "No"
                        }
                        break
                    case 18 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_meterObstructionPhoto"] = "Yes"  
                        }else{ 
                            answer["sa_meterObstructionPhoto"] = "No"
                        }
                        break
                    case 19 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_teckCableRouteReferencePhoto"] = "Yes"  
                        }else{ 
                            answer["sa_teckCableRouteReferencePhoto"] = "No"
                        }
                        break
                    case 20 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_trenchingRouteAerialPhoto"] = "Yes"  
                        }else{ 
                            answer["sa_trenchingRouteAerialPhoto"] = "No"
                        }
                        break
                    case 21 :
                        if question.other == "Photo Uploaded" {
                            answer["sa_trenchingRouteGroundPhoto"] = "Yes"  
                        }else{ 
                            answer["sa_trenchingRouteGroundPhoto"] = "No"
                        }
                        break
                    default: break  
                    }
                    break
                case 2 : 
                    switch j {
                    case 0:
                        answer["sa_breakerPanelAmp"] = question.other! == "" ?"No":question.other!
                        break
                    case 1:
                        answer["sa_breakerPanelLocation"] = question.other! == "" ?"No":question.other!
                        break
                    case 2:
                        answer["sa_availableBreakerSlot"] = question.other! == "" ?"No":question.other!
                        break
                    case 3:
                        answer["sa_breakerPanelObstruction"] = question.other! == "" ?"No":question.other!
                        break
                    case 4:
                        answer["sa_obstructionType"] = question.other! == "" ?"No":question.other!
                        break
                    case 5:
                        // answer["sa_mainBreakerPanelDiagram"] = question.other!
                        break
                    case 6:
                        if question.other == "Photo Uploaded" {
                            answer["sa_mainBreakerPanelPhotoCloseUp"] = "Yes"  
                        }else{ 
                            answer["sa_mainBreakerPanelPhotoCloseUp"] = "No"
                        }
                        break
                    case 7:
                        if question.other == "Photo Uploaded" {
                            answer["sa_mainBreakerPanelPhotoWideAngle"] = "Yes"  
                        }else{ 
                            answer["sa_mainBreakerPanelPhotoWideAngle"] = "No"
                        }
                        break
                    case 8:
                        if question.other == "Photo Uploaded" {
                            answer["sa_mainBreakerPanelPhotoInterior"] = "Yes"  
                        }else{ 
                            answer["sa_mainBreakerPanelPhotoInterior"] = "No"
                        }
                        break
                    case 9:
                        if question.other == "Photo Uploaded" {
                            answer["sa_mainBreakerPanelPhoto360Degree"] = "Yes"  
                        }else{ 
                            answer["sa_mainBreakerPanelPhoto360Degree"] = "No"
                        }
                        break
                    default: break  
                    }
                    break
                case 3 : 
                    switch j {
                    case 0:
                        answer["sa_locationElectricalMeter"] = question.other! == "" ?"No":question.other!
                        break
                    case 1:
                        answer["sa_locationGasMeter"] = question.other! == "" ?"No":question.other!
                        break
                    case 2:
                        answer["sa_locationObstruction"] = question.other! == "" ?"No":question.other!
                        break
                    case 3:
                        answer["sa_locationMainBreakerPanel"] = question.other! == "" ?"No":question.other!
                        break
                    case 4:
                        answer["sa_distanceElectricalMeterToFrontCornerOfHouse"] = question.other! == "" ?"No":question.other!
                        break
                    case 5:
                        answer["sa_distanceElectricalMeterToGasMeter"] = question.other! == "" ?"No":question.other!
                        break
                    case 6:
                        answer["sa_distanceElectricalMeterToYardDoor"] = question.other! == "" ?"No":question.other!
                        break
                    case 7:
                        answer["sa_distanceElectricalMeterToObstruction"] = question.other! == "" ?"No":question.other!
                        break
                    default: break  
                    }
                    break  
                case 4 : 
                    switch j {
                    case 0:
                        answer["sa_roofSheathing"] = question.other! == "" ?"No":question.other!
                        break
                    case 1:
                        answer["sa_signsOfMold"] = question.other! == "" ?"No":question.other!
                        break
                    case 2:
                        answer["sa_signsOfWaterLeakage"] = question.other! == "" ?"No":question.other!
                        break
                    case 3:
                        answer["sa_waterLeakageType"] = question.other! == "" ?"No":question.other!
                        break
                    case 4:
                        answer["sa_signsOfDamage"] = question.other! == "" ?"No":question.other!
                        break
                    case 5:
                        answer["sa_typeOfDamage"] = question.other! == "" ?"No":question.other!
                        break
                    case 6:
                        answer["sa_trussSpacing"] = question.other! == "" ?"No":question.other!
                        break
                    case 7:
                        answer["sa_trussMemberSize"] = question.other! == "" ?"No":question.other!
                        break
                    case 8:
                        if question.other == "Photo Uploaded" {
                            answer["sa_trussType"] = "Yes"  
                        }else{ 
                            answer["sa_trussType"] = question.other! == "" ?"No":question.other!
                        }
                        break
                        
                    default: break  
                    }
                    break 
                case 5 :
                    answer["sa_notes"] = question.other! == "" ?"No":question.other!
                    break
                default: break
                }
                
            }
        }
        return answer
    }
}

