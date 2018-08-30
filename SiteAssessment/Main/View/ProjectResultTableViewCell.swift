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
    
    @IBOutlet weak var detail: UILabel!
    var question:QuestionModel? {
        didSet{
            if (question?.question.contains(":"))! {
                title.text = "\(question?.question ?? "")"  
            }else{
                title.text = "\(question?.question ?? " "):"
            }
            if question?.defaultValue == "Incomplete" {
                detail.textColor =  UIColor.red
            }else{
                detail.textColor = UIColor.black
            }
            if question?.question == "Truss Spacing:" {
                if question?.defaultValue != "Incomplete" {
                    detail.text = "\(question?.defaultValue ?? "")“ O/C"
                }else{
                     detail.text =  question?.defaultValue ?? " "
                }
            }else if question?.question == "Breaker Panel Amp:" {
                if question?.defaultValue != "Incomplete" {
                    detail.text = "\(question?.defaultValue ?? "")AMP"
                }else{
                    detail.text =  question?.defaultValue ?? " "
                }
            }else{
                detail.text =  question?.defaultValue ?? " " 
            }
           
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
