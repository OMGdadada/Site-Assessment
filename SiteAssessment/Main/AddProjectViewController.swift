//
//  AddProjectViewController.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/19.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import Alamofire

let KTQuestionTableViewCell = "TQuestionTableViewCell"

let kTDiagramTableViewCell = "TDiagramTableViewCell"
let kCheckBoxTableViewCell = "CheckBoxTableViewCell"
let header = "header"

class AddProjectViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    //
    var isIncomple:Bool = false
    var Project_Id:String!    // 地址
    var Project_Id_id:String! // id
    var dataSoure = NSMutableArray()
    var currentIndexpath:IndexPath?
    var imgIndexPath:IndexPath? // 照片选中indexpath
    
    var Pickerimage_Nums = 0
    var Pickerimages : [String] = NSMutableArray() as! [String]
    var MeterPhotoCheckList:NSMutableArray = []
    var MeterPhotoCheckList1:NSMutableArray = []
    var MeterPhotoCheckList2:NSMutableArray = []
    var MainBreakerPhotoCheckList:NSMutableArray = []
    var TrussType:NSMutableArray = []
    var TrussType1:NSMutableArray = []
    

    var imagePicker:UIImagePickerController = UIImagePickerController()
    var imageManager:PHCachingImageManager!
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWithData()
        congifureSubView()
        self.resetCachedAssets()
    }
    
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    // 取消
    @IBAction func cannel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // 保存
    @IBAction func save(_ sender: Any) {
        let storybard:UIStoryboard = UIStoryboard.init(name:"Main", bundle: nil)
        let vc:ProjectResultViewController = storybard.instantiateViewController(withIdentifier: "ProjectResultViewController") as! ProjectResultViewController
        vc.prejectID = Project_Id
        vc.Project_Id_id = Project_Id_id
        vc.dataSoure = dataSoure
        var dic:[String : Any] = [:]

        let Meterarrs :NSMutableArray = []
        Meterarrs.addingObjects(from: MeterPhotoCheckList.copy() as! [Any])
        Meterarrs.addingObjects(from: MeterPhotoCheckList1.copy()  as! [Any])
        Meterarrs.addingObjects(from: MeterPhotoCheckList2.copy()  as! [Any])
        
        dic["MeterPhotoCheckList"]       = Meterarrs
        dic["MainBreakerPhotoCheckList"] = MainBreakerPhotoCheckList
        
        let types :NSMutableArray = []
        types.addingObjects(from: TrussType.copy() as! [Any])
        types.addingObjects(from:TrussType1.copy() as! [Any])
        dic["TrussType"]                 = types
        vc.imgDic = dic
        vc.saveResultBlock = { 
            self.presentingViewController!.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: 初始化设置
extension AddProjectViewController
{
    fileprivate func congifureSubView() {
        
        //
        self.imageManager = PHCachingImageManager()
        
        //
        
        tableView.register(CollapsibleTableViewHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: header)
        
        tableView.register(TCheckBoxTableViewCell.classForCoder(), forCellReuseIdentifier: kCheckBoxTableViewCell)
        
        tableView.register(TDiagramTableViewCell.classForCoder(), forCellReuseIdentifier: kTDiagramTableViewCell)
        
        tableView.register(TQuestionTableViewCell.classForCoder(), forCellReuseIdentifier: kTDiagramTableViewCell)
    }
}
// MARK: 获取问卷
extension AddProjectViewController
{
    fileprivate func loadWithData() {
        if isIncomple {
            var ProjectInformation :NSDictionary
            ProjectInformation = NSDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(Project_Id ?? "").plist")!
            dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: ProjectInformation["questionList"])
            for i  in 0..<dataSoure.count {
                let  model:SiteRootModel = dataSoure[i] as! SiteRootModel
                model.isSelect = false
                for j in 0..<model.questionList.count {
                    let question:QuestionModel = model.questionList[j]
                    question.isShow = false
                }
            }
            let ImgDic:[String:Any] = ProjectInformation["Img"] as! [String :Any];
            MeterPhotoCheckList.add(ImgDic["MeterPhotoCheckList"] as Any)
            MainBreakerPhotoCheckList.add(ImgDic["MainBreakerPhotoCheckList"] as Any)
            TrussType.add(ImgDic["TrussType"] as Any)            
            tableView.reloadData()
        }else{
            let plistpath = Bundle.main.path(forResource: "QuestionsList", ofType: "plist")
            let arr:NSArray = NSArray(contentsOfFile: plistpath!)!
            dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: arr)
            tableView.reloadData() 
        }
        
    }
}

