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
            if question?.other == "" || question?.other == nil {
                detail.text = "Incomplete"
                detail.textColor =  UIColor.red
            }else{
                if question?.item == "37" {
                    detail.text = "Up:\(question?.top ?? ""), Left:\(question?.left ?? ""), Down:\(question?.bottom ?? ""), Right:\(question?.right ?? "")"
                }else if question?.item == "36" {
                    detail.text = "\(question?.other ?? ""),Other:\(question?.textStr ?? "")"
                    let str:NSString = detail!.text! as NSString
                    detail.text = str.substring(with: NSMakeRange(1, str.length - 1))
                } else{
                   detail.text =  question?.other ?? " " 
                }
                
                detail.textColor = UIColor.black
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
