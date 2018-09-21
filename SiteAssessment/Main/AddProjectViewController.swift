//
//  AddProjectViewController.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/19.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import Alamofire

let KTQuestionTableViewCell = "TQuestionTableViewCell"

let kTDiagramTableViewCell = "TDiagramTableViewCell"
let kCheckBoxTableViewCell = "CheckBoxTableViewCell"
let header = "header"

class AddProjectViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    //
    let manager = NetworkReachabilityManager()
    var NetWork = "不可用的网络(未连接)"
    var Project_Id:String! = "ididid"
    var dataSoure = NSMutableArray()
    var currentIndexpath:IndexPath?
    var imgIndexPath:IndexPath? // 照片选中indexpath
    
    var Pickerimage_Nums = 0
    var Pickerimages : [UIImage] = NSMutableArray() as! [UIImage]
    var RoofShinglePhotoCheckList:NSMutableArray = []
    var MeterPhotoCheckList:NSMutableArray = []
    var MainBreakerPhotoCheckList:NSMutableArray = []
    var TrussType:NSMutableArray = []

    var imagePicker:UIImagePickerController = UIImagePickerController()
    var imageManager:PHCachingImageManager!
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWithData()
        congifureSubView()
        
    }
    // 取消
    @IBAction func cannel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // 保存
    @IBOutlet weak var save: UIBarButtonItem!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: 初始化设置
extension AddProjectViewController
{
    fileprivate func congifureSubView() {
        
        //
        self.imageManager = PHCachingImageManager()
        
        //
        
        tableView.register(CollapsibleTableViewHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: header)
        
        tableView.register(TCheckBoxTableViewCell.classForCoder(), forCellReuseIdentifier: kCheckBoxTableViewCell)
        
        tableView.register(TDiagramTableViewCell.classForCoder(), forCellReuseIdentifier: kTDiagramTableViewCell)
        
        tableView.register(TQuestionTableViewCell.classForCoder(), forCellReuseIdentifier: kTDiagramTableViewCell)
    }
}
// MARK: 获取问卷
extension AddProjectViewController
{
    fileprivate func loadWithData() {
        let plistpath = Bundle.main.path(forResource: "QuestionsList", ofType: "plist")
        let arr:NSArray = NSArray(contentsOfFile: plistpath!)!
        dataSoure = SiteRootModel.mj_objectArray(withKeyValuesArray: arr)
        tableView.reloadData()
    }
}

