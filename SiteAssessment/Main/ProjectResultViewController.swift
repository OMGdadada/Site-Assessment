//
//  ProjectResultViewController.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/8/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

class ProjectResultViewController: UIViewController {
    typealias SaveResultBlock = (() -> Void)
    
    lazy var dataSoure:NSMutableArray = NSMutableArray.init() // 数据源
    var prejectID:String? = ""
    
    var saveResultBlock:SaveResultBlock?
    
    
    var isHistory:Bool = false // 查看问卷 1 new 问卷跳转  0 历史问卷跳转
    
    var selectProjects:Array<Any> = Array<Any>(repeating: "NULL", count: 59) as! [String] 
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWithData()
        
        fetchWithSelectData()
        
        congifureSubView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cannel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        if saveResultBlock != nil{
            saveResultBlock!()
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
        //
        if self.isHistory {
            self.navigationItem.rightBarButtonItem = nil;
        }
        //
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        self.tableView.tableFooterView = UIView()
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
                        question.defaultValue = projects["sa_shingleMaterial"] as! String
                        break
                    case 1:
                        question.defaultValue = projects["sa_missingShingles"] as! String
                        break
                    case 2:
                        question.defaultValue = projects["sa_missingRidgeCap"] as! String
                        break
                    case 3:
                        question.defaultValue = projects["sa_curvedPlywood"] as! String
                        break
                    case 4:
                        question.defaultValue = projects["sa_overallRoofCondition"] as! String
                        break
                    case 5:
                        question.defaultValue = projects["sa_full3DSiteImaging"] as! String
                        break
                    case 6:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 7:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 8:
                        question.defaultValue = "Photo Uploaded"
                        break
                    default:
                        break
                    }
                    break
                case 1:
                    switch j {
                    case 0:
                        question.defaultValue = projects["sa_meterLocation"] as! String
                        break
                    case 1:
                        question.defaultValue = projects["sa_connectionType"] as! String
                        break
                    case 2:
                        question.defaultValue = projects["sa_exteriorWallMaterial"] as! String
                        break
                    case 3:
                        question.defaultValue = projects["sa_meterHeight"] as! String
                        break
                    case 4:
                        question.defaultValue = projects["sa_gasMeterLocation"] as! String
                        break
                    case 5:
                        question.defaultValue = projects["sa_meterObstruction"] as! String
                        break
                    case 6:
                        question.defaultValue = projects["sa_obstructionType1"] as! String
                        break
                    case 7:
                        question.defaultValue = projects["sa_obstructionDistance"] as! String
                        break
                    case 8:
                        question.defaultValue = projects["sa_trenchingRequired"] as! String
                        break
                    case 9:
                        question.defaultValue = projects["sa_trenchingOverDriveway"] as! String
                        break
                    case 10:
                        question.defaultValue = projects["sa_trenchingMaterial"] as! String
                        break
                    case 11:
                        question.defaultValue = projects["sa_trenchingObstructions"] as! String
                        break
                    case 12:
                        question.defaultValue = projects["sa_trenchingObstructionType"] as! String
                        break
                    case 13:
                        question.defaultValue = projects["sa_trenchingDistance"] as! String
                        break
                    case 14:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 15:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 16:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 17:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 18:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 19:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 20:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 21:
                        question.defaultValue = "Photo Uploaded"
                        break
                    default:
                        break
                    }
                    break
                 case 2:
                    switch j {
                    case 0:
                        question.defaultValue = projects["sa_breakerPanelAmp"] as! String
                        break
                    case 1:
                        question.defaultValue = projects["sa_breakerPanelLocation"] as! String
                        break
                    case 2:
                        question.defaultValue = projects["sa_availableBreakerSlot"] as! String
                        break
                    case 3:
                        question.defaultValue = projects["sa_breakerPanelObstruction"] as! String
                        break
                    case 4:
                        question.defaultValue = projects["sa_obstructionType"] as! String
                        break
                    case 5:
                        let value:String = projects["sa_panelDistance"] as! String
                        if value != "NULL" {
                            let strs:[String] = (value.components(separatedBy: ","))
                            question.defaultValue = "Up:\(strs[0])\n Down:\(strs[1])\n Left:\(strs[2]) \n Right:\(strs[3])"
                        }
                        break
                    case 6:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 7:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 8:
                        question.defaultValue = "Photo Uploaded"
                        break
                    case 9:
                        question.defaultValue = "Photo Uploaded"
                        break
                  
                    default:
                        break
                    }
                    break
                case 3:
                    switch j {
                    case 0:
                        question.defaultValue = projects["sa_locationElectricalMeter"] as! String
                        break
                    case 1:
                        question.defaultValue = projects["sa_locationGasMeter"] as! String
                        break
                    case 2:
                        question.defaultValue = projects["sa_locationObstruction"] as! String
                        break
                    case 3:
                        question.defaultValue = projects["sa_locationMainBreakerPanel"] as! String
                        break
                    case 4:
                        question.defaultValue = projects["sa_distanceElectricalMeterToFrontCornerOfHouse"] as! String
                        break
                    case 5:
                        question.defaultValue = projects["sa_distanceElectricalMeterToGasMeter"] as! String
                        break
                    case 6:
                        question.defaultValue = projects["sa_distanceElectricalMeterToYardDoor"] as! String
                        break
                    case 7:
                       question.defaultValue = projects["sa_distanceElectricalMeterToObstruction"] as! String
                        break
                    default:
                        break
                    }
                    break
                case 4:
                    switch j {
                    case 0:
                        question.defaultValue = projects["sa_roofSheathing"] as! String
                        break
                    case 1:
                        question.defaultValue = projects["sa_signsOfMold"] as! String
                        break
                    case 2:
                        question.defaultValue = projects["sa_signsOfWaterLeakage"] as! String
                        break
                    case 3:
                        question.defaultValue = projects["sa_waterLeakageType"] as! String
                        break
                    case 4:
                        question.defaultValue = projects["sa_signsOfDamage"] as! String
                        break
                    case 5:
                        question.defaultValue = projects["sa_typeOfDamage"] as! String
                        break
                    case 6:
                        question.defaultValue = projects["sa_trussSpacing"] as! String
                        break
                    case 7:
                        question.defaultValue = projects["sa_trussMemberSize"] as! String
                        break
                    case 8:
                        question.defaultValue = projects["sa_trussType"] as! String
                        break
                    default:
                        break
                    }
                    break
                default :
                    break
                    
                }
            }
        }
        tableView.reloadData()
    }
}


// MARK: UITableViewDataSource/Delegate

extension  ProjectResultViewController : UITableViewDataSource , UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSoure.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model:SiteRootModel  = dataSoure[section] as! SiteRootModel
        if model.isSelect {
            return model.questionList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectResultTableViewCell", for: indexPath) as! ProjectResultTableViewCell
        let model: SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let questions:NSArray = model.questionList! as NSArray
        cell.question = questions[indexPath.row] as? QuestionModel;
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = model.heading
        header.arrowLabel.text = ">"
        header.setCollapsed(model.isSelect == true)
        header.section = section
        header.delegate = self as CollapsibleTableViewHeaderDelegate
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension ProjectResultViewController : CollapsibleTableViewHeaderDelegate
{
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let model : SiteRootModel = dataSoure[section] as! SiteRootModel
        model.isSelect = !model.isSelect
        header.setCollapsed(model.isSelect == true)
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

