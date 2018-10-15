//
//  QuestionsCell.swift
//  Site Assessment
//
//  Created by OMGdadada on 2018/7/5.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
public protocol QuestionsCellDelagate :NSObjectProtocol {
    /// uitextFiled  发生改变
    ///
    /// - Parameter textFied: 文本框
    func textFiledChnage(textFied:UITextField ,indexPath:IndexPath)
}

class QuestionsCell: UITableViewCell,UITextFieldDelegate,UITextViewDelegate {
    var delageta:QuestionsCellDelagate?
    
    var labelc : UILabel!
    var imagec : UIImageView!
    var textlabel : UILabel!

    //var	ischeck = false
    static var OptionSelecred : [String] = Array<Any>(repeating: "", count: 59) as! [String]
    static var TextBoxLabel : [String] = Array<Any>(repeating: "", count: 59) as! [String]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("注册Cell")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    3021215065
    
    func setinittitle(Item : String){
        var lableStr = ""
        labelc = UILabel()
        if(Item == "6"){
            lableStr = "Roof & Shingle Photo Check List"
            //labelc.backgroundColor = UIColor(red: 0, green: 152/256, blue: 204/256, alpha: 1)
            labelc.textAlignment = NSTextAlignment.center
            labelc.textColor = UIColor.gray
            labelc.frame = CGRect(x: 0, y: 10, width: Screen_W, height: 60)
        }else if(Item == "24"){
            lableStr = "Meter Photo Check List"
            //labelc.backgroundColor = UIColor(red: 0, green: 152/256, blue: 204/256, alpha: 1)
            labelc.textAlignment = NSTextAlignment.center
            labelc.textColor = UIColor.gray
            labelc.frame = CGRect(x: 0, y: 10, width: Screen_W, height: 60)
        }
        else if(Item == "38"){
            lableStr = "Main Breaker Photo Check List"
            //labelc.backgroundColor = UIColor(red: 0, green: 152/256, blue: 204/256, alpha: 1)
            labelc.textAlignment = NSTextAlignment.center
            labelc.textColor = UIColor.gray
            labelc.frame = CGRect(x: 0, y: 10, width: Screen_W, height: 60)
        }else if(Item == "42"){
            lableStr = "Please clearly indicate on the corresponding layout diagram the following:"
            labelc.frame = CGRect(x: 15, y: 10, width: Int(Screen_W - 20), height: 60)
        }else if(Item == "58"){
            lableStr = "Please circle the type of structure from the following choices. If the structure of the property does not correspond with any of the listed choices, please provide a sketch with all necessary measurements in the box below."
            labelc.frame = CGRect(x: 15, y: 80, width: Int(Screen_W - 20), height: 90)
        }
        labelc.text = lableStr
        labelc.font = UIFont.systemFont(ofSize: 25)
        if(Item == "42" || Item == "58"){
            labelc.font = UIFont.systemFont(ofSize: 18)
        }
        labelc.numberOfLines=0
        labelc.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(labelc)
    }
    
    
    func setinitlabel(lableStr : String,Item : String){
        var hs = 0
        if(Item == "6" || Item == "24" || Item == "38" || Item == "42"){
            hs = 70
        }
        labelc = UILabel()
        
        labelc.text = lableStr
        if(Item == "37"){
            labelc.frame = CGRect(x: 15, y: 10, width: Int(Screen_W - 20), height: 60)
            labelc.textColor = UIColor.gray
            labelc.numberOfLines=0
            labelc.lineBreakMode = NSLineBreakMode.byWordWrapping
            labelc.font = UIFont.systemFont(ofSize: 25)
            labelc.textAlignment = NSTextAlignment.center
        }else{
            labelc.frame = CGRect(x: 15, y: 10 + hs, width: Int(Screen_W - 20), height: 60)
            labelc.font = UIFont.systemFont(ofSize: 22)
            if(QuestionsCell.OptionSelecred[Int(Item)! - 1] != ""){
                if(Item != "17" && Item != "23"){
                    labelc.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
                    labelc.textColor = UIColor.white
                }else{
                    if(QuestionsCell.TextBoxLabel[Int(Item)! - 1] != ""){
                        labelc.backgroundColor = UIColor(red: 42/256, green: 161/256, blue: 96/256, alpha: 1)
                        labelc.textColor = UIColor.white
                    }
                }
            }
        }
        self.contentView.addSubview(labelc)
    }
    
