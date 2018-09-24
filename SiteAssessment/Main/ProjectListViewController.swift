//
//  ProjectListViewController.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/26.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import GoogleSignIn
import Alamofire

class ProjectListViewController: UIViewController{
    
    let NetWorkmanager = NetworkReachabilityManager()
    var NetWork = "不可用的网络(未连接)"
    
    var user:GIDGoogleUser!
    var PlistList = NSMutableArray () as! [HistoyDto]
    var completleList = NSMutableArray () as! [HistoyDto]
    var selecList = NSMutableArray () as! [HistoyDto]
    var PlistListCanBtn = NSMutableArray () as! [Bool]
    var projectname : String?
    
    static var ProjectInformationList = NSMutableDictionary()
    @IBOutlet weak var ProjectListView: UITableView!
    
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var deleteItem: UIBarButtonItem!
    
    var edit:Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWithdata()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Dispose of any resources that can be recreated.
        loadWithdata()
        self.deleteItem.title = ""
        print("PlistList:\(PlistList)")
        ProjectListView.tableFooterView = UIView()
        NetWorkmanager?.listener = { status in var statusStr: String?
            switch status {
            case .unknown:
                statusStr = "未识别的网络"
                self.NetWork = statusStr!
                break
            case .notReachable:
                statusStr = "不可用的网络(未连接)"
                self.NetWork = statusStr!
            case .reachable:
                if (self.NetWorkmanager?.isReachableOnWWAN)! {
                    statusStr = "2G,3G,4G...的网络"
                    self.NetWork = statusStr!
                } else if (self.NetWorkmanager?.isReachableOnEthernetOrWiFi)! {
                    statusStr = "wifi的网络";
                    self.NetWork = statusStr!
                }
                break
            }
            print(statusStr! as Any)
        }
        NetWorkmanager?.startListening()
        
