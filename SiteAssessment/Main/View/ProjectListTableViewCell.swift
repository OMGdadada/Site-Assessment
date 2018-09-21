//
//  ProjectListTableViewCell.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/20.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

class ProjectListTableViewCell: UITableViewCell {

    @IBOutlet weak var item: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didClikec(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
