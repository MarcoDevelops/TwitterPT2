//
//  LoginViewController.swift
//  Twitter
//
//  Created by Marco Cruz on 1/1/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            
        }
        
    }
    
    @IBAction func OnLoginButton(_ sender: Any) {
        
        TwitterAPICaller.client?.login(url: "https://api.twitter.com/oauth/request_token", success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Error could not log in")
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
