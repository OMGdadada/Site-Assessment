//
//  TCheckBoxTableViewCell.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/19.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
// 代理
protocol TCheckBoxTableViewCellDelagate :NSObjectProtocol {
    /// uitextFiled  发生改变
    ///
    /// - Parameter textFied: 文本框
    func textFiledChnage(textFiedstr:String? ,cell:TCheckBoxTableViewCell)
    
    /// uitextFiled  发生改变
    ///
    /// - Parameter textFied: 文本框
    func textFiledValue(textFiedstr:String? ,cell:TCheckBoxTableViewCell)
    
    
    /// didClick  按钮点击事件
    ///
    /// - Parameters:
    ///   - cell: 当前cell
    ///   - question_item: 按钮tag
    func didClick(cell:TCheckBoxTableViewCell ,question_item:NSInteger)
}

class TCheckBoxTableViewCell: UITableViewCell {
    var delageta:TCheckBoxTableViewCellDelagate?
    
    var titlelable:UILabel!
    var textFiled:UITextField!
    var textlable:UILabel!
    var textView:UITextView!
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

    }
    
    @objc func tapped(_ button:UIButton) {
        var Question_Item = button.tag/10
        if(Question_Item == 59){
            Question_Item = 58
        }
        delageta?.didClick(cell: self, question_item: Question_Item)
    }
}
extension TCheckBoxTableViewCell {
    fileprivate  func setinittitle(){
        titlelable = UILabel()
        titlelable.textColor = UIColor.black
        titlelable.numberOfLines=0
        titlelable.lineBreakMode = NSLineBreakMode.byWordWrapping
        titlelable.font = UIFont.systemFont(ofSize: 22)
        //titlelable.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(titlelable)
        
        textFiled = UITextField()
        textFiled.font = UIFont.systemFont(ofSize: 18)
        textFiled.layer.borderWidth = 1.0
        textFiled.keyboardType = UIKeyboardType.numberPad
        textFiled.delegate = self
        contentView.addSubview(textFiled)
        
        textlable = UILabel();
        textlable.font = UIFont.systemFont(ofSize: 22)
        textlable.textColor = UIColor.black
        contentView.addSubview(textlable)
        
        textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22)
        textView.layer.borderWidth = 1.0
        textView.delegate = self
        contentView.addSubview(textView)

    }
    
    func setTabelCheckbox(model:QuestionModel) {
        
        if !model.isShow {
            return
        }
        titlelable.frame = CGRect(x: 15, y: 10 , width: Int(Screen_W - 20), height: 60)
        titlelable.text = model.question;
        var hs = 0
        if(model.item == "6" || model.item == "24" || model.item == "38" || model.item == "42"){
            hs = 70
        }else if(model.item == "58"){
            hs = 370
        }
        var i = 1;
        for op in model.option{
            if(op as? String == "M"){
                textFiled.frame = CGRect(x: 20, y: 90 + hs, width: 225, height: 40)
                textFiled.tag = Int(model.item)! - 1
                textFiled.placeholder = "Please Enter the Numbers"
                if model.isReply {
                    textFiled.text = model.defaultValue
                }
                let kv = KeyBoardView.init()
                textFiled.inputView = kv
                kv.inputSource = textFiled

            }else if(model.item == "59"){
                textView.frame = CGRect(x: 20, y: 90 + hs, width: Int(Screen_W - 40), height: 220)
                if model.isReply {
                    textView.text = model.defaultValue
                }
            }else{
                let btn :UIButton = UIButton(type: UIButtonType.custom)
                if(i%2 == 1){
                    btn.frame = CGRect(x:20, y:90+(i/2)*60 + hs, width:Int((Screen_W)/2 - 30), height:40)
                }else{
                    btn.frame = CGRect(x:Int((Screen_W)/2 + 10), y:90+((i - 1)/2)*60 + hs, width:Int((Screen_W)/2 - 30), height:40)
                }
                btn.setTitle(op as? String, for:.normal)
                btn.setTitleColor(UIColor.black, for: .normal)
                if(model.item == "16" || model.item == "22"){
                    
                    if(model.isReply){
                        btn.setImage(radio_Y, for: .normal)
                    }else{
                        btn.setImage(radio_N, for: .normal)
                    }
                    
                }else{
                    if(btn.currentTitle == model.defaultValue){
                        btn.setImage(radio_Y, for: .normal)
                    }else{
                        btn.setImage(radio_N, for: .normal)
                    }
                }
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                btn.tag = Int(model.item)!*10+i
                btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
                i = i+1
                if(op as? String == "Other" && model.item != "58"){
                    textlable.frame = CGRect(x: 20, y: 90+(i/2)*60 + hs, width: 100, height: 40)
                    textlable.text = "NOTE:"
                    textView.frame = CGRect(x: 20, y: 90+(i/2)*60+50 + hs, width: Int(Screen_W - 40), height: 220)
                    if(model.isReply){
                        textView.text = model.defaultValue
                    }
                }
                self.contentView.addSubview(btn)
            }
        }
    }
}

extension TCheckBoxTableViewCell : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        delageta?.textFiledValue(textFiedstr: newText, cell: self);
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delageta?.textFiledChnage(textFiedstr: textField.text, cell: self)
    }
}

extension TCheckBoxTableViewCell : UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        delageta?.textFiledValue(textFiedstr: newText, cell: self);
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
         delageta?.textFiledChnage(textFiedstr: textView.text, cell: self)
    }
}