        if(ProjectListViewController.ProjectInformationList.count != 0){
            for (offset: _ ,element: (key: key,value: _)) in ProjectListViewController.ProjectInformationList.enumerated(){
                let projectInformation = ProjectListViewController.ProjectInformationList[key] as! ProjectInformation
                projectInformation.addObserver(self, forKeyPath: "schedule", options: [.new,.old], context: nil)
                
            }
        }
    }
    
    fileprivate func loadWithdata() {
        let myDire: String = NSHomeDirectory() + "/Documents"
        let manager = FileManager.default
        let ArrayList = try! manager.contentsOfDirectory(atPath: myDire)
        
        for i in ArrayList{
            if(i.contains(".plist")){
                var ProjectInformation :NSDictionary
                ProjectInformation = NSDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(i)")!
                let model:HistoyDto = HistoyDto()
                model.projectID = i.replacingOccurrences(of: ".plist", with: "")
                model.uploaded  = ProjectInformation["uploaded"] as! Bool
                model.Datauploaded  = ProjectInformation["Datauploaded"] as! Bool
                switch ProjectInformation["ststus"] as! Int {
                case 1:
                    model.status = .Completed
                    
                    break
                case 2:
                    model.status = .Waiting
                    break
                case 3:
                    model.status = .Incomplete
                    completleList.append(model)
                    break
                default : break
                    
                }
                PlistList.append(model)
            }
        }
    }
    
    /// 上传问卷
    ///
    /// - Parameter ProjectName: 问卷ID
    fileprivate func updateProjectName(ProjectName: String , model:HistoyDto) {
        let projectinformation = ProjectInformation()
        projectinformation.setValue(ProjectName, forKey: "ProjectName")
        projectinformation.addObserver(self, forKeyPath: "schedule", options: [.new,.old], context: nil)
        ProjectListViewController.ProjectInformationList.addEntries(from: [ProjectName:projectinformation])
        UploadProject.Uploadshared.UploadProjectToGoogleDrive(ProjectName ,model: model)
        self.UpdateTableViewUI(ProjectName)
    }
    // 更新上传进度
    fileprivate func UpdateTableViewUI(_ ProjectId:String){
        for (index , value) in PlistList.enumerated(){
            if(value.projectID == ProjectId){
                ProjectListView.reloadRows(at: [[0,index]], with: .automatic)
            }
        }
    }
    
    @IBAction func BackOn_Click(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func edit(_ sender: Any) {
        if ProjectListView.isEditing {
            ProjectListView.setEditing(false, animated: true)
            edit = false
        }else{
            ProjectListView.setEditing(true, animated: true)
            edit = true
        }
        ProjectListView.reloadData()
    }

    @IBAction func didClickDelete(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let projectInformation = object as!ProjectInformation
        UpdateTableViewUI(projectInformation.ProjectName!)
    }
    
    
    
}
// MARK: ,UITableViewDelegate/DataSource 
extension ProjectListViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if edit {
            return completleList.count
        }
        return PlistList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model:HistoyDto
        if edit {
           model  = completleList[indexPath.row]
        }else{
           model = PlistList[indexPath.row]
        }
         
        
        let cell: ProjectListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProjectListTableViewCell", for: indexPath) as! ProjectListTableViewCell
    
        cell.model = model
        
        if(model.uploaded == false){
            cell.title.text = "\(cell.title.text!) (暂未上传完成) \n点击上传"
            for (offset: _ ,element: (key: key,value: _)) in ProjectListViewController.ProjectInformationList.enumerated(){
                if(projectname == "\(key)"){
                    let projectInformation = ProjectListViewController.ProjectInformationList[key] as! ProjectInformation
                    if (projectInformation.Total == 0){
                        cell.title.text = "Project: \n \(model.projectID!).plist (正在上传) 进度: 0%"
                    }else{
                        cell.title.text = "Project: \n \(model.projectID!).plist (正在上传) 进度: \(projectInformation.schedule * 100/projectInformation.Total)%"
                        if(projectInformation.schedule*100/projectInformation.Total == 100){
                            model.uploaded = true
                            cell.title.text = "\(cell.title.text!) (上传完成)"
                        }
                    }
                }
            }
        }else{
            model.uploaded = true
            cell.title.text = "\(cell.title.text!) (上传完成)"
        }
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if edit {
            var model:HistoyDto
            if edit {
                model  = completleList[indexPath.row]
            }else{
                model = PlistList[indexPath.row]
            }
            (selecList as! NSMutableArray ).remove(model)
        }
    }
    
    //处理选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        print("选中的Cell 为\(PlistList[indexPath.row])")
        var model:HistoyDto
        if edit {
            model  = completleList[indexPath.row]
            selecList.append(model)
            return
        }else{
            model = PlistList[indexPath.row]
        }
        
        if model.status == .Incomplete {
            pushAddPreject(model: model)
        }else{
            pushVC(projectID: model.projectID ?? "", update: false)
        }

       
    }
    // 开启编辑模式
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if edit {
            return false
        }
        return true
    }
    
    
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.init(rawValue: UITableViewCellEditingStyle.insert.rawValue | UITableViewCellEditingStyle.delete.rawValue)!;
    }
    //返回编辑类型，滑动删除
    //func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    //return UITableViewCellEditingStyle.delete
    //}
    
    
    
    //点击删除按钮的响应方法，在这里处理删除的逻辑
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("滑动删除")
//            let model:HistoyDto  = PlistList[indexPath.row]
//            
//            let ProjectInformation = NSDictionary(contentsOfFile: NSHomeDirectory()+"/Documents/\(model.projectID ?? "")")!
//            // 移除已经上传成功的文件
//            if(ProjectInformation["uploaded"] as? Bool == true && ProjectInformation["Datauploaded"] as? Bool == true){
//                let ProjectName = model.projectID?.replacingOccurrences(of: ".plist", with: "")
//                let filePath:String = NSHomeDirectory() + "/Documents/\(ProjectName!).plist"
//                let Manager = FileManager.default
//                try! Manager.removeItem(atPath: filePath)
//                let Folder:String = NSHomeDirectory() + "/Documents/\(ProjectName!)"
//                let fileArray = Manager.subpaths(atPath: Folder)
//                
//                for fn in fileArray!{
//                    try! Manager.removeItem(atPath: Folder + "/\(fn)")
//                }
//                
//                PlistList.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
//            }
//        }
  //  }
}
// MARK: method
extension ProjectListViewController
{
    fileprivate func network(ProjectName:String, model:HistoyDto) {
        if(self.NetWork == "wifi的网络"){
            self.updateProjectName(ProjectName: ProjectName ,model: model)
        }else if(self.NetWork == "2G,3G,4G...的网络"){
            THTool.alert(title: "系统提示", 
                         message: "您当前正在使用数据网络，确认上传么",
                         confirm: "好的",
                         cannel:  "取消", 
                         selfVC: self,
                         completion: { type in
                            switch type {
                            case .defualt: self.updateProjectName(ProjectName: ProjectName ,model: model)
                                break
                            case .cannel:
                                break
                            }
                            
            })
        }else{
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "您当前为无网络状态无法上传", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    /// 跳转
    fileprivate func pushVC(projectID:String , update:Bool)
    {
        let storybard:UIStoryboard = UIStoryboard.init(name:"Main", bundle: nil)
        let vc:ProjectResultViewController = storybard.instantiateViewController(withIdentifier: "ProjectResultViewController") as! ProjectResultViewController
        vc.prejectID = projectID;
        vc.isHistory = true
        vc.isUpdate = update
        self.showDetailViewController(vc, sender: nil)
    }
}

extension ProjectListViewController : ProjectListTableViewCellDelagate
{
    func didProjectClick(cell: ProjectListTableViewCell, type: UpdateStatusType?) {
        let indexp:IndexPath = ProjectListView.indexPath(for: cell)!
        let model:HistoyDto = PlistList[indexp.row]
        model.uploaded = false
        model.Datauploaded = false
        if type == .Incomplete {
            pushAddPreject(model: model)
        }else{
            network(ProjectName: model.projectID ?? "", model: model)
        }
    }
    
    fileprivate func pushAddPreject(model:HistoyDto) {
    let storyBoard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc : AddProjectViewController = storyBoard.instantiateViewController(withIdentifier: "AddProjectViewController") as! AddProjectViewController
    vc.Project_Id = model.projectID
    vc.isIncomple = true
    self.present(vc, animated: true, completion: nil)
    }
}
