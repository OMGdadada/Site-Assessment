//
//  ProjectResultViewController.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/8/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

let projectResultHeadView:String = "ProjectResultHeadView"

class ProjectResultViewController: UIViewController {
    typealias SaveResultBlock = (() -> Void)
    @IBOutlet weak var saveItem: UIBarButtonItem!
    
    lazy var dataSoure:NSMutableArray = NSMutableArray.init() // 数据源
    var prejectID:String? = ""
    
    var saveResultBlock:SaveResultBlock?
    
    var count:Int = 0 //  未答题num
    ///  查看问卷 1 new 问卷跳转  0 历史问卷跳转
    var isHistory:Bool = false 
    
    var selectProjects:Array<Any> = Array<Any>(repeating: "NULL", count: 59) as! [String] 
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWithData()
        
        fetchWithSelectData()
        
        congifureSubView()
        
    }
    
    @IBAction func cannel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        if count > 0 {
            self.dismiss(animated: true, completion: nil)
        }else{
            if saveResultBlock != nil{
                saveResultBlock!()
            } 
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:  初始化配置

extension ProjectResultViewController
{
    fileprivate func congifureSubView() {
        //隐藏保存item
        if isHistory {
            saveItem.title = nil;
        }
        //初始化
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // 注册head
        tableView.register(UINib.init(nibName: projectResultHeadView, bundle: nil), forHeaderFooterViewReuseIdentifier: projectResultHeadView)
    }
}

// MARK: UITableViewDataSource/Delegate

extension  ProjectResultViewController : UITableViewDataSource , UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataSoure.count > 0 {
            let model:SiteRootModel = dataSoure[5] as! SiteRootModel
            let one:QuestionModel = model.questionList[0]
            if one.defaultValue == "Incomplete" {
                return dataSoure.count - 1
            }
        }
        return dataSoure.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model:SiteRootModel  = dataSoure[section] as! SiteRootModel
        return model.questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectResultTableViewCell", for: indexPath) as! ProjectResultTableViewCell
        let model: SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let questions:NSArray = model.questionList! as NSArray
        cell.question = questions[indexPath.row] as? QuestionModel;
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        let model: SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let questions:QuestionModel = model.questionList[indexPath.row]
        if(questions.isNoShow){
            switch indexPath.section {
            case 0:
                break
            case 1:
                let five:QuestionModel = model.questionList[5]
                let eight:QuestionModel = model.questionList[8]
                let oneone:QuestionModel = model.questionList[11]
                if five.defaultValue == "No" || five.defaultValue == "Incomplete" {
                    if indexPath.row == 6 ||  indexPath.row == 7 {
                        return 0
                    } 
                }
                if eight.defaultValue == "No" || eight.defaultValue == "Incomplete" {
                    if indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 15 || indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19 || indexPath.row == 20 || indexPath.row == 21  {
                        return 0
                    }
                    
                }
                if oneone.defaultValue == "No" || oneone.defaultValue == "Incomplete"  {
                    if indexPath.row == 12  {
                        return 0
                    }
                }
                break
            case 2:
                let three:QuestionModel = model.questionList[3]
                if three.defaultValue == "No" || three.defaultValue == "Incomplete" {
                    if indexPath.row == 4 {
                        return 0 
                    }
                }
                break
            case 4:
                let four:QuestionModel = model.questionList[4]
                if four.defaultValue == "No" || four.defaultValue == "Incomplete" {
                    if indexPath.row == 5 {
                        return 0 
                    }
                }
                break
            default:break
            }
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        let header:ProjectResultHeadView = tableView.dequeueReusableHeaderFooterView(withIdentifier: projectResultHeadView) as! ProjectResultHeadView
        header.backgroundColor = UIColor.white
        header.headTitle.text = model.heading
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: 获取数据

extension ProjectResultViewController
{
    // 获取问卷数据
    fileprivate func fetchWithData() {
        let plistpath = Bundle.main.path(forResource: "QuestionsList", ofType: "plist")
        let arr:NSArray = NSArray(contentsOfFile: plistpath!)!
        dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: arr)
        tableView.reloadData()
    }
    
    // 获取选择数据
    fileprivate func fetchWithSelectData()
    {
        var ProjectInformation :NSMutableDictionary
        ProjectInformation = NSMutableDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(prejectID ?? "").plist")!
        let projects:NSDictionary = ProjectInformation["Answer"] as! NSDictionary
        for i  in 0..<dataSoure.count {
            let  model:SiteRootModel = dataSoure[i] as! SiteRootModel
            for j in 0..<model.questionList.count {
                let question:QuestionModel = model.questionList[j]
                switch i {
                case 0:
                    switch j {
                    case 0:
                        if (projects["sa_shingleMaterial"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_shingleMaterial"] as! String 
                        }
                        break
                    case 1:
                        if (projects["sa_missingShingles"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_missingShingles"] as! String 
                        }
                        break
                    case 2:
                        if (projects["sa_missingRidgeCap"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_missingRidgeCap"] as! String 
                        }
                        break
                    case 3:
                        if (projects["sa_curvedPlywood"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_curvedPlywood"] as! String 
                        }
                        break
                    case 4:
                        if (projects["sa_overallRoofCondition"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_overallRoofCondition"] as! String 
                        }
                        
                        break
                    case 5:
                        if (projects["sa_full3DSiteImaging"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_full3DSiteImaging"] as! String 
                        }
                        break
                    case 6:
                        if (projects["sa_shinglePhotoCloseUp"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    case 7:
                        if (projects["sa_shinglePhotoTopView"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    case 8:
                        if (projects["sa_shinglePhotoBackView"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    default:
                        break
                    }
                    break
                case 1:
                    
                    switch j {
                    case 0:
                        if (projects["sa_meterLocation"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_meterLocation"] as! String
                        }
                        break
                    case 1:
                        if (projects["sa_connectionType"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_connectionType"] as! String
                        }
                        break
                    case 2:
                        if (projects["sa_exteriorWallMaterial"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_exteriorWallMaterial"] as! String
                        }
                        
                        break
                    case 3:
                        if (projects["sa_meterHeight"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_meterHeight"] as! String
                        }
                        
                        break
                    case 4:
                        if (projects["sa_gasMeterLocation"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_gasMeterLocation"] as! String
                        }
                        break
                    case 5:
                        if (projects["sa_meterObstruction"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_meterObstruction"] as! String
                        }
                        break
                    case 6:
                        if (projects["sa_obstructionType1"] as! String == "" ) {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_meterObstruction"] as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_obstructionType1"] as! String
                        }
                        break
                    case 7:
                        if (projects["sa_obstructionDistance"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_meterObstruction"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_obstructionDistance"] as! String
                        }
                        
                        break
                    case 8:
                        if (projects["sa_trenchingRequired"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_trenchingRequired"] as! String
                        }
                        
                        break
                    case 9:
                        if (projects["sa_trenchingOverDriveway"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_trenchingOverDriveway"] as! String
                        }
                        
                        break
                    case 10:
                        if (projects["sa_trenchingMaterial"] as! String == "") {
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                            question.defaultValue = "Incomplete"
                        }else{
                            question.defaultValue = projects["sa_trenchingMaterial"] as! String
                        }
                        
                        break
                    case 11:
                        if (projects["sa_trenchingObstructions"] as! String == "") {
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                            question.defaultValue = "Incomplete"
                        }else{
                            question.defaultValue = projects["sa_trenchingObstructions"] as! String
                        }
                        break
                    case 12:
                        if (projects["sa_trenchingObstructionType"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" && projects["sa_trenchingObstructions"]  as! String == "YES"{
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_trenchingObstructionType"] as! String
                        }
                        
                        break
                    case 13:
                        if (projects["sa_trenchingDistance"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_trenchingDistance"] as! String
                        }
                        
                        break
                    case 14:
                        if (projects["sa_meterPhotoCloseUp"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        
                        break
                    case 15:
                        if (projects["sa_meterPhotoWideAngle"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        
                        break
                    case 16:
                        if (projects["sa_meterHeightMeasurementPhoto"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        
                        break
                    case 17:
                        if (projects["sa_meterSurroundingAreaPhoto"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    case 18:
                        if (projects["sa_meterObstructionPhoto"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    case 19:
                        if (projects["sa_teckCableRouteReferencePhoto"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    case 20:
                        if (projects["sa_trenchingRouteAerialPhoto"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    case 21:
                        if (projects["sa_trenchingRouteGroundPhoto"] as! String == "") {
                            if  projects["sa_trenchingRequired"]  as! String == "Yes" {
                                count = count + 1
                            }
                            question.defaultValue = "Incomplete"
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                    default:
                        break
                    }
                    break
                case 2:
                    switch j {
                    case 0:
                        if (projects["sa_breakerPanelAmp"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_breakerPanelAmp"] as! String
                        }
                        
                        break
                    case 1:
                        if (projects["sa_breakerPanelLocation"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_breakerPanelLocation"] as! String
                        }
                        
                        break
                    case 2:
                        if (projects["sa_availableBreakerSlot"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_availableBreakerSlot"] as! String
                        }
                        break
                    case 3:
                        if (projects["sa_breakerPanelObstruction"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_breakerPanelObstruction"] as! String
                        }
                        
                        break
                    case 4:
                        if (projects["sa_obstructionType"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_breakerPanelObstruction"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_obstructionType"] as! String
                        }
                        
                        break
                    case 5:
                        if (projects["sa_panelDistance"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            let value:String = projects["sa_panelDistance"] as! String
                            if value != "NULL" {
                                let strs:[String] = (value.components(separatedBy: ","))
                                question.defaultValue = "Up:\(strs[1]),Down:\(strs[3]), Left:\(strs[0]),Right:\(strs[3])"
                            }
                        }
                        
                        break
                    case 6:
                        if (projects["sa_mainBreakerPanelPhotoCloseUp"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        
                        break
                    case 7:
                        if (projects["sa_mainBreakerPanelPhotoWideAngle"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        
                        break
                    case 8:
                        if (projects["sa_mainBreakerPanelPhotoInterior"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        
                        break
                    case 9:
                        if (projects["sa_mainBreakerPanelPhoto360Degree"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = "Photo Uploaded"
                        }
                        break
                        
                    default:
                        break
                    }
                    break
                case 3:
                    switch j {
                    case 0:
                        if (projects["sa_locationElectricalMeter"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_locationElectricalMeter"] as! String
                        }
                        
                        break
                    case 1:
                        if (projects["sa_locationGasMeter"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_locationGasMeter"] as! String
                        }
                        
                        break
                    case 2:
                        if (projects["sa_locationObstruction"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_locationObstruction"] as! String
                        }
                        
                        break
                    case 3:
                        if (projects["sa_locationMainBreakerPanel"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_locationMainBreakerPanel"] as! String
                        }
                        
                        break
                    case 4:
                        if (projects["sa_distanceElectricalMeterToFrontCornerOfHouse"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_distanceElectricalMeterToFrontCornerOfHouse"] as! String
                        }
                        
                        break
                    case 5:
                        if (projects["sa_distanceElectricalMeterToGasMeter"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_distanceElectricalMeterToGasMeter"] as! String
                        }
                        
                        break
                    case 6:
                        if (projects["sa_distanceElectricalMeterToYardDoor"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_distanceElectricalMeterToYardDoor"] as! String
                        }
                        
                        break
                    case 7:
                        if (projects["sa_distanceElectricalMeterToObstruction"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_distanceElectricalMeterToObstruction"] as! String
                        }
                        
                        break
                    default:
                        break
                    }
                    break
                case 4:
                    switch j {
                    case 0:
                        if (projects["sa_roofSheathing"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_roofSheathing"] as! String
                        }
                        
                        break
                    case 1:
                        if (projects["sa_signsOfMold"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_signsOfMold"] as! String
                        }
                        
                        break
                    case 2:
                        if (projects["sa_signsOfWaterLeakage"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_signsOfWaterLeakage"] as! String
                        }
                        
                        break
                    case 3:
                        if (projects["sa_waterLeakageType"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_waterLeakageType"] as! String
                        }
                        
                        break
                    case 4:
                        if (projects["sa_signsOfDamage"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_signsOfDamage"] as! String
                        }
                        
                        break
                    case 5:
                        if (projects["sa_typeOfDamage"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            if  projects["sa_signsOfDamage"]  as! String == "Yes" {
                                count = count + 1
                            }
                        }else{
                            question.defaultValue = projects["sa_typeOfDamage"] as! String
                        }
                        
                        break
                    case 6:
                        if (projects["sa_trussSpacing"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_trussSpacing"] as! String
                        }
                        
                        break
                    case 7:
                        if (projects["sa_trussMemberSize"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_trussMemberSize"] as! String
                        }
                        
                        break
                    case 8:
                        if (projects["sa_trussType"] as! String == "") {
                            question.defaultValue = "Incomplete"
                            count = count + 1
                        }else{
                            question.defaultValue = projects["sa_trussType"] as! String
                        }
                        
                        break
                    default:
                        break
                    }
                    break
                case 5:
                    if (projects["sa_notes"] as! String == "") {
                        question.defaultValue = "Incomplete"
                    }else{
                        question.defaultValue = projects["sa_notes"] as! String
                    }
                    break
                default :
                    break
                }
            }
        }
        if  count > 0 {
            saveItem.title = "Missing(\(count))"
            saveItem.tintColor = UIColor.red 
        }
        
        tableView.reloadData()
    }
}

