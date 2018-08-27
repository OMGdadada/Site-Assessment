//
//  ProjectResultTableViewCell.swift
//  SiteAssessment
//
//  Created by Jacob on 2018/8/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

class ProjectResultTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    var question:QuestionModel? {
        didSet{
            if (question?.question.contains(":"))! {
                title.text = "\(question?.question ?? "") \(question?.defaultValue ?? "")"  
            }else{
                title.text = "\(question?.question ?? ""): \(question?.defaultValue ?? "")"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
