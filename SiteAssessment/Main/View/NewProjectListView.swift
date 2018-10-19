//
//  NewProjectListView.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/9/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
protocol NewProjectListViewDelagate :NSObjectProtocol {
    func didClickWithItem(str:String? , id:String?) 
    
}
class NewProjectListView: UIView {
    var delageta:NewProjectListViewDelagate?
    private let cellid = "cellid"
    lazy var bgView:UIView = {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: Screen_W, height: Screen_H))
        view.backgroundColor = UIColor.clear
        return view
    }()
    @IBOutlet weak var tableView: UITableView!
    
    var dataSoure:Array<Any> = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    //
    @IBAction func cannel(_ sender: Any) {
        self.removeFromSuperview()
        bgView.removeFromSuperview()
    }
    //
    @objc func tap() {
        self.removeFromSuperview()
        bgView.removeFromSuperview()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.gray
        tableView.alpha = 0.8
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellid)
        Kappdelegate.window?.addSubview(bgView)
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        bgView.addGestureRecognizer(tap)
    }
}

extension NewProjectListView : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSoure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        let dic:[String :Any?] = dataSoure[indexPath.row] as! [String : Any?];
        cell.backgroundColor = UIColor.gray
        
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = dic["sa_projectAddress"] as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic:[String :Any?] = dataSoure[indexPath.row] as! [String : Any?];
        delageta?.didClickWithItem(str: dic["sa_projectAddress"] as? String ,id: dic["sa_prj"] as? String)
        self.removeFromSuperview()
        bgView.removeFromSuperview()
    }
    
}