extension AddProjectViewController : UITableViewDelegate , UITableViewDataSource
{
    func setExtraCellLineHidden(tableview:UITableView){
        let viw = UIView()
        viw.backgroundColor = UIColor.clear
        tableview.tableFooterView = viw
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSoure.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model:SiteRootModel  = dataSoure[section] as! SiteRootModel
        if !model.isSelect {
            return 0;
        }
        return model.questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
       let modle:QuestionModel = dto.questionList[indexPath.row]
        if  (modle.item == "37"){
            var cell:TDiagramTableViewCell? = tableView.dequeueReusableCell(withIdentifier: kTDiagramTableViewCell) as? TDiagramTableViewCell
            if( cell != nil ){
                for cell in cell!.contentView.subviews {
                    cell.removeFromSuperview()
                }
            }
            cell = TDiagramTableViewCell(style: .default, reuseIdentifier: kTDiagramTableViewCell)
            
            cell?.refresh(model: modle)
            cell?.delageta = self as TDiagramTableViewCellDelagate
            modle.height = 500
            return cell!
        }else if(modle.item == "6" || modle.item == "7" || modle.item == "8" || modle.item == "9" || modle.item == "24" || modle.item == "25" || modle.item == "26" || modle.item == "27" || modle.item == "28" || modle.item == "29" || modle.item == "30" || modle.item == "31" ||  modle.item == "38" || modle.item == "39" || modle.item == "40" || modle.item == "41"  ){
            var hs:Float = 0
            var cell:TQuestionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: KTQuestionTableViewCell) as? TQuestionTableViewCell
            if( cell != nil ){
                for cell in cell!.contentView.subviews {
                    cell.removeFromSuperview()
                }
            }
            if(modle.item == "6" || modle.item == "24" || modle.item == "38"){
                hs = 70
            }
            
            if modle.images != nil {
               modle.height = Float(300 * (modle.images.count / 3 + 1)) + hs
            }else{
                modle.height = Float(300 + hs)
            }
            
            cell = TQuestionTableViewCell(style: .default, reuseIdentifier: KTQuestionTableViewCell)
            cell?.setinitlabel(model: modle)
            cell?.setinitIMage(model: modle)
            cell?.delegate = self as TQuestionTableViewCellDelagate
            return cell!
        }else{
            var cell:TCheckBoxTableViewCell? = tableView.dequeueReusableCell(withIdentifier: kCheckBoxTableViewCell) as? TCheckBoxTableViewCell
            if( cell != nil ){
                for cell in cell!.contentView.subviews {
                    cell.removeFromSuperview()
                }
            }
            cell = TCheckBoxTableViewCell(style: .default, reuseIdentifier: kCheckBoxTableViewCell)
            cell?.delageta = self as TCheckBoxTableViewCellDelagate
            if modle.item == "59" {
                modle.height = 300
            }else{
               modle.height = Float(((modle.option.count-1)/2)*60+80) 
            }
            
            cell?.setTabelCheckbox(model: dto.questionList[indexPath.row])
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sdwsa :CGFloat = 0
        
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        if modle.isShow {
            if(modle.item == "6" || modle.item == "24" || modle.item == "38" || modle.item == "42" ){
                sdwsa = 70
            }else if(modle.item == "58"){
                sdwsa = 370
            }
            if(modle.defaultValue == "Other"){
                sdwsa = sdwsa + 70 + CGFloat(modle.height) + 300
            }else{
                if( modle.item == "36"){
                    if(modle.defaultValue != nil || modle.defaultValue != ""){
                        //&& (Int(QuestionsCell.OptionSelecred[Int(Item!)!-1])! > 31)
                        if(modle.item == "16" ){
                            sdwsa = sdwsa + 70 + CGFloat(modle.height) + 300
                            //print(sdwsa)
                        // && (Int(QuestionsCell.OptionSelecred[Int(Item!)!-1])! > 7)
                        }else if((modle.item == "22") ){
                            sdwsa = sdwsa + 70 + CGFloat(modle.height) + 300
                        }else{
                            sdwsa = sdwsa + 70 + CGFloat(modle.height)
                        }
                    }else{
                        sdwsa = sdwsa + 70 + CGFloat(modle.height)
                    }
                }else{
                    sdwsa = sdwsa + 70 + CGFloat(modle.height)
                }
            }
        }else{
            let Question_Item = Int(modle.item)!-1
            if(Question_Item == 5 || Question_Item == 23 || Question_Item == 37 || Question_Item == 41){
                sdwsa = 70
            } 
            if(Question_Item == 58){
                sdwsa = 370
                sdwsa = sdwsa + 70 + CGFloat(modle.height)
                return sdwsa
            }
            if modle.isNoShow {
               // Question_Item = Question_Item - 1
                print("\(Question_Item)")
                switch Question_Item {
                case 15:
                    let model14 = dto.questionList[indexPath.row - 1]
                    if(model14.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        sdwsa = 0
                    }
                    break
                case 16:
                    let model14 = dto.questionList[indexPath.row - 2]
                    if(model14.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        sdwsa = 0
                    }
                    break
                case 18:
                    let model17 = dto.questionList[indexPath.row - 1]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        sdwsa = 0
                    }
                    break
                case 19:
                    let model17 = dto.questionList[indexPath.row - 2]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        sdwsa = 0
                    }
                    break
                case 20    :
                    let model17 = dto.questionList[indexPath.row - 3]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        sdwsa = 0
                    }
                    break
                case 21 :
                    let model20 = dto.questionList[indexPath.row - 1]
                    if(model20.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        sdwsa = 0
                    }
                    break
                case 35 :
                    let model34 = dto.questionList[indexPath.row - 1]
                    if(model34.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        sdwsa = 0
                        
                    }
                    break
                case 22 :
                    let model17 = dto.questionList[indexPath.row - 5]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        
                        sdwsa = 0
                    }
                    break
                case 23 :
                    let model17 = dto.questionList[indexPath.row - 6]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        
                        sdwsa = 0
                    }
                    break
                case 24 :
                    let model17 = dto.questionList[indexPath.row - 7]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        
                        sdwsa = 0
                    }
                    break
                case 25 :
                    let model17 = dto.questionList[indexPath.row - 8]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                       
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        
                        sdwsa = 0
                    }
                    break
                case 26 :
                    let model17 = dto.questionList[indexPath.row - 9]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        
                        sdwsa = 0
                    }
                    break
                case 27 :
                    let model17 = dto.questionList[indexPath.row - 10]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        sdwsa = 0
                       
                    }
                    break
                case 28 :
                    let model17 = dto.questionList[indexPath.row - 11]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        sdwsa = 0
                       
                    }
                    break
                case 29 :
                    let model17 = dto.questionList[indexPath.row - 12]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        sdwsa = 0
                    }
                    break
                case 30 :
                    let model17 = dto.questionList[indexPath.row - 12]
                    if(model17.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                    }else{
                        modle.defaultValue = ""
                        modle.images = []
                        sdwsa = 0
                    }
                    break
                case 54 :
                    let model53 = dto.questionList[indexPath.row - 1 ]
                    if(model53.defaultValue == "Yes"){
                        sdwsa = sdwsa + 80
                        
                    }else{
                        modle.defaultValue = ""
                        
                        sdwsa = 0
                    }
                    break
                default:
                    sdwsa = sdwsa + 0
                    break
                }
            }else{
                sdwsa = sdwsa + 80
            }
        }
        return sdwsa
    }
    
    // 组头和组尾
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = model.heading
        header.arrowLabel.text = ">"
        header.setCollapsed(model.isSelect)
        header.section = section
        header.delegate = self as CollapsibleTableViewHeaderDelegate
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击展开或收缩
        print(indexPath.section)
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        modle.isShow = !modle.isShow
        
        if self.currentIndexpath != nil && indexPath != self.currentIndexpath{
            //刷新cell
            let site:SiteRootModel = dataSoure[currentIndexpath!.section] as! SiteRootModel
            let question:QuestionModel = site.questionList[currentIndexpath!.row]
            if question.isShow {
                question.isShow = !question.isShow
            }
            tableView.reloadRows(at: [indexPath , currentIndexpath!], with: .automatic)
            self.currentIndexpath = indexPath
        }else{
            //刷新cell
            tableView.reloadRows(at: [indexPath], with: .automatic)
            self.currentIndexpath = indexPath
        }
        
        
    }
}
//
extension AddProjectViewController : TCheckBoxTableViewCellDelagate
{
    // 值改变
    func textFiledValue(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        modle.other = textFiedstr
        if textFiedstr == nil || textFiedstr == "" {
            modle.isReply = false
        }else{
            modle.isReply = true
        }
        
    }
    // 编辑状态改变
    func textFiledChnage(textFiedstr: String?, cell: TCheckBoxTableViewCell) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    // 点击按钮
    func didClick(cell: TCheckBoxTableViewCell, itemStr: String?, itemTag: NSInteger) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        modle.isReply = true
        modle.defaultValue = itemStr
        print("item\(modle.item))")
        print("itemStr\(modle.defaultValue))")
        if modle.item == "15" || modle.item == "18" {
            tableView.reloadData()
        }else{
            tableView.reloadRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
}

extension AddProjectViewController : TDiagramTableViewCellDelagate
{
    func diagrmWithValue(textFiedstr: String?, cell: TDiagramTableViewCell, textTag: NSInteger) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        let dto:SiteRootModel = dataSoure[indexPath.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[indexPath.row]
        switch textTag {
        case 1000:
            modle.top = textFiedstr
            break
        case 2000:
            modle.left = textFiedstr
            break
        case 3000:
            modle.right = textFiedstr
            break
        case 4000:
            modle.bottom = textFiedstr
            break
        default: break
        }
    }
    func diagrmWithChange(textFiedstr: String?, cell: TDiagramTableViewCell ,textTag:NSInteger) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        tableView.reloadRows(at: [indexPath], with: .bottom)
    }
}

