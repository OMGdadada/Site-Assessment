//
//  TQuestionTableViewCell.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/19.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
// 代理
protocol TQuestionTableViewCellDelagate :NSObjectProtocol {

    /// didClick  按钮点击事件
    ///
    /// - Parameters:
    ///   - cell: 当前cellg
    func didImage(cell:TQuestionTableViewCell)
}
class TQuestionTableViewCell: UITableViewCell {
    var delegate:TQuestionTableViewCellDelagate?
    
    var promtLable:UILabel!
    var titlelable:UILabel!
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
    
    @objc func addImage(_ sender:UIButton) {
        delegate?.didImage(cell: self)
    }
}

extension TQuestionTableViewCell {
  fileprivate  func setinittitle(){
        promtLable = UILabel()
        promtLable.textAlignment = NSTextAlignment.center
        promtLable.textColor = UIColor.gray
        promtLable.font = UIFont.systemFont(ofSize: 25)
        promtLable.numberOfLines=0
        promtLable.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(promtLable)
    
        titlelable = UILabel()
        titlelable.numberOfLines=0
        titlelable.lineBreakMode = NSLineBreakMode.byWordWrapping
        titlelable.font = UIFont.systemFont(ofSize: 22)
        //titlelable.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(titlelable)
    }
    
    func setinitlabel(model:QuestionModel){

        var promStr = ""
        if model.item  == "58" {
            
        }else{
            promtLable.frame = CGRect(x: 0, y: 10, width: Screen_W, height: 60)
            if (model.item  == "6") {
                promStr = "Roof & Shingle Photo Check List"
            }else if (model.item  == "24"){
                promStr = "Meter Photo Check List"
            }else if (model.item  == "38"){
                promStr = "Main Breaker Photo Check List"
            }else if (model.item  == "42"){
                promStr = "Please clearly indicate on the corresponding layout diagram the following:"
                promtLable.font = UIFont.systemFont(ofSize: 18)
            }
        }
        promtLable.text = promStr;
        var hs = 0
        if(model.item == "6" || model.item == "24" || model.item == "38"){
            hs = 70
        }
        titlelable.text = model.question
        titlelable.text = model.question
        titlelable.frame = CGRect(x: 15, y: 10 + hs, width: Int(Screen_W - 20), height: 60)
        print(model.defaultValue)
        if( model.isReply){
            titlelable.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
            titlelable.textColor = UIColor.white
        }
        
    }
    
    func setinitIMage(model:QuestionModel) {
        var num:Int = 0
        if model.images != nil {
            num = model.images.count
        }
        if !model.isShow {
            return
        }
 
        var height:CGFloat = 0
        
        if(model.item == "6" || model.item == "24" || model.item == "38"){
            height = 70
        }
        let Img_Btn:UIButton = UIButton(type: .custom)
        Img_Btn.frame = CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat( num % 3 )+10, y : 80 + height + (UIScreen.main.bounds.width/3)*CGFloat(num/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20)
        Img_Btn.setTitle("+", for:.normal)
        Img_Btn.setTitleColor(UIColor.black, for: .normal)
        Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
        Img_Btn.titleLabel?.textColor = UIColor.gray
        Img_Btn.tag = 600
        Img_Btn.addTarget(self, action:#selector(addImage(_:)), for:.touchUpInside)
        Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
        contentView.addSubview(Img_Btn)
        for i in 0..<num {
            //print("图片位置生成")
            if(i < num ){
                let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(i%3)+10, y : 80 + height + (UIScreen.main.bounds.width/3)*CGFloat(i/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                if model.images != nil {
                    print("fffffff \(model.images[i])")
                    Image.image = model.images[i] as? UIImage
                }
                
                //print(Image)
                contentView.addSubview(Image)
            }
        }
    }
}

