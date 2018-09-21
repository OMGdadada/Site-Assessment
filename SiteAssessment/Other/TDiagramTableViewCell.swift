//
//  TDiagramTableViewCell.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/19.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
protocol TDiagramTableViewCellDelagate :NSObjectProtocol {
    /// uitextFiled  发生改变
    ///
    /// - Parameter textFied: 文本框
    func diagrmWithChange(textFiedstr:String? ,cell:TDiagramTableViewCell ,textTag:NSInteger)
    
    /// uitextFiled  发生改变
    ///
    /// - Parameter textFied: 文本框
    func diagrmWithValue(textFiedstr:String? ,cell:TDiagramTableViewCell ,textTag:NSInteger)
    
}
class TDiagramTableViewCell: UITableViewCell {
    var delageta:TDiagramTableViewCellDelagate?
    var titleLable : UILabel!
    var imagec : UIImageView!
    var TopText:UITextField!
    var LeftText:UITextField!
    var RightText:UITextField!
    var buttomText:UITextField!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension TDiagramTableViewCell
{
    func setinitlabel(){
        let Main_Breaker_Panel_Diagram:UIImage = UIImage(named: "Main_Breaker_Panel_Diagram")!
        let Pickerimage:UIImageView!=UIImageView(frame: CGRect(x:225, y:200, width: 300, height: 300))
        Pickerimage.image = Main_Breaker_Panel_Diagram
        TopText = UITextField(frame: CGRect(x: 275, y: 155, width: 180, height: 40))
        let TopM :UILabel = UILabel(frame: CGRect(x: 275+190, y: 155, width: 40, height: 40))
        TopM.text = "M"
        TopM.font = UIFont.systemFont(ofSize: 35)
        TopText.placeholder = "Top"
        TopText.font = UIFont.systemFont(ofSize: 35)
        TopText.layer.borderWidth = 1.0
        let TopKB = KeyBoardView.init()
        TopText.inputView = TopKB
        TopKB.inputSource = TopText
        LeftText  = UITextField(frame: CGRect(x: 20, y: 325, width: 180, height: 40))
        let LeftM :UILabel = UILabel(frame: CGRect(x: 20+190, y: 325, width: 40, height: 40))
        LeftM.text = "M"
        LeftM.font = UIFont.systemFont(ofSize: 35)
        LeftText.placeholder = "Left"
        LeftText.font = UIFont.systemFont(ofSize: 35)
        LeftText.layer.borderWidth = 1.0
        let LeftKB = KeyBoardView.init()
        LeftText.inputView = LeftKB
        LeftKB.inputSource = LeftText
        RightText  = UITextField(frame: CGRect(x: 530, y: 325, width: 180, height: 40))
        let RightM :UILabel = UILabel(frame: CGRect(x: 530+190, y: 325, width: 40, height: 40))
        RightM.text = "M"
        RightM.font = UIFont.systemFont(ofSize: 35)
        RightText.placeholder = "Right"
        RightText.font = UIFont.systemFont(ofSize: 35)
        RightText.layer.borderWidth = 1.0
        let RightKB = KeyBoardView.init()
        RightText.inputView = RightKB
        RightKB.inputSource = RightText
        buttomText  = UITextField(frame: CGRect(x: 275, y: 505, width: 180, height: 40))
        let buttomM :UILabel = UILabel(frame: CGRect(x: 275+190, y: 505, width: 40, height: 40))
        buttomM.text = "M"
        buttomM.font = UIFont.systemFont(ofSize: 35)
        buttomText.placeholder = "buttom"
        buttomText.font = UIFont.systemFont(ofSize: 35)
        buttomText.layer.borderWidth = 1.0
        let buttomKB = KeyBoardView.init()
        buttomText.inputView = buttomKB
        buttomKB.inputSource = buttomText
 
        contentView.addSubview(Pickerimage)
        contentView.addSubview(TopText)
        contentView.addSubview(TopM)
        contentView.addSubview(LeftText)
        contentView.addSubview(LeftM)
        contentView.addSubview(RightText)
        contentView.addSubview(RightM)
        contentView.addSubview(buttomText)
        contentView.addSubview(buttomM)
        TopText.delegate = self
        LeftText.delegate = self
        RightText.delegate = self
        buttomText.delegate = self
        TopText.tag = 1000
        LeftText.tag = 2000
        RightText.tag = 3000
        buttomText.tag = 4000
    }
    
    func refresh(model:QuestionModel)  {
        titleLable = UILabel()
        titleLable.frame = CGRect(x: 15, y: 10, width: Int(Screen_W - 20), height: 60)
        titleLable.textColor = UIColor.gray
        titleLable.numberOfLines=0
        titleLable.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLable.font = UIFont.systemFont(ofSize: 25)
        titleLable.textAlignment = NSTextAlignment.center
        contentView.addSubview(titleLable)
        
        imagec = UIImageView()
        imagec.frame = CGRect(x:Screen_W - ico_expand.size.width - 12, y:((40 - ico_expand.size.height) / 2 ) , width:ico_expand.size.width,height: ico_expand.size.height)
        imagec.image = ico_expand
        contentView.addSubview(imagec)
        titleLable.text = model.question
        if model.isShow {
            textLabel?.textColor = UIColor(red: 0.0000, green: 0.6824, blue: 0.4627, alpha: 1.0000)
            imagec.image = ico_expand1
        }else{
            textLabel?.textColor = UIColor(red: 0.3961, green: 0.3961, blue: 0.3961, alpha: 1.0000)
            imagec.image = ico_expand
            return
        }

        let labelc = UILabel()
        labelc.text = model.option[0] as? String
        labelc.frame = CGRect(x: 10, y: 90 , width: Int(Screen_W-20), height: 60)
        labelc.font = UIFont.systemFont(ofSize: 18)
        labelc.numberOfLines=0
        labelc.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(labelc)
        setinitlabel()
        TopText.text = model.top
        LeftText.text = model.left
        RightText.text = model.right
        buttomText.text = model.bottom
        
       
    }
    
}

extension TDiagramTableViewCell : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        delageta?.diagrmWithValue(textFiedstr: newText, cell: self ,textTag: textField.tag)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delageta?.diagrmWithChange(textFiedstr: nil, cell: self ,textTag: textField.tag)
    }
}
