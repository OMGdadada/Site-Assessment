//
//  TQuestionTableViewCell.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/19.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

class TQuestionTableViewCell: UITableViewCell {

    var promtLable:UILabel = UILabel()
    var titlelable:UILabel = UILabel()
    // 提示
    var promItem :String? {
        didSet{
            var promStr = ""
            if promItem == "58" {
                promtLable.frame = CGRect(x: 15, y: 80, width: Int(Screen_W - 20), height: 90)
                promStr = "Please circle the type of structure from the following choices. If the structure of the property does not correspond with any of the listed choices, please provide a sketch with all necessary measurements in the box below."
                promtLable.font = UIFont.systemFont(ofSize: 18)
                
            }else{
                promtLable.frame = CGRect(x: 0, y: 10, width: Screen_W, height: 60)
                if (promItem == "6") {
                    promStr = "Roof & Shingle Photo Check List"
                }else if (promItem == "24"){
                    promStr = "Meter Photo Check List"
                }else if (promItem == "38"){
                    promStr = "Main Breaker Photo Check List"
                }else if (promItem == "42"){
                    promStr = "Please clearly indicate on the corresponding layout diagram the following:"
                    promtLable.font = UIFont.systemFont(ofSize: 18)
                }
            }
            promtLable.text = promStr;
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setinittitle()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension TQuestionTableViewCell {
  fileprivate  func setinittitle(){
        promtLable.textAlignment = NSTextAlignment.center
        promtLable.textColor = UIColor.gray
        promtLable.font = UIFont.systemFont(ofSize: 25)
        promtLable.numberOfLines=0
        promtLable.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(promtLable)
        
        titlelable.textColor = UIColor.gray
        titlelable.numberOfLines=0
        titlelable.lineBreakMode = NSLineBreakMode.byWordWrapping
        titlelable.font = UIFont.systemFont(ofSize: 22)
        titlelable.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(titlelable)
    }
    
    func setinitlabel(lableStr : String,Item : String){
        var hs = 0
        if(Item == "6" || Item == "24" || Item == "38" || Item == "42"){
            hs = 70
        }

        titlelable.text = lableStr
        titlelable.frame = CGRect(x: 15, y: 10 + hs, width: Int(Screen_W - 20), height: 60)
        titlelable.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
        titlelable.textColor = UIColor.white
        
    }
    
}

