//
//  TweetViewController.swift
//  Twitter
//
//  Created by Marco Cruz on 1/2/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBAction func tweet(_ sender: Any) {
        
        if(!tweetTextView.text.isEmpty){
                   TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                       self.dismiss(animated: true, completion: nil)
                   }, failure: { (error) in
                       print("Error posting Tweets \(error)")
                       self.dismiss(animated: true, completion: nil)
                       
               })
               }
               else{
                   self.dismiss(animated: true, completion: nil)

                   
               }
        
//        if (!TweetTextView.text.isEmpty){
//            print("Im in")
//            TwitterAPICaller.client?.postTweet(tweetString: TweetTextView.text, success: {
//                self.dismiss(animated: true, completion: nil)
//            }, failure: { (Error) in
//                print("error posting tweet, \(Error)")
//                self.dismiss(animated: true, completion: nil)
//            })
//        }else{
//            print("Noting tweeted ")
//            self.dismiss(animated: true, completion: nil)
//
//            }
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()

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
