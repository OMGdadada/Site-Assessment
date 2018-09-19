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
    var currentIndexpath:IndexPath?
    
    
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
        var cell:TCheckBoxTableViewCell? = tableView.dequeueReusableCell(withIdentifier: kCheckBoxTableViewCell) as? TCheckBoxTableViewCell
        if( cell != nil ){
            for cell in cell!.contentView.subviews {
                cell.removeFromSuperview()
            }
        }
        cell = TCheckBoxTableViewCell(style: .default, reuseIdentifier: kCheckBoxTableViewCell)
        
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        cell?.delageta = self;
        cell?.setTabelCheckbox(model: dto.questionList[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if modle.isShow {
            return 500
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
        if self.currentIndexpath != nil && indexPath != self.currentIndexpath{
            //刷新cell
            let site:SiteRootModel = dataSoure[currentIndexpath!.section] as! SiteRootModel
            let question:QuestionModel = site.questionList[currentIndexpath!.row]
            if question.isShow {
                question.isShow = !question.isShow
            }
            print("currenttttt")
            tableView.reloadRows(at: [indexPath , currentIndexpath!], with: .automatic)
            self.currentIndexpath = indexPath
        }else{
            //刷新cell
            print("tttt")
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
        
    }
    // 编辑状态改变
    func textFiledChnage(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
        
    }
    // 点击按钮
    func didClick(cell: TCheckBoxTableViewCell, itemStr: String?, itemTag: NSInteger) {
        var indexPath:IndexPath = tableView.indexPath(for: cell) as! IndexPath
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        modle.isReply = true
        modle.defaultValue = itemStr
        
        let indexp:IndexPath = IndexPath(item: indexPath.row + 1, section: indexPath.section)
    
        switch itemTag {
        case 15:
            tableView?.reloadRows(at: [indexp as IndexPath], with: .automatic)
            break
        case 18:
            tableView?.reloadRows(at: [indexp as IndexPath], with: .automatic)
            break
        case 21:
            tableView?.reloadRows(at: [indexp as IndexPath], with: .automatic)
            break
        case 35:
            tableView?.reloadRows(at: [indexp as IndexPath], with: .automatic)
            break
        case 53    :
            tableView?.reloadRows(at: [indexp as IndexPath], with: .automatic)
            break
        default:
            break
        }
        //
        tableView?.reloadRows(at: [indexPath as IndexPath], with: .automatic)
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