extension AddProjectViewController : UITableViewDelegate , UITableViewDataSource
{
    func setExtraCellLineHidden(tableview:UITableView){
        let viw = UIView()
        viw.backgroundColor = UIColor.clear
        tableview.tableFooterView = viw
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSoure.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model:SiteRootModel  = dataSoure[section] as! SiteRootModel
        if !model.isSelect {
            return 0;
        }
        return model.questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
       let modle:QuestionModel = dto.questionList[indexPath.row]
        if  (modle.item == "37"){
            var cell:TDiagramTableViewCell? = tableView.dequeueReusableCell(withIdentifier: kTDiagramTableViewCell) as? TDiagramTableViewCell
            if( cell != nil ){
                for cell in cell!.contentView.subviews {
                    cell.removeFromSuperview()
                }
            }
            cell = TDiagramTableViewCell(style: .default, reuseIdentifier: kTDiagramTableViewCell)
            
            cell?.refresh(model: modle, indexpath: indexPath)
            cell?.delageta = self as TDiagramTableViewCellDelagate
            modle.height = 500
            return cell!
        }else if(modle.item == "24" || modle.item == "25" || modle.item == "26" || modle.item == "27" || modle.item == "28" || modle.item == "29" || modle.item == "30" || modle.item == "31" ||  modle.item == "38" || modle.item == "39" || modle.item == "40" || modle.item == "41" || modle.item == "59" || modle.item == "60" || modle.item == "61" ){
            var hs:Float = 0
            var cell:TQuestionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: KTQuestionTableViewCell) as? TQuestionTableViewCell
            if( cell != nil ){
                for cell in cell!.contentView.subviews {
                    cell.removeFromSuperview()
                }
            }
            if(modle.item == "6" || modle.item == "24" || modle.item == "38"){
                hs = 70
            }
            
            if modle.images != nil {
               modle.height = Float(300 * (modle.images.count / 3 + 1)) + hs
            }else{
                modle.height = Float(300 + hs)
            }
            
            cell = TQuestionTableViewCell(style: .default, reuseIdentifier: KTQuestionTableViewCell)
            cell?.setinitlabel(model: modle)
            cell?.setinitIMage(model: modle)
            cell?.delegate = self as TQuestionTableViewCellDelagate
            cell?.layer.masksToBounds = true
            return cell!
        }else{
            var cell:TCheckBoxTableViewCell? = tableView.dequeueReusableCell(withIdentifier: kCheckBoxTableViewCell) as? TCheckBoxTableViewCell
            if( cell != nil ){
                for cell in cell!.contentView.subviews {
                    cell.removeFromSuperview()
                }
            }
            cell = TCheckBoxTableViewCell(style: .default, reuseIdentifier: kCheckBoxTableViewCell)
            cell?.delageta = self as TCheckBoxTableViewCellDelagate
            if modle.item == "62" {
                modle.height = 300
            }else{
               modle.height = Float(((modle.option.count-1)/2)*60+80) 
            }
            
            cell?.setTabelCheckbox(model: dto.questionList[indexPath.row])
            cell?.layer.masksToBounds = true
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sdwsa :CGFloat = 0
        
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if modle.isShow {
            if(modle.item == "6" || modle.item == "24" || modle.item == "38" || modle.item == "42" ){
                sdwsa = 70
            }else if(modle.item == "58"){
                sdwsa = 370
            }
            if(modle.defaultValue.contains("Other")){
                sdwsa = sdwsa + 70 + CGFloat(modle.height) + 300
            }else{
                sdwsa = sdwsa + 70 + CGFloat(modle.height)
            }
        }else{
            let Question_Item = Int(modle.item)!-1
            if(Question_Item == 5 || Question_Item == 23 || Question_Item == 37 || Question_Item == 41){
                sdwsa = 70
            } 
            if(Question_Item == 61){
                sdwsa = 370
                sdwsa = sdwsa + 70 + CGFloat(modle.height)
                return sdwsa
            }
            if modle.isNoShow {
                print("\(Question_Item)")
                switch Question_Item {
                case 15:
                    let  model14 = dto.questionList[5]
                    if(model14.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 16:
                    let  model14 = dto.questionList[5]
                    if(model14.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 18:
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 19:
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 20    :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 21 :
                    let model20 = dto.questionList[11]
                    if(model20.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 22 :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 27 :
                    let model14 = dto.questionList[5]
                    if(model14.other == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                       
                    }
                    break
                case 29 :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 30 :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 35 :
                    let model34 = dto.questionList[indexPath.row - 1]
                    if(model34.other == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                        
                    }
                    break
                case 52 :
                    let model52 = dto.questionList[indexPath.row - 1 ]
                    if(model52.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 54 :
                    let model53 = dto.questionList[indexPath.row - 1 ]
                    if(model53.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
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
    
    // 
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var sdwsa :CGFloat = 0
        
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if modle.isShow {
            if(modle.item == "6" || modle.item == "24" || modle.item == "38" || modle.item == "42" ){
                sdwsa = 70
            }else if(modle.item == "58"){
                sdwsa = 370
            }
            if(modle.defaultValue.contains("Other")){
                sdwsa = sdwsa + 70 + CGFloat(modle.height) + 300
            }else{
                sdwsa = sdwsa + 70 + CGFloat(modle.height)
            }
        }else{
            let Question_Item = Int(modle.item)!-1
            if(Question_Item == 5 || Question_Item == 23 || Question_Item == 37 || Question_Item == 41){
                sdwsa = 70
            } 
            if(Question_Item == 61){
                sdwsa = 370
                sdwsa = sdwsa + 70 + CGFloat(modle.height)
                return sdwsa
            }
            if modle.isNoShow {
                print("\(Question_Item)")
                switch Question_Item {
                case 15:
                    let  model14 = dto.questionList[5]
                    if(model14.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 16:
                    let  model14 = dto.questionList[5]
                    if(model14.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 18:
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 19:
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 20    :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 21 :
                    let model20 = dto.questionList[11]
                    if(model20.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 22 :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 27 :
                    let model14 = dto.questionList[5]
                    if(model14.other == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                        
                    }
                    break
                case 29 :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 30 :
                    let model17 = dto.questionList[8]
                    if(model17.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 35 :
                    let model34 = dto.questionList[indexPath.row - 1]
                    if(model34.other == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                        
                    }
                    break
                case 52 :
                    let model51 = dto.questionList[indexPath.row - 1 ]
                    if(model51.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
                        sdwsa = 0
                    }
                    break
                case 54 :
                    let model53 = dto.questionList[indexPath.row - 1 ]
                    if(model53.other == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.other = ""
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
    // 组头和组尾
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = model.heading
        header.arrowLabel.text = ">"
        header.setCollapsed(model.isSelect)
        header.section = section
        header.delegate = self as CollapsibleTableViewHeaderDelegate
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击展开或收缩
        print(indexPath.section)
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        modle.isShow = !modle.isShow
        //
        if self.currentIndexpath != nil && indexPath != self.currentIndexpath{
            //刷新cell
            let site:SiteRootModel = dataSoure[currentIndexpath!.section] as! SiteRootModel
            let question:QuestionModel = site.questionList[currentIndexpath!.row]
            if question.isShow {
                question.isShow = !question.isShow
            }
            tableView.reloadRows(at: [indexPath , currentIndexpath!], with: .automatic)
            self.currentIndexpath = indexPath
        }else{
            //刷新cell
            tableView.reloadRows(at: [indexPath], with: .automatic)
            self.currentIndexpath = indexPath
        }
    }
}
//
extension AddProjectViewController : TCheckBoxTableViewCellDelagate
{
    // 值改变
    func textFiledValue(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if modle.item == "36" {
           
           modle.textStr = textFiedstr ?? ""
        }else{
           modle.other = textFiedstr 
        }
        
        if textFiedstr == nil || textFiedstr == "" {
            modle.isReply = false
        }else{
            modle.isReply = true
        }
    }
    // 编辑状态改变
    func textFiledChnage(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
    }
    // 点击按钮
    func didClick(cell: TCheckBoxTableViewCell, itemStr: String?, item: UIButton) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if item.tag == 5800 {
            addCamera(indexp: indexPath)
        }else{
            if modle.item == "58" && modle.defaultValue != "Other" {
                modle.images = []
                // 移除文件
                let Manager = FileManager.default
                for fn in TrussType{
                    try! Manager.removeItem(atPath: fn as! String)
                }
                TrussType.removeAllObjects()
            }else if (modle.item == "14" && itemStr == "No"){
                // 移除文件
                let Manager = FileManager.default
                for fn in MeterPhotoCheckList1{
                    try! Manager.removeItem(atPath: fn as! String)
                }
                MeterPhotoCheckList1.removeAllObjects()
            }else if (modle.item == "17" &&  itemStr == "No"){
                // 移除文件
                let Manager = FileManager.default
                for fn in MeterPhotoCheckList2{
                    try! Manager.removeItem(atPath: fn as! String)
                }
                MeterPhotoCheckList2.removeAllObjects()
            }
            
            // 设置多选处理
            if modle.item == "36" {
                if item.isSelected {
                    if itemStr != "Other" {
                        modle.other = "\(modle.other ?? ""),\(itemStr ?? "")"
                    }
                    modle.defaultValue = "\(modle.defaultValue!),\(itemStr ?? "")"
                }else{
                    modle.defaultValue = modle.defaultValue.replacingOccurrences(of: ",\(itemStr ?? "" )", with: "")
                    if itemStr == "Other" {
                        modle.other = modle.defaultValue
                        modle.textStr = ""
                    }else{
                       modle.other = modle.other.replacingOccurrences(of: ",\(itemStr ?? "")", with: "") 
                    }
                }
            }else{
                // 单选处理
                if itemStr == "Other" {
                    if modle.defaultValue == "Other" {
                        return
                    }
                    modle.other = ""
                    modle.defaultValue = itemStr 
                }else{
                    modle.defaultValue = itemStr 
                    modle.other = itemStr
                }  
            }
            
            
            
            if modle.item == "18" {
                tableView.reloadData()
            }else if modle.item == "15"{
                let index6 = IndexPath(item: 6, section: 1)
                let index7 = IndexPath(item: 7, section: 1)
                let index18 = IndexPath(item: 18, section: 1)
                tableView.reloadRows(at: [indexPath , index6,index7,index18], with: .automatic) 
            }else if modle.item == "35"{
                let indexp = IndexPath(item: 4, section: 2)
                tableView.reloadRows(at: [indexPath , indexp], with: .automatic) 
            }else if modle.item == "52"{
                let indexp = IndexPath(item: 3, section: 4)
                tableView.reloadRows(at: [indexPath , indexp], with: .automatic) 
            }else if modle.item == "54"{
               let indexp = IndexPath(item: 5, section: 4)
                tableView.reloadRows(at: [indexPath , indexp], with: .automatic) 
            }else{
               tableView.reloadRows(at: [indexPath], with: .automatic)  
            }
           
        }
    }
}

extension AddProjectViewController : TDiagramTableViewCellDelagate
{
    func diagrmWithValue(textFiedstr: String?, indexPath: IndexPath, textTag: NSInteger) {
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        switch textTag {
        case 1000:
            modle.top = textFiedstr
            break
        case 2000:
            modle.left = textFiedstr
            break
        case 3000:
            modle.right = textFiedstr
            break
        case 4000:
            modle.bottom = textFiedstr
            break
        default: break
        }
        if modle.top == "" || modle.left == "" || modle.right == "" || modle.bottom == "" {
            modle.defaultValue = "No"
            modle.other = ""
        }else{
            modle.isReply = true;
            modle.defaultValue = "Yes"
            modle.other = "\(modle.top!),\(modle.left!),\(modle.bottom!),\(modle.right!)"
        }
    }
    func diagrmWithChange(textFiedstr: String?, indexPath: IndexPath, textTag: NSInteger) {
    }
}

//
extension AddProjectViewController : CollapsibleTableViewHeaderDelegate
{
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        model.isSelect = !model.isSelect
        header.setCollapsed(model.isSelect)
        
        if !model.isSelect && self.currentIndexpath != nil{
            let site:SiteRootModel = dataSoure[currentIndexpath!.section] as! SiteRootModel
            let question:QuestionModel = site.questionList[currentIndexpath!.row]
            if question.isShow {
                question.isShow = !question.isShow
            }
            self.currentIndexpath = nil
        }
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        
    }
}

extension AddProjectViewController : TQuestionTableViewCellDelagate
{
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
    
    func didImage(cell: TQuestionTableViewCell) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        addCamera(indexp: indexPath)
    }
    fileprivate func addCamera(indexp:IndexPath) {
        imgIndexPath = indexp
        Pickerimages.removeAll()
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil)) // 取消按钮
        
        #if targetEnvironment(simulator)
        #else
        controller.addAction(UIAlertAction(title: "拍照选择", style: .default) { action in
            self.selectorSourceType(type: "camera")
        }) // 拍照选择
        #endif
        controller.addAction(UIAlertAction(title: "相册选择", style: .default) { action in
            
            _ = self.presentHGImagePicker(maxSelected:9) { (assets) in
                //结果处理
                //print("共选择了\(assets.count)张图片，分别如下：")
                for asset in assets {
                    //print(asset)
                    self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { (image, nfo) in
                        self.SavePickImage(image!)
                    })
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
        let tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(tempImage, nil, nil, nil)
        }
        SavePickImage(tempImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 当点击图片选择器中的取消按钮时回调
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) // 效果一样的...
        print("取消了")
        
    }
    
    private func SavePickImage(_ tempImage : UIImage){
        
        let dto:SiteRootModel = dataSoure[imgIndexPath!.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[imgIndexPath!.row]
        
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
        if modle.images != nil {
            Pickerimage_Nums = modle.images.count
            Pickerimages = modle.images as! [String]
        }else{
            Pickerimage_Nums = 0
        }
        PickerImage_Name = modle.question
        Pickerimage_Nums = Pickerimage_Nums+1
        Nums = Pickerimage_Nums
        
        if(modle.item == "24" || modle.item == "25" || modle.item == "26" || modle.item == "27" || modle.item == "29" ){
            MeterPhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if ( modle.item == "28"){
            MeterPhotoCheckList1.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if ( modle.item == "30" || modle.item == "31"){
            MeterPhotoCheckList2.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(modle.item == "38" || modle.item == "39" || modle.item == "40" || modle.item == "41"){
            MainBreakerPhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(modle.item == "58"){
            TrussType.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(modle.item == "58" || modle.item == "59" || modle.item == "60" || modle.item == "61"){
            TrussType1.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }
        
        let ImageName = "\(PickerImage_Name)_\(Nums).jpg"
        var persent = 1.0
        if(TempImagelength>5000){
            persent = Double(4500.0 / Double(TempImagelength))
            print(persent)
        }
        if let imageData = UIImageJPEGRepresentation(tempImage, CGFloat(persent)) as NSData? {
            let myDire: String = NSHomeDirectory() + "/Documents/\(Project_Id!)"
            let fileManager = FileManager.default
            try! fileManager.createDirectory(atPath: myDire,
                                             withIntermediateDirectories: true, attributes: nil)
            
            let fullPath = NSHomeDirectory().appending("/Documents/\(Project_Id!)/").appending(ImageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
            if modle.item == "58" {
                modle.defaultValue = "Other"
            }else{
                modle.defaultValue = "Yes"
            }
            modle.other = "Photo Uploaded"
            Pickerimages.append(fullPath)
            modle.images = Pickerimages
            tableView.reloadRows(at: [imgIndexPath!], with: .automatic)
        }
    }
}

