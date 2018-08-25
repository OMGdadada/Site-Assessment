//
//  ViewController.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/26.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate {
    //fileprivate let service = GTLRDriveService()
    //static var user :GIDGoogleUser
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeDriveFile]
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance().signInSilently()
        let Signbtn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        Signbtn.center = view.center
        view.addSubview(Signbtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            //service.authorizer = nil
            print("Sign error:\(error)")
            return
        } else {
            //ViewController.user = user
            //print(user.profile.)
            self.performSegue(withIdentifier: "ShowProductList", sender: user)
            //service.authorizer = user.authentication.fetcherAuthorizer()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductList"{
            let controller = segue.destination as! ProductListViewController
            controller.user = sender as? GIDGoogleUser
        }
    }
}
