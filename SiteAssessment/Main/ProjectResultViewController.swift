//
//  ProjectResultViewController.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/8/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import Alamofire

let projectResultHeadView:String = "ProjectResultHeadView"

class ProjectResultViewController: UIViewController {
    typealias SaveResultBlock = (() -> Void)
    @IBOutlet weak var saveItem: UIBarButtonItem!
    let manager = NetworkReachabilityManager()
    var NetWork = "不可用的网络(未连接)"
    
    @IBOutlet weak var updateItem: UIButton!
    var dataSoure:NSMutableArray = NSMutableArray.init() // 数据源
    var prejectID:String? = ""
    var isUpdate:Bool = false;
    var imgDic:[String:Any] = [:]
    
    var saveResultBlock:SaveResultBlock?
    
    var count:Int = 0 //  未答题num
    ///  查看问卷 1 new 问卷跳转  0 历史问卷跳转
    var isHistory:Bool = false 
        
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        fetchWithSelectData()
        
        congifureSubView()
        
    }
    // 上传
    @IBAction func update(_ sender: Any) {
        if count == 0 {
            saveQuestion()
            let model:HistoyDto = HistoyDto()
            model.uploaded = false
            model.Datauploaded = false
            model.projectID = self.prejectID
            var alertText = ""
            if(self.NetWork == "wifi的网络" || self.NetWork == "2G,3G,4G...的网络"){
                UploadProject.Uploadshared.UploadProjectdata(self.prejectID! ,model: model)
                alertText = "Upload And Save data Success !"
                if(self.NetWork == "wifi的网络"){
                    let projectinformation = ProjectInformation()
                    projectinformation.setValue(self.prejectID, forKey: "ProjectName")
                    ProjectListViewController.ProjectInformationList.addEntries(from: [self.prejectID:projectinformation])
                    UploadProject.Uploadshared.UploadProjectToGoogleDrive(self.prejectID!, model: model)
                    
                    alertText = "Upload And Save data And Img Success !"
                }
                
            }else{
                alertText = "Only Save Success !"
            }
            if (self.saveResultBlock != nil)  {
                self.saveResultBlock!()
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
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cannel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if (self.saveResultBlock != nil)  {
            self.saveResultBlock!()
        }
        saveQuestion()
        
    }
    
    fileprivate func saveQuestion() {
        var num:Int = 0
        if count == 0 {
            num = 2
        }else{
            num = 3
        }
        let PorjectList = [
            "ststus":num,
            "uploaded":false,
            "Datauploaded":false,
            "Img":imgDic,
            "questionList":SiteRootModel.mj_keyValuesArray(withObjectArray: dataSoure as? [Any])
            ] as [String : Any]
        if prejectID!.contains(".plist") {
            prejectID = prejectID?.replacingOccurrences(of: ".plist", with: "")
        }
        let filePath:String = NSHomeDirectory() + "/Documents/\(prejectID!).plist"
        NSDictionary(dictionary: PorjectList).write(toFile: filePath, atomically: true)
        print(filePath)
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
        //初始化
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
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
            if one.defaultValue == "" {
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
                if five.defaultValue == "No" || five.defaultValue == "" {
                    if indexPath.row == 6 ||  indexPath.row == 7 {
                        return 0
                    } 
                }
                if eight.defaultValue == "No" || eight.defaultValue == "" {
                    if indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 15 || indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19 || indexPath.row == 20 || indexPath.row == 21  {
                        return 0
                    }
                    
                }
                if oneone.defaultValue == "No" || oneone.defaultValue == ""  {
                    if indexPath.row == 12  {
                        return 0
                    }
                }
                break
            case 2:
                let three:QuestionModel = model.questionList[3]
                if three.defaultValue == "No" || three.defaultValue == "" {
                    if indexPath.row == 4 {
                        return 0 
                    }
                }
                break
            case 4:
                let four:QuestionModel = model.questionList[4]
                if four.defaultValue == "No" || four.defaultValue == "" {
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

    
    // 获取选择数据
    fileprivate func fetchWithSelectData()
    {

        if isHistory {
            var ProjectInformation :NSDictionary
            ProjectInformation = NSDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(prejectID ?? "")")!
            dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: ProjectInformation["questionList"])
            tableView.reloadData()
            return
        }
        
        for i  in 0..<dataSoure.count {
            let  model:SiteRootModel = dataSoure[i] as! SiteRootModel
            for j in 0..<model.questionList.count {
                let question:QuestionModel = model.questionList[j]
                switch i {
                case 0:
                    if (question.defaultValue == ""  ) {
                        count = count + 1
                    }
                    break
                case 1:
                    if j == 6 || j == 7 {
                        let model5 = model.questionList[5]
                        if model5.other == "Yes" && question.other == "" {
                            count = count + 1
                        } 
                    }else if j == 9 || j == 10 || j == 11 || j == 12 || j == 13 || j == 14 || j == 15 || j == 16 || j == 17 || j == 18  || j == 19 || j == 20 || j == 21{
                        let model8 = model.questionList[8]
                        if j == 12 {
                            let model11 = model.questionList[11]
                            if model11.other == "Yes" && question.other == ""  {
                                count = count + 1
                            }
                        }else{
                            if model8.other == "Yes" && question.other == "" {
                                count = count + 1
                            }
                        }
                    }else{
                        if (question.other == "" ) {
                            count = count + 1
                        }
                    }
                    break
                case 2:
                    switch j {
                    case 4:
                        let model3 = model.questionList[3]
                        if model3.other == "Yes" && model3.other == ""  {
                            count = count + 1
                        }
                        break
                    case 5:
                        if question.other == "" {
                            count = count + 1
                        }
                        break
                    default:
                        if question.other == ""   {
                            count = count + 1 
                        }
                        break
                    }
                    break
                case 3:
                    if  question.other == ""{
                        count = count + 1
                    }
                    break
                case 4:
                    switch j {
                    case 5:
                        let model4:QuestionModel = model.questionList[4]
                        if model4.other == "Yes" && question.other == "" {
                            count = count + 1
                        }
                        break
                    default:
                        if  question.other == "" {
                            count = count + 1
                        }
                        break
                    }
                    break
                default :
                    break
                }
            }
        }
        if  count > 0 {
            updateItem.setTitle("Missing(\(count))", for: .normal)
           // updateItem.setTitleColor(UIColor.red, for: .normal)
        }
        tableView.reloadData()
    }
}

