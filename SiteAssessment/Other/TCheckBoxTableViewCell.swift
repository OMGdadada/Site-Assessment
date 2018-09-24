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
    func didClick(cell:TCheckBoxTableViewCell ,itemStr:String? ,itemTag:NSInteger)
}

class TCheckBoxTableViewCell: UITableViewCell {
    var delageta:TCheckBoxTableViewCellDelagate?
    
    var titlelable:UILabel!
    var textFiled:UITextField!
    var textlable:UILabel!
    var textView:UITextView!
    
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
    
    @objc func tapped(_ button:UIButton) {
        
        delageta?.didClick(cell: self, itemStr: button.currentTitle ,itemTag: button.tag)
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
        contentView.addSubview(titlelable)
        
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
        setinittitle()
        var hs = 0
        if(model.item == "6" || model.item == "24" || model.item == "38" || model.item == "42"){
            hs = 70
        }
        titlelable.frame = CGRect(x: 15, y: 10 + hs, width: Int(Screen_W - 20), height: 60)
        titlelable.text = model.question
        
        if(model.other != nil){
            if model.other != "" {
                titlelable.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
                titlelable.textColor = UIColor.white 
            }
        }
        if model.item == "42" {
            let plable:UILabel = UILabel()
            
            plable.frame = CGRect(x: 0, y: 10, width: Screen_W, height: 60)
            plable.text = "Please clearly indicate on the corresponding layout diagram the following:"
            plable.font = UIFont.systemFont(ofSize: 18)
            contentView.addSubview(plable)
        }
        if !model.isShow {
            return
        }
        
        if(model.item == "58"){
            let plable:UILabel = UILabel()
            
            plable.frame = CGRect(x: 15, y: 80, width: Int(Screen_W - 20), height: 90)
            plable.text = "Please circle the type of structure from the following choices. If the structure opromItemroperty does not correspond with any of the listed choices, please provide a sketch with all necessary measurements in the box below." 
            plable.font = UIFont.systemFont(ofSize: 18)
            hs = 370
            let Truss_Type:UIImage = UIImage(named: "Truss_Type")!
            let Truss_Type_View:UIImageView!=UIImageView(frame: CGRect(x:15, y:190, width: UIScreen.main.bounds.width-40, height: 250))
            Truss_Type_View.image = Truss_Type
            contentView.addSubview(Truss_Type_View)
            contentView.addSubview(plable)
            var num:Int = 0
            if model.images != nil {
                num = model.images.count
            }
            if model.defaultValue == "Other" {
                if(num == 0){
                    let Img_Btn :UIButton = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(num % 3)+10, y : 840+(UIScreen.main.bounds.width/3)*CGFloat(num / 3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    Img_Btn.setTitle("+", for:.normal)
                    Img_Btn.setTitleColor(UIColor.black, for: .normal)
                    Img_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 105)
                    Img_Btn.titleLabel?.textColor = UIColor.gray
                    Img_Btn.tag = 5800
                    Img_Btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                    Img_Btn.backgroundColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
                    contentView.addSubview(Img_Btn)
                }
                if(num == 1){
                    let Image:UIImageView = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width/3)*CGFloat(0%3)+10, y : 840+(UIScreen.main.bounds.width/3)*CGFloat(0/3)+10, width: (UIScreen.main.bounds.width/3)-20, height: (UIScreen.main.bounds.width/3)-20))
                    if model.images != nil {
                        print("fffffff \(model.images[0])")
                        Image.image = UIImage(contentsOfFile: model.images?[0] as! String) 
                    }
                    contentView.addSubview(Image)
                }
            }
            
        }
        var i = 1;
        let tag:Int = Int(model.item) ?? 0
        for op in model.option{
            if(op as? String == "M"){
                textFiled.frame = CGRect(x: 20, y: 90 + hs, width: 225, height: 40)
                textFiled.tag = Int(model.item)! - 1
                textFiled.placeholder = "Please Enter the Numbers"
                if model.isReply{
                    textFiled.text = model.other
                }
                textFiled.tag = tag
                let kv = KeyBoardView.init()
                textFiled.inputView = kv
                kv.inputSource = textFiled
                
            }else if(model.item == "59"){
                textView.frame = CGRect(x: 20, y: 90 + hs, width: Int(Screen_W - 40), height: 220)
                if model.isReply {
                    textView.text = model.other
                }
                textView.tag = tag
            }else{
                let btn :UIButton = UIButton(type: UIButtonType.custom)
                if(i%2 == 1){
                    btn.frame = CGRect(x:20, y:90+(i/2)*60 + hs, width:Int((Screen_W)/2 - 30), height:40)
                }else{
                    btn.frame = CGRect(x:Int((Screen_W)/2 + 10), y:90+((i - 1)/2)*60 + hs, width:Int((Screen_W)/2 - 30), height:40)
                }
                btn.setTitle(op as? String, for:.normal)
                btn.setTitleColor(UIColor.black, for: .normal)
                if(btn.currentTitle == model.defaultValue){
                    btn.setImage(radio_Y, for: .normal)
                }else{
                    btn.setImage(radio_N, for: .normal)
                }
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                btn.tag = Int(model.item)!*10+i
                btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
                i = i+1
                if(op as? String == "Other" && model.item != "58" && model.defaultValue == "Other"){
                    textlable.frame = CGRect(x: 20, y: 90+(i/2)*60 + hs, width: 100, height: 40)
                    textlable.text = "NOTE:"
                    textView.frame = CGRect(x: 20, y: 90+(i/2)*60+50 + hs, width: Int(Screen_W - 40), height: 220)
                    if(model.isReply){
                        textView.text = model.other
                    }
                    textView.tag = tag
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
        if newText == "" {
            titlelable.backgroundColor = UIColor.white
            titlelable.textColor = UIColor.black 
        }else{
            titlelable.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
            titlelable.textColor = UIColor.white 
        }
        delageta?.textFiledValue(textFiedstr: newText, cell: self);
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textFiled.tag ==  Int((question?.item)!) {
//           // delageta?.textFiledChnage(textFiedstr: textField.text, cell: self)
//        }
//        
//    }
}

extension TCheckBoxTableViewCell : UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if newText == "" {
            titlelable.backgroundColor = UIColor.white
            titlelable.textColor = UIColor.black 
        }else{
            titlelable.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
            titlelable.textColor = UIColor.white 
        }
        delageta?.textFiledValue(textFiedstr: newText, cell: self);
        return true
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.tag ==  Int((question?.item)!) {
//            delageta?.textFiledChnage(textFiedstr: textView.text, cell: self)       
//        }
//        
//    }
}

