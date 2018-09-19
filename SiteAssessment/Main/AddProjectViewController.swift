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

let kCheckBoxTableViewCell = "CheckBoxTableViewCell"
let header = "header"

class AddProjectViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //
    let manager = NetworkReachabilityManager()
    var NetWork = "不可用的网络(未连接)"
    var Project_Id:String!
    var dataSoure = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWithData()
        congifureSubView()
    }
    // 取消
    @IBAction func cannel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // 保存
    @IBOutlet weak var save: UIBarButtonItem!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: 初始化设置
extension AddProjectViewController
{
    fileprivate func congifureSubView() {
        tableView.register(CollapsibleTableViewHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: header)
        
        tableView.register(TCheckBoxTableViewCell.classForCoder(), forCellReuseIdentifier: kCheckBoxTableViewCell)
    }
}
// MARK: 获取问卷
extension AddProjectViewController
{
    fileprivate func loadWithData() {
        let plistpath = Bundle.main.path(forResource: "QuestionsList", ofType: "plist")
        let arr:NSArray = NSArray(contentsOfFile: plistpath!)!
        dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: arr)
        tableView.reloadData()
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
        let cell:TCheckBoxTableViewCell = tableView.dequeueReusableCell(withIdentifier: kCheckBoxTableViewCell, for: indexPath) as! TCheckBoxTableViewCell;
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        cell.delageta = self;
        cell.setTabelCheckbox(model: dto.questionList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if modle.isShow {
            return 150
        }else{
            return 70
        }
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

        //刷新cell
        tableView.reloadRows(at: [indexPath as IndexPath], with: .automatic)
    }
}
//
extension AddProjectViewController : TCheckBoxTableViewCellDelagate
{
    // 值改变
    func textFiledValue(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
        
    }
    // 编辑状态改变
    func textFiledChnage(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
        
    }
    // 点击按钮
    func didClick(cell: TCheckBoxTableViewCell, question_item: NSInteger) {
       
    }
}
//
extension AddProjectViewController : CollapsibleTableViewHeaderDelegate
{
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        model.isSelect = !model.isSelect
        header.setCollapsed(model.isSelect)
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