//
extension AddProjectViewController : CollapsibleTableViewHeaderDelegate
{
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let model:SiteRootModel = dataSoure[section] as! SiteRootModel
        model.isSelect = !model.isSelect
        header.setCollapsed(model.isSelect)
        
        tableView.reloadData()
        
    }
}

extension AddProjectViewController : TQuestionTableViewCellDelagate
{
    func selectorSourceType(type: String) {
        //imagePicker.sourceType = type
        if(type == "camera"){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        // 打开图片选择器
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func didImage(cell: TQuestionTableViewCell) {
        let indexPath:IndexPath = tableView.indexPath(for: cell)!
        imgIndexPath = indexPath
        Pickerimages.removeAll()
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil)) // 取消按钮
        
        #if targetEnvironment(simulator)
        #else
            controller.addAction(UIAlertAction(title: "拍照选择", style: .default) { action in
                self.selectorSourceType(type: "camera")
            }) // 拍照选择
        #endif
        controller.addAction(UIAlertAction(title: "相册选择", style: .default) { action in

            _ = self.presentHGImagePicker(maxSelected:9) { (assets) in
                //结果处理
                //print("共选择了\(assets.count)张图片，分别如下：")
                for asset in assets {
                    //print(asset)
                    self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { (image, nfo) in
                        self.SavePickImage(image!)
                    })
                }
            }
        }) // 相册选择
        //print("弹出选择")
        // support iPad
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 400)
        
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: 当图片选择器选择了一张图片之后回调
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("获取到相册了")
        let tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(tempImage, nil, nil, nil)
        }
        SavePickImage(tempImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 当点击图片选择器中的取消按钮时回调
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) // 效果一样的...
        print("取消了")
        
    }
    
    private func SavePickImage(_ tempImage : UIImage){
        
        let dto:SiteRootModel = dataSoure[imgIndexPath!.section] as! SiteRootModel
        let modle:QuestionModel = dto.questionList[imgIndexPath!.row]
        
        let tempImageData = UIImageJPEGRepresentation(tempImage, 1)
        let TempImagelength = (tempImageData?.count)!/1000
        print("TempImagelength:\(TempImagelength)")
        var tempImageSLT:UIImage = tempImage
        tempImageSLT.compressImage(100, completion: { (image, compressRatio) in
            if let imageData = UIImageJPEGRepresentation(image, compressRatio) {
                tempImageSLT = UIImage(data: imageData)!
            }
        })
        var Nums = 0
        var PickerImage_Name = ""
        if modle.images != nil {
            Pickerimage_Nums = modle.images.count
            Pickerimages = modle.images as! [UIImage]
        }else{
            Pickerimage_Nums = 0
        }
        
        PickerImage_Name = modle.question
        modle.defaultValue = "Yes"
        modle.other = "Photo Uploaded"
        Pickerimages.append(tempImageSLT)
        Pickerimage_Nums = Pickerimage_Nums+1
        Nums = Pickerimage_Nums
        modle.images = Pickerimages
        tableView.reloadRows(at: [imgIndexPath!], with: .automatic)

        if(Pickerimage_Nums == 6 || Pickerimage_Nums == 7 || Pickerimage_Nums == 8 || Pickerimage_Nums == 9){
            RoofShinglePhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(Pickerimage_Nums == 24 || Pickerimage_Nums == 25 || Pickerimage_Nums == 26 || Pickerimage_Nums == 27 || Pickerimage_Nums == 28 || Pickerimage_Nums == 29 || Pickerimage_Nums == 30 || Pickerimage_Nums == 31){
            MeterPhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(Pickerimage_Nums == 38 || Pickerimage_Nums == 39 || Pickerimage_Nums == 40 || Pickerimage_Nums == 41){
            MainBreakerPhotoCheckList.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }else if(Pickerimage_Nums == 58){
            TrussType.add(["uploaded" : false,"ImgName" : "\(PickerImage_Name)_\(Nums)"])
        }
        
        let ImageName = "\(PickerImage_Name)_\(Nums).jpg"
        var persent = 1.0
        if(TempImagelength>5000){
            persent = Double(4500.0 / Double(TempImagelength))
            print(persent)
        }
        saveImage(currentImage: tempImage, persent: CGFloat(persent), imageName: ImageName)
        
    }
    
    private func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String){
        
        if let imageData = UIImageJPEGRepresentation(currentImage, persent) as NSData? {
            let myDire: String = NSHomeDirectory() + "/Documents/\(Project_Id!)"
            let fileManager = FileManager.default
            try! fileManager.createDirectory(atPath: myDire,
                                             withIntermediateDirectories: true, attributes: nil)
            
            let fullPath = NSHomeDirectory().appending("/Documents/\(Project_Id!)/").appending(imageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
        }
    }
    
}

