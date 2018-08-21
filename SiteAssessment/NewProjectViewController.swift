//
//  NewProjectViewController.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/26.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import Alamofire

class NewProjectViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let manager = NetworkReachabilityManager()
    var NetWork = "不可用的网络(未连接)"
    var Project_Id:String!
    
    var textl1 = CGFloat()
    var textl2 = CGFloat()
    var textl3 = CGFloat()
    var textl4 = CGFloat()
    var textl5 = CGFloat()
    var textl6 = CGFloat()
    var textl7 = CGFloat()
    var textl8 = CGFloat()
    var textl9 = CGFloat()
    var textl10 = CGFloat()
    var textl11 = CGFloat()
    var textl12 = CGFloat()
    var textl13 = CGFloat()
    var textl14 = CGFloat()
    var textl15 = CGFloat()
    var textl16 = CGFloat()
    var textl17 = CGFloat()
    var textl18 = CGFloat()
    var textl19 = CGFloat()
    var textl20 = CGFloat()
    var textl21 = CGFloat()
    var textl22 = CGFloat()
    var textl23 = CGFloat()
    var textl24 = CGFloat()
    var textl25 = CGFloat()
    var textl26 = CGFloat()
    var textl27 = CGFloat()
    var textl28 = CGFloat()
    var textl29 = CGFloat()
    var textl30 = CGFloat()
    var textl31 = CGFloat()
    var textl32 = CGFloat()
    var textl33 = CGFloat()
    var textl34 = CGFloat()
    var textl35 = CGFloat()
    var textl36 = CGFloat()
    var textl37 = CGFloat()
    var textl38 = CGFloat()
    var textl39 = CGFloat()
    var textl40 = CGFloat()
    var textl41 = CGFloat()
    var textl42 = CGFloat()
    var textl43 = CGFloat()
    var textl44 = CGFloat()
    var textl45 = CGFloat()
    var textl46 = CGFloat()
    var textl47 = CGFloat()
    var textl48 = CGFloat()
    var textl49 = CGFloat()
    var textl50 = CGFloat()
    var textl51 = CGFloat()
    var textl52 = CGFloat()
    var textl53 = CGFloat()
    var textl54 = CGFloat()
    var textl55 = CGFloat()
    var textl56 = CGFloat()
    var textl57 = CGFloat()
    var textl58 = CGFloat()
    var textl59 = CGFloat()
    
    //var celltitle = Dictionary<String, Any>()
    var Arr = NSMutableArray()
    let cellIDstr : String = "cell"
    var selectedCellIndexPaths:[NSIndexPath] = []
    static var selected:[String] = NSArray() as! [String]
    //var TABLEVIEW :UITableView = UITableView()
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    var textlArr : [CGFloat] = NSArray() as! [CGFloat]
    let ico_expand:UIImage = UIImage(named: "icon_mr")!
    let ico_expand1:UIImage = UIImage(named: "icon_xl")!
    
    var imagePicker:UIImagePickerController = UIImagePickerController()
    
    
    static var TLRBText : [String] = Array<Any>(repeating: "NULL", count: 4) as! [String]
    var RoofShinglePhotoCheckList:NSMutableArray = []
    var MeterPhotoCheckList:NSMutableArray = []
    var MainBreakerPhotoCheckList:NSMutableArray = []
    var TrussType:NSMutableArray = []
    var ImgView:NSMutableDictionary = [:]
    
    var Pickerimage_Nums = 0
    var Pickerimage6_Nums = 0
    var Pickerimage7_Nums = 0
    var Pickerimage8_Nums = 0
    var Pickerimage9_Nums = 0
    var Pickerimage24_Nums = 0
    var Pickerimage25_Nums = 0
    var Pickerimage26_Nums = 0
    var Pickerimage27_Nums = 0
    var Pickerimage28_Nums = 0
    var Pickerimage29_Nums = 0
    var Pickerimage30_Nums = 0
    var Pickerimage31_Nums = 0
    var Pickerimage38_Nums = 0
    var Pickerimage39_Nums = 0
    var Pickerimage40_Nums = 0
    var Pickerimage41_Nums = 0
    var Pickerimage58_Nums = 0
    var Pickerimage6 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage7 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage8 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage9 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage24 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage25 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage26 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage27 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage28 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage29 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage30 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage31 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage38 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage39 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage40 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage41 : [UIImageView] = NSMutableArray() as! [UIImageView]
    var Pickerimage58 : [UIImageView] = NSMutableArray() as! [UIImageView]
    
    
    var imageManager:PHCachingImageManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Project_Id)
        let plistpath = Bundle.main.path(forResource: "QuestionsList", ofType: "plist")
        Arr = NSMutableArray(contentsOfFile: plistpath!)!
        
        textlArr = [textl1,textl2,textl3,textl4,textl5,textl6,textl7,textl8,textl9,textl10,textl11,textl12,textl13,textl14,textl15,textl16,textl17,textl18,textl19,textl20,textl21,textl22,textl23,textl24,textl25,textl26,textl27,textl28,textl29,textl30,textl31,textl32,textl33,textl34,textl35,textl36,textl37,textl38,textl39,textl40,textl41,textl42,textl43,textl44,textl45,textl46,textl47,textl48,textl49,textl50,textl51,textl52,textl53,textl54,textl55,textl56,textl57,textl58,textl59]
        
        NewProjectViewController.selected = ["0","0","0","0","0","0"]
        TABLEVIEW.tableFooterView = UIView()
        NewProjectViewController.TLRBText =  Array<Any>(repeating: "NULL", count: 4) as! [String]
        QuestionsCell.OptionSelecred = Array<Any>(repeating: "NULL", count: 59) as! [String]
        QuestionsCell.TextBoxLabel = Array<Any>(repeating: "NULL", count: 59) as! [String]
        // Do any additional setup after loading the view.
        //ImgView.addEntries(from: RoofShinglePhotoCheckList)
        manager?.listener = { status in var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                self.NetWork = statusStr!
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.NetWork = statusStr!
            case .reachable:
                if (self.manager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                    self.NetWork = statusStr!
                } else if (self.manager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                    self.NetWork = statusStr!
                }
                break
            }
            print(statusStr! as Any)
        }
        manager?.startListening()
        self.imageManager = PHCachingImageManager()
        self.resetCachedAssets()
        //print("网络状态:\(NetWork)")
    }

    
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    @IBAction func SaveProject(_ sender: Any) {
        
        Check_data()
        
    }
    @IBAction func CancelView(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    func Check_data(){
        print("网络状态:\(NetWork)")
        for (index , item) in QuestionsCell.OptionSelecred.enumerated(){
            if(item == "NULL"){
                if(index == 15 || index == 16 || index == 18 || index == 19 || index == 20 || index == 21 || index == 22 || index == 35 || index == 54 || index == 36 || index == 58){
                    if((index == 15 || index == 16 ) && QuestionsCell.OptionSelecred[14] == "Yes"){
                        let alertController = UIAlertController(title: "The problem:\(index+1) is not filled out",
                            message: nil, preferredStyle: .alert)
                        //显示提示框
                        self.present(alertController, animated: true, completion: nil)
                        //两秒钟后自动消失
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.presentedViewController?.dismiss(animated: false, completion: nil)
                        }
                        return
                    }
                    if((index == 18 || index == 19 || index == 20 || index == 21 || index == 22 ) && QuestionsCell.OptionSelecred[17] == "Yes"){
                        let alertController = UIAlertController(title: "The problem:\(index+1) is not filled out",
                            message: nil, preferredStyle: .alert)
                        //显示提示框
                        self.present(alertController, animated: true, completion: nil)
                        //两秒钟后自动消失
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.presentedViewController?.dismiss(animated: false, completion: nil)
                        }
                        return
                    }
                }else{
                    let alertController = UIAlertController(title: "The problem:\(index+1) is not filled out",
                        message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                    return
                }
                
            }
        }
        if(Pickerimage6.count == 0){
            let alertController = UIAlertController(title: "Full 3D Site Imaging no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage7.count == 0){
            let alertController = UIAlertController(title: "Shingle Photo – Close Up no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage8.count == 0){
            let alertController = UIAlertController(title: "Shingle Photo – Top View no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage9.count == 0){
            let alertController = UIAlertController(title: "Shingle Photo – Back View no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage24.count == 0){
            let alertController = UIAlertController(title: "Meter Photo – Close Up no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage25.count == 0){
            let alertController = UIAlertController(title: "Meter Photo – Wide Angle no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage26.count == 0){
            let alertController = UIAlertController(title: "Meter Height Measurement Photo no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage27.count == 0){
            let alertController = UIAlertController(title: "Meter Surrounding Area Photo no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage28.count == 0){
            let alertController = UIAlertController(title: "Meter Obstruction Photo no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage29.count == 0){
            let alertController = UIAlertController(title: "Teck Cable Route Reference Photo no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage30.count == 0){
            let alertController = UIAlertController(title: "Trenching Route Aerial Photo no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage31.count == 0){
            let alertController = UIAlertController(title: "Trenching Route Ground Photo no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage38.count == 0){
            let alertController = UIAlertController(title: "Main Breaker Panel Photo – Close Up no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage39.count == 0){
            let alertController = UIAlertController(title: "Main Breaker Panel Photo – Wide Angle no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage40.count == 0){
            let alertController = UIAlertController(title: "Main Breaker Panel Photo – Interior no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        if(Pickerimage41.count == 0){
            let alertController = UIAlertController(title: "Main Breaker Panel Photo – 360 Degree no pictures!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        
        SetProjectData()
    }
    func SetProjectData(){
        ImgView.addEntries(from: ["RoofShinglePhotoCheckList" : RoofShinglePhotoCheckList])
        ImgView.addEntries(from: ["MeterPhotoCheckList" : MeterPhotoCheckList])
        ImgView.addEntries(from: ["MainBreakerPhotoCheckList" : MainBreakerPhotoCheckList])
        ImgView.addEntries(from: ["TrussType" : TrussType])
        QuestionsCell.OptionSelecred[36] = "\(NewProjectViewController.TLRBText[0]),\(NewProjectViewController.TLRBText[1]),\(NewProjectViewController.TLRBText[3]),\(NewProjectViewController.TLRBText[2])"
        for i in 0...QuestionsCell.OptionSelecred.count{
            if (i == QuestionsCell.OptionSelecred.count){
                break
            }
            if(QuestionsCell.OptionSelecred[i] == "NULL"){
                QuestionsCell.OptionSelecred[i] = ""
            }
            if(i == 16 || i == 22){
                QuestionsCell.OptionSelecred[i] = QuestionsCell.TextBoxLabel[i]
            }else if(QuestionsCell.OptionSelecred[i] == "Other"){
                if(QuestionsCell.TextBoxLabel[i] != "NULL"){
                    QuestionsCell.OptionSelecred[i] = QuestionsCell.TextBoxLabel[i]
                }else{
                    QuestionsCell.OptionSelecred[i] = ""
                }
            }else if(i == 58){
                if(QuestionsCell.TextBoxLabel[i] != "NULL"){
                    QuestionsCell.OptionSelecred[i] = QuestionsCell.TextBoxLabel[i]
                }else{
                    QuestionsCell.OptionSelecred[i] = ""
                }
            }
        }
        let PorjectList = [
            "uploaded":false,
            "Datauploaded":false,
            "Answer":[
                "sa_prj":"\(Project_Id!)",
                "sa_shingleMaterial":"\(QuestionsCell.OptionSelecred[0])",
                "sa_missingShingles":"\(QuestionsCell.OptionSelecred[1])",
                "sa_missingRidgeCap":"\(QuestionsCell.OptionSelecred[2])",
                "sa_curvedPlywood":"\(QuestionsCell.OptionSelecred[3])",
                "sa_overallRoofCondition":"\(QuestionsCell.OptionSelecred[4])",
                "sa_full3DSiteImaging":"\(QuestionsCell.OptionSelecred[5])",
                "sa_shinglePhotoCloseUp":"\(QuestionsCell.OptionSelecred[6])",
                "sa_shinglePhotoTopView":"\(QuestionsCell.OptionSelecred[7])",
                "sa_shinglePhotoBackView":"\(QuestionsCell.OptionSelecred[8])",
                "sa_meterLocation":"\(QuestionsCell.OptionSelecred[9])",
                "sa_connectionType":"\(QuestionsCell.OptionSelecred[10])",
                "sa_exteriorWallMaterial":"\(QuestionsCell.OptionSelecred[11])",
                "sa_meterHeight":"\(QuestionsCell.OptionSelecred[12])",
                "sa_gasMeterLocation":"\(QuestionsCell.OptionSelecred[13])",
                "sa_meterObstruction":"\(QuestionsCell.OptionSelecred[14])",
                "sa_obstructionType1":"\(QuestionsCell.OptionSelecred[15])",
                "sa_obstructionDistance":"\(QuestionsCell.TextBoxLabel[16])",
                "sa_trenchingRequired":"\(QuestionsCell.OptionSelecred[17])",
                "sa_trenchingOverDriveway":"\(QuestionsCell.OptionSelecred[18])",
                "sa_trenchingMaterial":"\(QuestionsCell.OptionSelecred[19])",
                "sa_trenchingObstructions":"\(QuestionsCell.OptionSelecred[20])",
                "sa_trenchingObstructionType":"\(QuestionsCell.OptionSelecred[21])",
                "sa_trenchingDistance":"\(QuestionsCell.TextBoxLabel[22])",
                "sa_meterPhotoCloseUp":"\(QuestionsCell.OptionSelecred[23])",
                "sa_meterPhotoWideAngle":"\(QuestionsCell.OptionSelecred[24])",
                "sa_meterHeightMeasurementPhoto":"\(QuestionsCell.OptionSelecred[25])",
                "sa_meterSurroundingAreaPhoto":"\(QuestionsCell.OptionSelecred[26])",
                "sa_meterObstructionPhoto":"\(QuestionsCell.OptionSelecred[27])",
                "sa_teckCableRouteReferencePhoto":"\(QuestionsCell.OptionSelecred[28])",
                "sa_trenchingRouteAerialPhoto":"\(QuestionsCell.OptionSelecred[29])",
                "sa_trenchingRouteGroundPhoto":"\(QuestionsCell.OptionSelecred[30])",
                "sa_breakerPanelAmp":"\(QuestionsCell.OptionSelecred[31])",
                "sa_breakerPanelLocation":"\(QuestionsCell.OptionSelecred[32])",
                "sa_availableBreakerSlot":"\(QuestionsCell.OptionSelecred[33])",
                "sa_breakerPanelObstruction":"\(QuestionsCell.OptionSelecred[34])",
                "sa_obstructionType":"\(QuestionsCell.OptionSelecred[35])",
                "sa_panelDistance":"\(QuestionsCell.OptionSelecred[36])",
                "sa_mainBreakerPanelPhotoCloseUp":"\(QuestionsCell.OptionSelecred[37])",
                "sa_mainBreakerPanelPhotoWideAngle":"\(QuestionsCell.OptionSelecred[38])",
                "sa_mainBreakerPanelPhotoInterior":"\(QuestionsCell.OptionSelecred[39])",
                "sa_mainBreakerPanelPhoto360Degree":"\(QuestionsCell.OptionSelecred[40])",
                "sa_locationElectricalMeter":"\(QuestionsCell.OptionSelecred[41])",
                "sa_locationGasMeter":"\(QuestionsCell.OptionSelecred[42])",
                "sa_locationObstruction":"\(QuestionsCell.OptionSelecred[43])",
                "sa_locationMainBreakerPanel":"\(QuestionsCell.OptionSelecred[44])",
                "sa_distanceElectricalMeterToFrontCornerOfHouse":"\(QuestionsCell.OptionSelecred[45])",
                "sa_distanceElectricalMeterToGasMeter":"\(QuestionsCell.OptionSelecred[46])",
                "sa_distanceElectricalMeterToYardDoor":"\(QuestionsCell.OptionSelecred[47])",
                "sa_distanceElectricalMeterToObstruction":"\(QuestionsCell.OptionSelecred[48])",
                "sa_roofSheathing":"\(QuestionsCell.OptionSelecred[49])",
                "sa_signsOfMold":"\(QuestionsCell.OptionSelecred[50])",
                "sa_signsOfWaterLeakage":"\(QuestionsCell.OptionSelecred[51])",
                "sa_waterLeakageType":"\(QuestionsCell.OptionSelecred[52])",
                "sa_signsOfDamage":"\(QuestionsCell.OptionSelecred[53])",
                "sa_typeOfDamage":"\(QuestionsCell.OptionSelecred[54])",
                "sa_trussSpacing":"\(QuestionsCell.OptionSelecred[55])",
                "sa_trussMemberSize":"\(QuestionsCell.OptionSelecred[56])",
                "sa_trussType":"\(QuestionsCell.OptionSelecred[57])"
            ],
            "Img":ImgView
            ] as [String : Any]  //声明一个字典
        
        
        let filePath:String = NSHomeDirectory() + "/Documents/\(Project_Id!).plist"
        NSDictionary(dictionary: PorjectList).write(toFile: filePath, atomically: true)
        print(filePath)
        var alertText = ""
        if(NetWork == "wifi的网络" || NetWork == "2G,3G,4G...的网络"){
            UploadProject.Uploadshared.UploadProjectdata(Project_Id!)
            alertText = "Upload And Save data Success !"
            if(NetWork == "wifi的网络"){
                let projectinformation = ProjectInformation()
                projectinformation.setValue(Project_Id, forKey: "ProjectName")
                
                ProjectListViewController.ProjectInformationList.addEntries(from: [Project_Id:projectinformation])
                UploadProject.Uploadshared.UploadProjectToGoogleDrive(Project_Id)
                
                alertText = "Upload And Save data And Img Success !"
            }
            
        }else{
            alertText = "Only Save Success !"
        }
        
        let alertController = UIAlertController(title: alertText,
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            self.presentingViewController!.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setExtraCellLineHidden(tableview:UITableView){
        let viw = UIView()
        viw.backgroundColor = UIColor.clear
        tableview.tableFooterView = viw
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Arr.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(NewProjectViewController.selected[section] == "1"){
            let Ar = Arr[section] as! Dictionary<String, Any>
            let QuetionList = Ar["QuestionList"] as! NSMutableArray
            return QuetionList.count
        }
        else{
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(Arr.count)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIDstr) as? QuestionsCell
        //let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        //防止视图加载重叠,删除上一次的控件
        
        if( cell != nil ){
            for cell in cell!.contentView.subviews {
                cell.removeFromSuperview()
            }
        }
        cell = QuestionsCell(style: .default, reuseIdentifier: cellIDstr)
        
        cell?.layer.masksToBounds = true
        //celltitle = Arr[indexPath.row] as! Dictionary
        //print(celltitle["Item"])
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        //let title :String = questions_list[indexPath.row].0 + "." + questions_list[indexPath.row].1
        let Ar_r = Arr[indexPath.section] as! Dictionary<String,Any>
        let Ar_QuestionList = Ar_r["QuestionList"] as! NSMutableArray
        let Ar = Ar_QuestionList[indexPath.row] as! Dictionary<String, Any>
        let Item = Ar["Item"] as? String
        /*if(QuestionsCell.OptionSelecred[Int(Item!)!-1] == "NULL"){
            QuestionsCell.OptionSelecred[Int(Item!)!-1] = (Ar["DefaultValue"] as? String)!
        }*/
        let Question = Ar["Question"] as? String
        let Option = Ar["option"] as! NSMutableArray
        let text = Question!
        if(Item == "37"){
            //print(cell?.)
            //print(indexPath)
            //let ImageView :UIImageView = UIImageView(frame: CGRect(x: 20, y: 90, width: 400, height: 400))
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.setTabelCheckbox(option: Option as! Array<Any>,QuestionItem: Item!)
            if selectedCellIndexPaths.contains(indexPath as NSIndexPath) {
                cell!.textLabel?.textColor = UIColor(red: 0.0000, green: 0.6824, blue: 0.4627, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand1,Item: Item!)
            }else{
                cell!.textLabel?.textColor = UIColor(red: 0.3961, green: 0.3961, blue: 0.3961, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand,Item: Item!)
            }
            
            let Main_Breaker_Panel_Diagram:UIImage = UIImage(named: "Main_Breaker_Panel_Diagram")!
            let Pickerimage:UIImageView!=UIImageView(frame: CGRect(x:225, y:200, width: 300, height: 300))
            Pickerimage.image = Main_Breaker_Panel_Diagram
            let TopText :UITextField = UITextField(frame: CGRect(x: 275, y: 155, width: 180, height: 40))
            let TopM :UILabel = UILabel(frame: CGRect(x: 275+190, y: 155, width: 40, height: 40))
            TopM.text = "M"
            TopM.font = UIFont.systemFont(ofSize: 35)
            TopText.placeholder = "Top"
            TopText.font = UIFont.systemFont(ofSize: 35)
            TopText.layer.borderWidth = 1.0
            let TopKB = KeyBoardView.init()
            TopText.inputView = TopKB
            TopKB.inputSource = TopText
            let LeftText :UITextField = UITextField(frame: CGRect(x: 20, y: 325, width: 180, height: 40))
            let LeftM :UILabel = UILabel(frame: CGRect(x: 20+190, y: 325, width: 40, height: 40))
            LeftM.text = "M"
            LeftM.font = UIFont.systemFont(ofSize: 35)
            LeftText.placeholder = "Left"
            LeftText.font = UIFont.systemFont(ofSize: 35)
            LeftText.layer.borderWidth = 1.0
            let LeftKB = KeyBoardView.init()
            LeftText.inputView = LeftKB
            LeftKB.inputSource = LeftText
            let RightText :UITextField = UITextField(frame: CGRect(x: 530, y: 325, width: 180, height: 40))
            let RightM :UILabel = UILabel(frame: CGRect(x: 530+190, y: 325, width: 40, height: 40))
            RightM.text = "M"
            RightM.font = UIFont.systemFont(ofSize: 35)
            RightText.placeholder = "Right"
            RightText.font = UIFont.systemFont(ofSize: 35)
            RightText.layer.borderWidth = 1.0
            let RightKB = KeyBoardView.init()
            RightText.inputView = RightKB
            RightKB.inputSource = RightText
            let buttomText :UITextField = UITextField(frame: CGRect(x: 275, y: 505, width: 180, height: 40))
            let buttomM :UILabel = UILabel(frame: CGRect(x: 275+190, y: 505, width: 40, height: 40))
            buttomM.text = "M"
            buttomM.font = UIFont.systemFont(ofSize: 35)
            buttomText.placeholder = "buttom"
            buttomText.font = UIFont.systemFont(ofSize: 35)
            buttomText.layer.borderWidth = 1.0
            let buttomKB = KeyBoardView.init()
            buttomText.inputView = buttomKB
            buttomKB.inputSource = buttomText
            textlArr[indexPath.row] = CGFloat(500)
            
            cell?.contentView.addSubview(Pickerimage)
            cell?.contentView.addSubview(TopText)
            cell?.contentView.addSubview(TopM)
            cell?.contentView.addSubview(LeftText)
            cell?.contentView.addSubview(LeftM)
            cell?.contentView.addSubview(RightText)
            cell?.contentView.addSubview(RightM)
            cell?.contentView.addSubview(buttomText)
            cell?.contentView.addSubview(buttomM)
            TopText.delegate = self 
            LeftText.delegate = self
            RightText.delegate = self
            buttomText.delegate = self
            TopText.tag = 1000
            LeftText.tag = 2000
            RightText.tag = 3000
            buttomText.tag = 4000
            if(NewProjectViewController.TLRBText[(TopText.tag/1000)-1] != "NULL"){
                TopText.text = NewProjectViewController.TLRBText[(TopText.tag/1000)-1]
            }
            if(NewProjectViewController.TLRBText[(LeftText.tag/1000)-1] != "NULL"){
                LeftText.text = NewProjectViewController.TLRBText[(LeftText.tag/1000)-1]
            }
            if(NewProjectViewController.TLRBText[(RightText.tag/1000)-1] != "NULL"){
                RightText.text = NewProjectViewController.TLRBText[(RightText.tag/1000)-1]
            }
            if(NewProjectViewController.TLRBText[(buttomText.tag/1000)-1] != "NULL"){
                buttomText.text = NewProjectViewController.TLRBText[(buttomText.tag/1000)-1]
            }
            
        }else if(Item == "59"){
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.setTabelCheckbox(option: Option as! Array<Any>,QuestionItem: Item!)
            if selectedCellIndexPaths.contains(indexPath as NSIndexPath) {
                cell!.textLabel?.textColor = UIColor(red: 0.0000, green: 0.6824, blue: 0.4627, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand1 ,Item: Item!)
            }else{
                cell!.textLabel?.textColor = UIColor(red: 0.3961, green: 0.3961, blue: 0.3961, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand ,Item: Item!)
            }
            textlArr[indexPath.row] = CGFloat(300)
        }else if(Item == "6" || Item == "24" || Item == "38" || Item == "42" || Item == "58"){
            cell?.setinittitle(Item: Item!)
            if(Item == "58"){
                let Truss_Type:UIImage = UIImage(named: "Truss_Type")!
                let Truss_Type_View:UIImageView!=UIImageView(frame: CGRect(x:15, y:190, width: UIScreen.main.bounds.width-40, height: 250))
                Truss_Type_View.image = Truss_Type
                cell?.contentView.addSubview(Truss_Type_View)
            }
            cell?.setinitlabel(lableStr: text,Item: Item!)
            if(Item == "6"){
                
                
                cell?.viewWithTag(600)?.removeFromSuperview()
                let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage6_Nums%3)+10, y : 150+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage6_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                Img_Btn.setTitle("+", for:.normal)
                Img_Btn.setTitleColor(UIColor.black, for: .normal)
                Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
                Img_Btn.titleLabel?.textColor = UIColor.gray
                Img_Btn.tag = 600
                Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
                cell?.addSubview(Img_Btn)
                textlArr[indexPath.row] = CGFloat(300*(Pickerimage6_Nums/3+1))
                for i in 0...Pickerimage6_Nums{
                    //print("图片位置生成")
                    if(i < Pickerimage6.count ){
                        //Pickerimage6[i]
                        let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 150+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                        Image.image = Pickerimage6[i].image
                        //print(Image)
                        cell?.addSubview(Image)
                    }
                }
                
            }else if(Item == "24"){
                
                
                cell?.viewWithTag(2400)?.removeFromSuperview()
                let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage24_Nums%3)+10, y : 150+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage24_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                Img_Btn.setTitle("+", for:.normal)
                Img_Btn.setTitleColor(UIColor.black, for: .normal)
                Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
                Img_Btn.titleLabel?.textColor = UIColor.gray
                Img_Btn.tag = 2400
                Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
                cell?.addSubview(Img_Btn)
                textlArr[indexPath.row] = CGFloat(300*(Pickerimage24_Nums/3+1))
                for i in 0...Pickerimage24_Nums{
                    //print("图片位置生成")
                    if(i < Pickerimage24.count ){
                        //Pickerimage6[i]
                        let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 150+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                        Image.image = Pickerimage24[i].image
                        //print(Image)
                        cell?.addSubview(Image)
                    }
                }
                
            }else if(Item == "38"){
                cell?.viewWithTag(3800)?.removeFromSuperview()
                let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage38_Nums%3)+10, y : 150+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage38_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                Img_Btn.setTitle("+", for:.normal)
                Img_Btn.setTitleColor(UIColor.black, for: .normal)
                Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
                Img_Btn.titleLabel?.textColor = UIColor.gray
                Img_Btn.tag = 3800
                Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
                cell?.addSubview(Img_Btn)
                textlArr[indexPath.row] = CGFloat(300*(Pickerimage38_Nums/3+1))
                for i in 0...Pickerimage38_Nums{
                    //print("图片位置生成")
                    if(i < Pickerimage38.count ){
                        //Pickerimage6[i]
                        let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 150+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                        Image.image = Pickerimage38[i].image
                        //print(Image)
                        cell?.addSubview(Image)
                    }
                }
                
            }else{
                cell?.setTabelCheckbox(option: Option as! Array<Any>,QuestionItem: Item!)
                //textlArr[indexPath.row] = CGFloat(((Option.count-1)/2)*60+80)
                if(Item == "58"){
                    cell?.viewWithTag(5800)?.removeFromSuperview()
                    if(Pickerimage58.count == 0){
                        let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage58_Nums%3)+10, y : 840+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage58_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                        Img_Btn.setTitle("+", for:.normal)
                        Img_Btn.setTitleColor(UIColor.black, for: .normal)
                        Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
                        Img_Btn.titleLabel?.textColor = UIColor.gray
                        Img_Btn.tag = 5800
                        Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                        Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
                        cell?.addSubview(Img_Btn)
                    }
                    
                    textlArr[indexPath.row] = CGFloat(((Option.count-1)/2)*60+80)
                    if(Pickerimage58_Nums == 1){
                        let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(0%3)+10, y : 840+(UIScreen.main.bounds.width/3)*CGFloat(0/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                        Image.image = Pickerimage58[0].image
                        //print(Image)
                        cell?.addSubview(Image)
                    }
                    
                }
            }
            
            
            if selectedCellIndexPaths.contains(indexPath as NSIndexPath) {
                cell!.textLabel?.textColor = UIColor(red: 0.0000, green: 0.6824, blue: 0.4627, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand1 ,Item: Item!)
            }else{
                cell!.textLabel?.textColor = UIColor(red: 0.3961, green: 0.3961, blue: 0.3961, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand ,Item: Item!)
            }
            cell!.layer.masksToBounds = true
        }else if(Item == "7"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(700)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage7_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage7_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 700
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage7_Nums/3+1))
            for i in 0...Pickerimage7_Nums{
                if(i < Pickerimage7.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage7[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "8"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(800)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage8_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage8_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 800
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage8_Nums/3+1))
            for i in 0...Pickerimage8_Nums{
                if(i < Pickerimage8.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage8[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "9"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(900)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage9_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage9_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 900
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage9_Nums/3+1))
            for i in 0...Pickerimage9_Nums{
                if(i < Pickerimage9.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage9[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "25"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(2500)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage25_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage25_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 2500
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage25_Nums/3+1))
            for i in 0...Pickerimage25_Nums{
                if(i < Pickerimage25.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage25[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "26"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(2600)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage26_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage26_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 2600
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage26_Nums/3+1))
            for i in 0...Pickerimage26_Nums{
                if(i < Pickerimage26.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage26[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "27"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(2700)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage27_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage27_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 2700
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage27_Nums/3+1))
            for i in 0...Pickerimage27_Nums{
                if(i < Pickerimage27.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage27[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "28"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(2800)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage28_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage28_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 2800
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage28_Nums/3+1))
            for i in 0...Pickerimage28_Nums{
                if(i < Pickerimage28.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage28[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "29"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(2900)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage29_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage29_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 2900
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage29_Nums/3+1))
            for i in 0...Pickerimage29_Nums{
                if(i < Pickerimage29.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage29[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "30"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(3000)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage30_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage30_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 3000
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage30_Nums/3+1))
            for i in 0...Pickerimage30_Nums{
                if(i < Pickerimage30.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage30[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "31"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(3100)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage31_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage31_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 3100
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage31_Nums/3+1))
            for i in 0...Pickerimage31_Nums{
                if(i < Pickerimage31.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage31[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "39"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(3900)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage39_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage39_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 3900
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage39_Nums/3+1))
            for i in 0...Pickerimage39_Nums{
                if(i < Pickerimage39.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage39[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "40"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(4000)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage40_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage40_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 4000
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage40_Nums/3+1))
            for i in 0...Pickerimage40_Nums{
                if(i < Pickerimage40.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage40[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else if(Item == "41"){
            cell?.setinittitle(Item: Item!)
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.viewWithTag(4100)?.removeFromSuperview()
            let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage41_Nums%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(Pickerimage41_Nums/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
            Img_Btn.setTitle("+", for:.normal)
            Img_Btn.setTitleColor(UIColor.black, for: .normal)
            Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
            Img_Btn.titleLabel?.textColor = UIColor.gray
            Img_Btn.tag = 4100
            Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
            Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
            cell?.addSubview(Img_Btn)
            textlArr[indexPath.row] = CGFloat(300*(Pickerimage41_Nums/3+1))
            for i in 0...Pickerimage41_Nums{
                if(i < Pickerimage41.count ){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 90+(UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Image.image = Pickerimage41[i].image
                    //print(Image)
                    cell?.addSubview(Image)
                }
            }
            
        }else{
            cell?.setinitlabel(lableStr: text,Item: Item!)
            cell?.setTabelCheckbox(option: Option as! Array<Any>,QuestionItem: Item!)
            textlArr[indexPath.row] = CGFloat(((Option.count-1)/2)*60+80)
            if selectedCellIndexPaths.contains(indexPath as NSIndexPath) {
                cell!.textLabel?.textColor = UIColor(red: 0.0000, green: 0.6824, blue: 0.4627, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand1 ,Item: Item!)
            }else{
                cell!.textLabel?.textColor = UIColor(red: 0.3961, green: 0.3961, blue: 0.3961, alpha: 1.0000)
                cell!.setinitimage(imaged: ico_expand ,Item: Item!)
            }
            cell!.layer.masksToBounds = true
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let Ar = Arr[section] as! Dictionary<String, Any>
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = Ar["heading"]! as? String
        header.arrowLabel.text = ">"
        header.setCollapsed(NewProjectViewController.selected[section]=="1")
        
        header.section = section
        header.delegate = self as! CollapsibleTableViewHeaderDelegate
        
        return header
        /*
         
         header.titleLabel.text = Ar["heading"]! as? String
         header.arrowLabel.text = ">"
         header.setCollapsed(selected[section])
         
         header.section = section
         header.delegate = self
         */
        
        //return header
    }
    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     let Ar = Arr[section] as! Dictionary<String, Any>
     let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
     button.tag = section+1
     button.backgroundColor = UIColor.white
     button.setTitle(Ar["heading"]! as? String, for: .normal)
     button.setTitleColor(UIColor.black, for: .normal)
     //button.addTarget(self, action: SetSelected(button, tableView), for: .touchUpInside)
     button.addTarget(self, action:#selector(SetSelected(_:)), for:.touchUpInside)
     
     
     return Ar["heading"]! as? String
     }
     */
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    //table的cell高度，可选方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sdwsa = CGFloat()
        //根据类容的高度 改变cell的高度
        //print(indexPath)
        sdwsa = 0
        if(selectedCellIndexPaths.contains(indexPath as NSIndexPath)){
            //sdwsa = textlArr[indexPath.row] + 100
            //print(indexPath)
            let Ar_r = Arr[indexPath.section] as! Dictionary<String,Any>
            let Ar_QuestionList = Ar_r["QuestionList"] as! NSMutableArray
            let Ar = Ar_QuestionList[indexPath.row] as! Dictionary<String, Any>
            let Item = Ar["Item"] as? String
            if(Item == "6" || Item == "24" || Item == "38" || Item == "42" ){
                sdwsa = 70
            }else if(Item == "58"){
                sdwsa = 370
            }
            if(QuestionsCell.OptionSelecred[Int(Item!)!-1] == "Other"){
                //print(QuestionsCell.OptionSelecred[indexPath.row])
                sdwsa = sdwsa + 70 + textlArr[indexPath.row] + 300
            }else{
                if(Item == "16" || Item == "22" || Item == "36"){
                    if(QuestionsCell.OptionSelecred[Int(Item!)!-1] != "NULL"){
                        //print(Item == "16" && (Int(QuestionsCell.OptionSelecred[Int(Item!)!-1])! > 31))
                        if(Item == "16" && (Int(QuestionsCell.OptionSelecred[Int(Item!)!-1])! > 31)){
                            sdwsa = sdwsa + 70 + textlArr[indexPath.row] + 300
                            //print(sdwsa)
                        }else if((Item == "22" || Item == "36") && (Int(QuestionsCell.OptionSelecred[Int(Item!)!-1])! > 7)){
                            sdwsa = sdwsa + 70 + textlArr[indexPath.row] + 300
                        }else{
                            sdwsa = sdwsa + 70 + textlArr[indexPath.row]
                        }
                    }else{
                        sdwsa = sdwsa + 70 + textlArr[indexPath.row]
                    }
                    
                }else{
                    sdwsa = sdwsa + 70 + textlArr[indexPath.row]
                }
                
            }
            
            
        }else{
            let Ar_r = Arr[indexPath.section] as! Dictionary<String,Any>
            let Ar_QuestionList = Ar_r["QuestionList"] as! NSMutableArray
            let Ar = Ar_QuestionList[indexPath.row] as! Dictionary<String, Any>
            let IsNoShow = Ar["IsNoShow"] as? Bool
            var Question_Item = Int((Ar["Item"] as? String)!)!-1
            if(Question_Item == 5 || Question_Item == 23 || Question_Item == 37 || Question_Item == 41){
                sdwsa = 70
            }
            if(Question_Item == 58){
                sdwsa = 370
                sdwsa = sdwsa + 70 + textlArr[indexPath.row]
                return sdwsa
            }
            if(IsNoShow)!{
                Question_Item = Question_Item - 1
                switch Question_Item {
                case 14:
                    if(QuestionsCell.OptionSelecred[14] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[15] = "NULL"
                        sdwsa = 0
                    }
                    break
                case 15:
                    if(QuestionsCell.OptionSelecred[14] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        sdwsa = 0
                    }
                    break
                case 17:
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[18] = "NULL"
                        sdwsa = 0
                    }
                    break
                case 18:
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[19] = "NULL"
                        sdwsa = 0
                    }
                    break
                case 19:
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[20] = "NULL"
                        sdwsa = 0
                    }
                    break
                case 20    :
                    if(QuestionsCell.OptionSelecred[20] == "Yes" && QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[21] = "NULL"
                        sdwsa = 0
                    }
                    break
                case 21 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        sdwsa = 0
                    }
                    break
                case 34 :
                    if(QuestionsCell.OptionSelecred[34] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[35] = "NULL"
                        sdwsa = 0
                    }
                    break
                case 22 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[23] = "NULL"
                        Pickerimage24.removeAll()
                        Pickerimage24_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 23 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[24] = "NULL"
                        Pickerimage25.removeAll()
                        Pickerimage25_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 24 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[25] = "NULL"
                        Pickerimage26.removeAll()
                        Pickerimage26_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 25 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[26] = "NULL"
                        Pickerimage27.removeAll()
                        Pickerimage27_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 26 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[27] = "NULL"
                        Pickerimage28.removeAll()
                        Pickerimage28_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 27 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[28] = "NULL"
                        Pickerimage29.removeAll()
                        Pickerimage29_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 28 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[29] = "NULL"
                        Pickerimage30.removeAll()
                        Pickerimage30_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 29 :
                    if(QuestionsCell.OptionSelecred[17] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[30] = "NULL"
                        Pickerimage31.removeAll()
                        Pickerimage31_Nums = 0
                        sdwsa = 0
                    }
                    break
                case 53 :
                    if(QuestionsCell.OptionSelecred[53] == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        QuestionsCell.OptionSelecred[54] = "NULL"
                        sdwsa = 0
                    }
                    break
                default:
                    sdwsa = sdwsa + 0
                    break
                }
            }else{
                sdwsa = sdwsa + 80
            }
        }
        return sdwsa
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击展开或收缩
        print(indexPath.section)
        
        if let index = selectedCellIndexPaths.index(of: indexPath as NSIndexPath) {
            selectedCellIndexPaths.remove(at: index)
            //selectedCellIndexPaths.removeAtIndex(index)
        }else{
            if(selectedCellIndexPaths.count >= 1){
                selectedCellIndexPaths.remove(at: 0    )
            }
            selectedCellIndexPaths.append(indexPath as NSIndexPath)
        }
        //刷新cell
        tableView.reloadRows(at: [indexPath as IndexPath], with: .automatic)
        
        
    }
    
    //func tableView
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    
    
    func selectorSourceType(type: String) {
        //imagePicker.sourceType = type
        if(type == "camera"){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        // 打开图片选择器
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc func tapped(_ button:UIButton) {
        print(button.tag)
        let Nums = button.tag/100
        Pickerimage_Nums = Nums
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil)) // 取消按钮
        
#if targetEnvironment(simulator)
#else
        controller.addAction(UIAlertAction(title: "拍照选择", style: .default) { action in
            self.selectorSourceType(type: "camera")
        }) // 拍照选择
#endif
        controller.addAction(UIAlertAction(title: "相册选择", style: .default) { action in
            //self.selectorSourceType(type: "photoLibrary")
            _ = self.presentHGImagePicker(maxSelected:9) { (assets) in
                //结果处理
                //print("共选择了\(assets.count)张图片，分别如下：")
                for asset in assets {
                    //print(asset)
                    
                    self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { (image, nfo) in
                        self.SavePickImage(image!)
                    })
                    /*
                    self.imageManager.requestImage(for: asset, targetSize: CGSize(width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20), contentMode: .aspectFit, options: nil, resultHandler: { (image, nfo) in
                        self.SavePickImage(image!)
                    })*/
                }
            }
        }) // 相册选择
        //print("弹出选择")
        // support iPad
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 400)
        
        self.present(controller, animated: true, completion: nil)
    }
    // MARK: 当图片选择器选择了一张图片之后回调
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("获取到相册了")
        picker.dismiss(animated: true, completion: nil) // 选中图片, 关闭选择器...这里你也可以 picker.dismissViewControllerAnimated 这样调用...但是效果都是一样的...
        var tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        /*
        tempImage.compressImage(100, completion: { (image, compressRatio) in
            if let imageData = UIImageJPEGRepresentation(image, compressRatio) {
                tempImage = UIImage(data: imageData)!
            }
        })*/
        SavePickImage(tempImage)
        
    }
    private func SavePickImage(_ tempImage : UIImage){
        
        let tempImageData = UIImageJPEGRepresentation(tempImage, 1)
        let TempImagelength = (tempImageData?.count)!/1000
        print("TempImagelength:\(TempImagelength)")
        var tempImageSLT:UIImage = tempImage
        tempImageSLT.compressImage(100, completion: { (image, compressRatio) in
            if let imageData = UIImageJPEGRepresentation(image, compressRatio) {
                tempImageSLT = UIImage(data: imageData)!
            }
        })
        
        
        
        
        var Nums = 0
        var PickerImage_Name = ""
        if(Pickerimage_Nums == 6){
            PickerImage_Name = "3dsiteimaging"
            QuestionsCell.OptionSelecred[5] = "Yes"
            let UIImgView:UIImageView = UIImageView()
            Pickerimage6.append(UIImgView)
            Pickerimage6[Pickerimage6_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage6_Nums = Pickerimage6_Nums+1
            Nums = Pickerimage6_Nums
            TABLEVIEW.reloadRows(at: [[0,5]], with: .automatic)
        }else if(Pickerimage_Nums == 7){
            PickerImage_Name = "ShinglePhoto–CloseUp"
            QuestionsCell.OptionSelecred[6] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage7.append(UIImgView)
            Pickerimage7[Pickerimage7_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage7_Nums = Pickerimage7_Nums+1
            Nums = Pickerimage7_Nums
            TABLEVIEW.reloadRows(at: [[0,6]], with: .automatic)
        }else if(Pickerimage_Nums == 8){
            PickerImage_Name = "ShinglePhoto–TopView"
            QuestionsCell.OptionSelecred[7] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage8.append(UIImgView)
            Pickerimage8[Pickerimage8_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage8_Nums = Pickerimage8_Nums+1
            Nums = Pickerimage8_Nums
            TABLEVIEW.reloadRows(at: [[0,7]], with: .automatic)
        }else if(Pickerimage_Nums == 9){
            PickerImage_Name = "ShinglePhoto–BackView"
            QuestionsCell.OptionSelecred[8] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage9.append(UIImgView)
            Pickerimage9[Pickerimage9_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage9_Nums = Pickerimage9_Nums+1
            Nums = Pickerimage9_Nums
            TABLEVIEW.reloadRows(at: [[0,8]], with: .automatic)
        }else if(Pickerimage_Nums == 24){
            PickerImage_Name = "MeterPhoto–CloseUp"
            QuestionsCell.OptionSelecred[23] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage24.append(UIImgView)
            Pickerimage24[Pickerimage24_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage24_Nums = Pickerimage24_Nums+1
            Nums = Pickerimage24_Nums
            TABLEVIEW.reloadRows(at: [[1,14]], with: .automatic)
        }else if(Pickerimage_Nums == 25){
            PickerImage_Name = "MeterPhoto–WideAngle"
            QuestionsCell.OptionSelecred[24] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage25.append(UIImgView)
            Pickerimage25[Pickerimage25_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage25_Nums = Pickerimage25_Nums+1
            Nums = Pickerimage25_Nums
            TABLEVIEW.reloadRows(at: [[1,15]], with: .automatic)
        }else if(Pickerimage_Nums == 26){
            PickerImage_Name = "MeterHeightMeasurementPhoto"
            QuestionsCell.OptionSelecred[25] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage26.append(UIImgView)
            Pickerimage26[Pickerimage26_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage26_Nums = Pickerimage26_Nums+1
            Nums = Pickerimage26_Nums
            TABLEVIEW.reloadRows(at: [[1,16]], with: .automatic)
        }else if(Pickerimage_Nums == 27){
            PickerImage_Name = "MeterSurroundingAreaPhoto"
            QuestionsCell.OptionSelecred[26] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage27.append(UIImgView)
            Pickerimage27[Pickerimage27_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage27_Nums = Pickerimage27_Nums+1
            Nums = Pickerimage27_Nums
            TABLEVIEW.reloadRows(at: [[1,17]], with: .automatic)
        }else if(Pickerimage_Nums == 28){
            PickerImage_Name = "MeterObstructionPhoto"
            QuestionsCell.OptionSelecred[27] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage28.append(UIImgView)
            Pickerimage28[Pickerimage28_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage28_Nums = Pickerimage28_Nums+1
            Nums = Pickerimage28_Nums
            TABLEVIEW.reloadRows(at: [[1,18]], with: .automatic)
        }else if(Pickerimage_Nums == 29){
            PickerImage_Name = "TeckCableRouteReferencePhoto"
            QuestionsCell.OptionSelecred[28] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage29.append(UIImgView)
            Pickerimage29[Pickerimage29_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage29_Nums = Pickerimage29_Nums+1
            Nums = Pickerimage29_Nums
            TABLEVIEW.reloadRows(at: [[1,19]], with: .automatic)
        }else if(Pickerimage_Nums == 30){
            PickerImage_Name = "TrenchingRouteAerialPhoto"
            QuestionsCell.OptionSelecred[29] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage30.append(UIImgView)
            Pickerimage30[Pickerimage30_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage30_Nums = Pickerimage30_Nums+1
            Nums = Pickerimage30_Nums
            TABLEVIEW.reloadRows(at: [[1,20]], with: .automatic)
        }else if(Pickerimage_Nums == 31){
            PickerImage_Name = "TrenchingRouteGroundPhoto"
            QuestionsCell.OptionSelecred[30] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage31.append(UIImgView)
            Pickerimage31[Pickerimage31_Nums].image = tempImageSLT // 显示图片
            //Pickerimage31[Pickerimage31_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage31_Nums = Pickerimage31_Nums+1
            Nums = Pickerimage31_Nums
            TABLEVIEW.reloadRows(at: [[1,21]], with: .automatic)
        }else if(Pickerimage_Nums == 38){
            PickerImage_Name = "MainBreakerPanelPhoto–Close Up"
            QuestionsCell.OptionSelecred[37] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage38.append(UIImgView)
            Pickerimage38[Pickerimage38_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage38_Nums = Pickerimage38_Nums+1
            Nums = Pickerimage38_Nums
            TABLEVIEW.reloadRows(at: [[2,6]], with: .automatic)
        }else if(Pickerimage_Nums == 39){
            PickerImage_Name = "MainBreakerPanelPhoto–WideAngle"
            QuestionsCell.OptionSelecred[38] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage39.append(UIImgView)
            Pickerimage39[Pickerimage39_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage39_Nums = Pickerimage39_Nums+1
            Nums = Pickerimage39_Nums
            TABLEVIEW.reloadRows(at: [[2,7]], with: .automatic)
        }else if(Pickerimage_Nums == 40){
            PickerImage_Name = "MainBreakerPanelPhoto–Interior"
            QuestionsCell.OptionSelecred[39] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage40.append(UIImgView)
            Pickerimage40[Pickerimage40_Nums].image = tempImageSLT // 显示图片
            //Pickerimage6[Pickerimage6_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage40_Nums = Pickerimage40_Nums+1
            Nums = Pickerimage40_Nums
            TABLEVIEW.reloadRows(at: [[2,8]], with: .automatic)
        }else if(Pickerimage_Nums == 41){
            PickerImage_Name = "MainBreakerPanelPhoto–360Degree"
            QuestionsCell.OptionSelecred[40] = "Yes"
            //Pickerimage7[Pickerimage7_Nums] = UIImageView()
            let UIImgView:UIImageView = UIImageView()
            Pickerimage41.append(UIImgView)
            Pickerimage41[Pickerimage41_Nums].image = tempImageSLT // 显示图片
            //Pickerimage31[Pickerimage31_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage41_Nums = Pickerimage41_Nums+1
            Nums = Pickerimage41_Nums
            TABLEVIEW.reloadRows(at: [[2,9]], with: .automatic)
        }else if(Pickerimage_Nums == 58){
            PickerImage_Name = "TrussType–Other"
            let UIImgView:UIImageView = UIImageView()
            Pickerimage58.append(UIImgView)
            Pickerimage58[Pickerimage58_Nums].image = tempImageSLT // 显示图片
            //Pickerimage31[Pickerimage31_Nums].contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
            Pickerimage58_Nums = 1
            Nums = Pickerimage58_Nums
            TABLEVIEW.reloadRows(at: [[4,8]], with: .automatic)
        }
        if(Pickerimage_Nums == 6 || Pickerimage_Nums == 7 || Pickerimage_Nums == 8 || Pickerimage_Nums == 9){
            RoofShinglePhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
            //RoofShinglePhotoCheckList.addEntries(from: ["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(Pickerimage_Nums == 24 || Pickerimage_Nums == 25 || Pickerimage_Nums == 26 || Pickerimage_Nums == 27 || Pickerimage_Nums == 28 || Pickerimage_Nums == 29 || Pickerimage_Nums == 30 || Pickerimage_Nums == 31){
            MeterPhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(Pickerimage_Nums == 38 || Pickerimage_Nums == 39 || Pickerimage_Nums == 40 || Pickerimage_Nums == 41){
            MainBreakerPhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(Pickerimage_Nums == 58){
            TrussType.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }
        let ImageName = "\(PickerImage_Name)_\(Nums).jpg"
        var persent = 1.0
        if(TempImagelength>5000){
            persent = Double(4500.0 / Double(TempImagelength))
            print(persent)
        }
        saveImage(currentImage: tempImage, persent: CGFloat(persent), imageName: ImageName)
        
    }
    
    
    
    
    private func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String){
        
        if let imageData = UIImageJPEGRepresentation(currentImage, persent) as NSData? {
            let myDire: String = NSHomeDirectory() + "/Documents/\(Project_Id!)"
            let fileManager = FileManager.default
            try! fileManager.createDirectory(atPath: myDire,
                                                   withIntermediateDirectories: true, attributes: nil)
            
            let fullPath = NSHomeDirectory().appending("/Documents/\(Project_Id!)/").appending(imageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
        }
    }
    // MARK: 当点击图片选择器中的取消按钮时回调
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) // 效果一样的...
        print("取消了")
        
    }
    
    
    
    
    @objc func SetSelected(_ button:UIButton) {
        for i in 0...Arr.count{
            NewProjectViewController.selected[i] = "0"
        }
        NewProjectViewController.selected[button.tag-1] = "1"
        //expandTable.reloadSections([button.tag-1 as Int], with: .automatic)
        //[expandTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIImage {
    
    enum CompressImageErrors: Error {
        case invalidExSize
        case sizeImpossibleToReach
    }
    
    func compressImage(_ expectedSizeKb: Int, completion : (UIImage,CGFloat) -> Void ) {
        
        let minimalCompressRate :CGFloat = 0.4 // min compressRate to be checked later
        
        let expectedSizeBytes = expectedSizeKb * 1024
        let imageToBeHandled: UIImage = self
        var actualHeight : CGFloat = self.size.height
        var actualWidth : CGFloat = self.size.width
        var maxHeight : CGFloat = 841 //A4 default size I'm thinking about a document
        var maxWidth : CGFloat = 594
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        var compressionQuality : CGFloat = 1
        var imageData:Data = UIImageJPEGRepresentation(imageToBeHandled, compressionQuality)!
        while imageData.count > expectedSizeBytes {
            
            if (actualHeight > maxHeight || actualWidth > maxWidth){
                if(imgRatio < maxRatio){
                    imgRatio = maxHeight / actualHeight;
                    actualWidth = imgRatio * actualWidth;
                    actualHeight = maxHeight;
                }
                else if(imgRatio > maxRatio){
                    imgRatio = maxWidth / actualWidth;
                    actualHeight = imgRatio * actualHeight;
                    actualWidth = maxWidth;
                }
                else{
                    actualHeight = maxHeight;
                    actualWidth = maxWidth;
                    compressionQuality = 1;
                }
            }
            let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
            UIGraphicsBeginImageContext(rect.size);
            imageToBeHandled.draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if let imgData = UIImageJPEGRepresentation(img!, compressionQuality) {
                if imgData.count > expectedSizeBytes {
                    if compressionQuality > minimalCompressRate {
                        compressionQuality -= 0.1
                    } else {
                        maxHeight = maxHeight * 0.9
                        maxWidth = maxWidth * 0.9
                    }
                }
                imageData = imgData
            }
        }
        completion(UIImage(data: imageData)!, compressionQuality)
    }
}

extension NewProjectViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        if(NewProjectViewController.selected[section] == "0" ){
            NewProjectViewController.selected[section] = "1"
        }else if(NewProjectViewController.selected[section] == "1"){
            NewProjectViewController.selected[section] = "0"
        }
        header.setCollapsed(NewProjectViewController.selected[section] == "1")
        //tableview.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        //tableView(UITableView, didSelectRowAt: IndexPath)
        TABLEVIEW.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
extension NewProjectViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if(textField.tag>999){
            if(newText == ""){
                NewProjectViewController.TLRBText[(textField.tag/1000)-1] = "NULL"
            }
            NewProjectViewController.TLRBText[(textField.tag/1000)-1] = newText
        }
        return true
    }
}