    func setinitimage(imaged : UIImage,Item : String){
        var hs :CGFloat = 0
        if(Item == "6" || Item == "24" || Item == "38" || Item == "42"){
            hs = 70
        }
        let ico_expand = UIImage(named: "icon_mr")!
        imagec = UIImageView()
        imagec.frame = CGRect(x:Screen_W - ico_expand.size.width - 12, y:((40 - ico_expand.size.height) / 2 ) + hs, width:ico_expand.size.width,height: ico_expand.size.height)
        imagec.image = imaged
        self.contentView.addSubview(imagec)
    }
    
    
    func setUILabelinit(str : String) -> NSMutableAttributedString{
        textlabel = UILabel()
        textlabel.frame = CGRect(x:48, y:70, width:Screen_W - 48 - 20, height:0)
        textlabel.font = UIFont.systemFont(ofSize: 15)
        textlabel.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: str)
        textlabel.attributedText = attributedString
        self.contentView.addSubview(textlabel)
        textlabel.sizeToFit()
        
        return attributedString
        
    }
    func setTabelCheckbox(option : Array<Any>,QuestionItem : String) {
        var hs = 0
        if(QuestionItem == "6" || QuestionItem == "24" || QuestionItem == "38" || QuestionItem == "42"){
            hs = 70
        }else if(QuestionItem == "58"){
            hs = 370
        }
        var i = 1;
        for op in option{
            if(op as? String == "M"){
                let TextBox :UITextField = UITextField(frame: CGRect(x: 20, y: 90 + hs, width: 225, height: 40))
                
                TextBox.tag = Int(QuestionItem)! - 1
                TextBox.placeholder = "Please Enter the Numbers"
                if(QuestionsCell.TextBoxLabel[TextBox.tag] != ""){
                    TextBox.text = QuestionsCell.TextBoxLabel[TextBox.tag]
                }
                
                TextBox.font = UIFont.systemFont(ofSize: 18)
                TextBox.layer.borderWidth = 1.0
                TextBox.keyboardType = UIKeyboardType.numberPad
                TextBox.delegate = self
                let TextLabel :UILabel = UILabel(frame: CGRect(x: 250, y: 90 + hs, width: 40, height: 40))
                TextLabel.text = "M"
                TextLabel.font = UIFont.systemFont(ofSize: 22)
                let kv = KeyBoardView.init()
                TextBox.inputView = kv
                kv.inputSource = TextBox
                self.contentView.addSubview(TextLabel)
                self.contentView.addSubview(TextBox)
            }else if(QuestionItem == "37"){
                labelc = UILabel()
                let Lab :String = (op as? String)!
                labelc.text = Lab
                labelc.frame = CGRect(x: 10, y: 90 + hs, width: Int(Screen_W-20), height: 60)
                labelc.font = UIFont.systemFont(ofSize: 18)
                labelc.numberOfLines=0
                labelc.lineBreakMode = NSLineBreakMode.byWordWrapping
                self.contentView.addSubview(labelc)
            }else if(QuestionItem == "59"){
                let TextBox :UITextView = UITextView(frame: CGRect(x: 20, y: 90 + hs, width: Int(Screen_W - 40), height: 220))
                //TextBox.placeholder = "123"
                TextBox.font = UIFont.systemFont(ofSize: 22)
                TextBox.layer.borderWidth = 1.0
                TextBox.tag = Int(QuestionItem)! - 1
                if(QuestionsCell.TextBoxLabel[TextBox.tag] != ""){
                    TextBox.text = QuestionsCell.TextBoxLabel[TextBox.tag]
                }
                TextBox.delegate = self
                self.contentView.addSubview(TextBox)
            }else{
                let btn :UIButton = UIButton(type: UIButtonType.custom)
                if(i%2 == 1){
                    btn.frame = CGRect(x:20, y:90+(i/2)*60 + hs, width:Int((Screen_W)/2 - 30), height:40)
                }else{
                    btn.frame = CGRect(x:Int((Screen_W)/2 + 10), y:90+((i - 1)/2)*60 + hs, width:Int((Screen_W)/2 - 30), height:40)
                }
                btn.setTitle(op as? String, for:.normal)
                btn.setTitleColor(UIColor.black, for: .normal)
                
                //print(QuestionsCell.OptionSelecred[Int(QuestionItem)!-1])
                if(QuestionItem == "16" || QuestionItem == "22"){
                  // || QuestionItem == "36"
                    if(QuestionsCell.OptionSelecred[Int(QuestionItem)!-1] != ""){
                        
                        let SOPtion_10 = Int(QuestionsCell.OptionSelecred[Int(QuestionItem)!-1])
                        let SOPtion_2 =  String(SOPtion_10!,radix:2)
                        var x=1
                        for char in SOPtion_2.reversed(){
                            if(x == i){
                                if(char == "1"){
                                    btn.setImage(radio_Y, for: .normal)
                                }else{
                                    btn.setImage(radio_N, for: .normal)
                                }
                            }
                            x = x + 1
                        }
                        if(x-1<i){
                            btn.setImage(radio_N, for: .normal)
                        }
                    }else{
                        btn.setImage(radio_N, for: .normal)
                    }
                    
                }else{
                    if(btn.currentTitle == QuestionsCell.OptionSelecred[Int(QuestionItem)!-1]){
                        btn.setImage(radio_Y, for: .normal)
                    }else{
                        btn.setImage(radio_N, for: .normal)
                    }
                }
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                btn.tag = Int(QuestionItem)!*10+i
                btn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
                i = i+1
                if(op as? String == "Other" && QuestionItem != "58"){
                    let NOTE :UILabel = UILabel(frame: CGRect(x: 20, y: 90+(i/2)*60 + hs, width: 100, height: 40))
                    NOTE.text = "NOTE:"
                    NOTE.font = UIFont.systemFont(ofSize: 22)
                    NOTE.textColor = UIColor.black
                    self.contentView.addSubview(NOTE)
                    let TextBox :UITextView = UITextView(frame: CGRect(x: 20, y: 90+(i/2)*60+50 + hs, width: Int(Screen_W - 40), height: 220))
                    //TextBox.placeholder = "123"
                    TextBox.font = UIFont.systemFont(ofSize: 22)
                    TextBox.layer.borderWidth = 1.0
                    TextBox.keyboardType = UIKeyboardType.default
                    TextBox.tag = Int(QuestionItem)! - 1
                    if(QuestionsCell.TextBoxLabel[TextBox.tag] != ""){
                        TextBox.text = QuestionsCell.TextBoxLabel[TextBox.tag]
                    }
                    TextBox.delegate = self
                    self.contentView.addSubview(TextBox)
                    
                }
                self.contentView.addSubview(btn)
            }
            
        }
    }
    @objc func tapped(_ button:UIButton) {
        var Question_Item = button.tag/10
        if(Question_Item == 59){
            Question_Item = 58
        }
        let Option = button.tag - Question_Item*10
        var Option_2 = 1
        if(Option>=2){
            for _ in 2...Option{
                Option_2 = Option_2*2
            }
        }
       // || Question_Item == 36
        if(Question_Item == 16 || Question_Item == 22 ){
            if(QuestionsCell.OptionSelecred[Question_Item-1] == "" || QuestionsCell.OptionSelecred[Question_Item-1] == "0"){
                QuestionsCell.OptionSelecred[Question_Item-1] = String(Option_2)
            }else{
                
                let SOPtion_10 = Int(QuestionsCell.OptionSelecred[Question_Item-1])!
                
                let SOPtion_2 = String(SOPtion_10,radix:2)
                
                var x=1
                for char in SOPtion_2.reversed(){
                    if(x == Option){
                        if(char == "1"){
                            QuestionsCell.OptionSelecred[Question_Item-1] = String(Int(QuestionsCell.OptionSelecred[Question_Item-1])! - Option_2)
                        }else{
                            QuestionsCell.OptionSelecred[Question_Item-1] = String(Int(QuestionsCell.OptionSelecred[Question_Item-1])! + Option_2)
                        }
                    }
                    x = x + 1
                }
                if(x-1<Option){
                    QuestionsCell.OptionSelecred[Question_Item-1] = String(Int(QuestionsCell.OptionSelecred[Question_Item-1])! + Option_2)
                }
            }
            //
            
        }else{
            QuestionsCell.OptionSelecred[Question_Item-1] = button.currentTitle!
        }
        print(QuestionsCell.OptionSelecred[Question_Item-1])
        let tableView = superTableView()
        var indexPath = tableView?.indexPath(for: self)
        indexPath?.row += 1
        switch Question_Item {
        case 15:
            //tableView?.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
            break
        case 18:
            //tableView?.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
            break
        case 21:
            //tableView?.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
            break
        case 35:
            //tableView?.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
            break
        case 53	:
            //tableView?.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
            break
        default:
            break
        }
        //
        indexPath?.row -= 1
       // tableView?.reloadRows(at: [indexPath as! IndexPath], with: .automatic)
    }
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        QuestionsCell.TextBoxLabel[textField.tag] = newText
        QuestionsCell.OptionSelecred[textField.tag] = newText
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 16 {
            delageta?.textFiledChnage(textFied: textField, indexPath: IndexPath(item: 7, section: 1))
        }else if textField.tag == 21 {
            delageta?.textFiledChnage(textFied: textField, indexPath: IndexPath(item: 12, section: 1))
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        QuestionsCell.TextBoxLabel[textView.tag] = newText
        QuestionsCell.OptionSelecred[textView.tag] = newText
        return true
    }
    
    
    
}
extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        return startIndex..<endIndex
    }
}


