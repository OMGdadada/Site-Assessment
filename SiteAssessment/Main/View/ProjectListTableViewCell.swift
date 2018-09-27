//
//  ProjectListTableViewCell.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/20.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
// 代理
protocol ProjectListTableViewCellDelagate :NSObjectProtocol {
    
    /// didClick  按钮点击事件
    ///
    /// - Parameters:
    ///   - cell: 当前cell
    ///   - question_item: 按钮tag
    func didProjectClick(cell:ProjectListTableViewCell , type:UpdateStatusType?)
    
    /// didClick  按钮点击事件
    ///
    /// - Parameters:
    ///   - cell: 当前cell
    ///   - question_item: 按钮tag
    func didWithUpdate(cell:ProjectListTableViewCell , type:UpdateStatusType?)
}

class ProjectListTableViewCell: UITableViewCell {
    var delegate : ProjectListTableViewCellDelagate?
    
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var item: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var model:HistoyDto? {
        didSet{
            title.text = "\(model?.projectID ?? "").plist"
            switch model?.status {
            case .Completed?:
                self.status.text = "Completed"
                self.item.setTitle("reupload", for: .normal)
                self.status.textColor = UIColor.black
                self.update.setTitle("Reupload", for: .normal);
                self.update.isEnabled = true;
                break
            case .Uploading?:
                self.status.text = "Uploading"
                self.item.isHidden = true
                self.item.isEnabled = false
                self.status.textColor = UIColor.black
                self.update.setTitle("Uploading", for: .normal);
                self.update.isEnabled = false;
                break
            case .Waiting?:
                self.status.text = "Waiting"
                self.item.setTitle("resume", for: .normal)
                self.status.textColor = UIColor.black
                self.update.setTitle("Upload", for: .normal);
                self.update.isEnabled = true;
                break
            case .Incomplete?:
                self.status.text = "Incomplete"
                self.item.setTitle("Edit", for: .normal)
                self.status.textColor = UIColor.red
                break
            case .uploadFailed?:
                self.status.text = "uploadFailed"
                self.item.setTitle("Continue", for: .normal)
                self.status.textColor = UIColor.red
                break
                
            default: break
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didClikec(_ sender: Any) {
        delegate?.didProjectClick(cell: self, type: model?.status)
    }
    @IBAction func update(_ sender: Any) {
        delegate?.didWithUpdate(cell: self, type: model?.status)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}