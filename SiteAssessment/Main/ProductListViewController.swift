//
//  ProductListViewController.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/26.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST


class ProductListViewController: UIViewController {
    static var userList :GIDGoogleUser!
    var user:GIDGoogleUser!
    fileprivate let service = GTLRDriveService()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 通知
        
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name(rawValue:"update"), object: nil)
        //设置头像和昵称
        ProductListViewController.userList = user
        let HandImg:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        HandImg.center = CGPoint(x: view.center.x, y: view.center.y/2)
        
        let data = NSData(contentsOf: user.profile.imageURL(withDimension: 300))
        if data != nil {
            let handimg:UIImage = UIImage(data: data! as Data)!
            HandImg.image = handimg
        }
        HandImg.layer.cornerRadius = HandImg.bounds.height/2//CGRectGetHeight(HandImg.bounds)/2
        // 设置图片的外围圆框*
        HandImg.layer.masksToBounds = true
        //HandImg.layer.borderColor = UIColor.white as! CGColor
        HandImg.layer.borderColor = UIColor.white.cgColor
        HandImg.layer.borderWidth = 1
        
        let PickName:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        //PickName.adjustsFontSizeToFitWidth = true
        PickName.textAlignment = NSTextAlignment.center
        PickName.center = CGPoint(x:view.center.x,y:view.center.y/2+200)
        PickName.text = user.profile.name
        PickName.textColor = UIColor.black
        PickName.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(HandImg)
        view.addSubview(PickName)
        //设置头像和昵称END
        
        //设置历史和新增按钮
        let ProjectListbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        ProjectListbtn.center = CGPoint(x: view.center.x/2, y: view.center.y/2*3)
        ProjectListbtn.setTitle("History Project List", for: .normal)
        ProjectListbtn.setTitleColor(UIColor.black, for: .normal)
        ProjectListbtn.addTarget(self, action:#selector(SetProjectList(_:)), for: UIControlEvents.touchUpInside)
        let NewProductbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        NewProductbtn.center = CGPoint(x: view.center.x/2*3, y: view.center.y/2*3)
        NewProductbtn.setTitle("New Project", for: .normal)
        NewProductbtn.setTitleColor(UIColor.black, for: .normal)
        NewProductbtn.addTarget(self, action:#selector(SetNewProject(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(ProjectListbtn)
        view.addSubview(NewProductbtn)
        //设置历史和新增按钮END
        
        
        //设置退出按钮
        let SignOut = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        SignOut.center = CGPoint(x: view.center.x, y: view.center.y/2*3 + 100)
        SignOut.setTitle("Sign Out", for: .normal)
        SignOut.setTitleColor(UIColor.black, for: .normal)
        SignOut.addTarget(self, action:#selector(SignOut(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(SignOut)
        //设置退出按钮END
        
        
        print("获取标识")
        service.authorizer = user.authentication.fetcherAuthorizer()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //   实现通知监听方法
    @objc func update(){
        if iswifi == true{
            UploadProject.Uploadshared.UploadProjectdata(projectid!, project_id_id: projectid_id!, completion: { issuccess in
                if issuccess == true {
                    let projectinformation = ProjectInformation()
                    projectinformation.setValue(projectid!, forKey: "ProjectName")
                    ProjectListViewController.ProjectInformationList.addEntries(from: [projectid!:projectinformation])
                    UploadProject.Uploadshared.UploadProjectToGoogleDrive(projectid! ,project_id_id: projectid_id! ,completion: { isSuccess in
                        SVProgressHUD.showInfo(withStatus: "Upload And Save data And Img Success !");
                    })
                }
            }) 
            
        }else{
            UploadProject.Uploadshared.UploadProjectdata(projectid!,project_id_id: projectid_id!, completion: { issuccess in
                SVProgressHUD.showInfo(withStatus: "Upload And Save data Success !");
            }) 
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func SetProjectList(_ button:UIButton){
        self.performSegue(withIdentifier: "ShowProjectList", sender: user)
    }
    @objc func SetNewProject(_ button:UIButton){
        button.isEnabled = false;
        UploadProject.Uploadshared.getSearchResults { str in
            DispatchQueue.main.async(execute: {
                button.isEnabled = true;
                if str == nil {
                    return
                }
                let dic:[String:Any]? = self.stringValueDic(str ?? "")
                let vw:NewProjectListView = Bundle.main.loadNibNamed("NewProjectListView", owner: nil, options: nil)?[0] as! NewProjectListView
                vw.frame = CGRect(x: 0, y: 0, width: Screen_W/1.5, height: Screen_H / 2)
                vw.center = self.view.center
                vw.backgroundColor = UIColor.black
                vw.dataSoure = dic!["Site_Assessment"] as! Array<Any>
                vw.delageta = self
                Kappdelegate.window?.addSubview(vw)
            })
        }
    }
    
    @objc func SignOut(_ button:UIButton){
        GIDSignIn.sharedInstance().signOut()
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNewProject"{
            let controller = segue.destination as! NewProjectViewController
            controller.Project_Id = sender as? String
        }
        if segue.identifier == "ShowProjectList"{
            print("跳转至ProjectList")
            let controller = segue.destination as! ProjectListViewController
            controller.user = sender as? GIDGoogleUser
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("update"), object: nil)
    }
    
}
extension ProductListViewController :NewProjectListViewDelagate
{
    func didClickWithItem(str: String?, id: String?) {
        let storyBoard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : AddProjectViewController = storyBoard.instantiateViewController(withIdentifier: "AddProjectViewController") as! AddProjectViewController
        vc.Project_Id = str
        vc.Project_Id_id = id
        self.present(vc, animated: true, completion: nil)
    }
}
//let storyBoard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc : AddProjectViewController = storyBoard.instantiateViewController(withIdentifier: "AddProjectViewController") as! AddProjectViewController
//                vc.Project_Id = Project_Id.text!
//                self.present(vc, animated: true, completion: nil)
extension ProductListViewController
{
    // MARK: 字符串转字典
    fileprivate  func stringValueDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
}
