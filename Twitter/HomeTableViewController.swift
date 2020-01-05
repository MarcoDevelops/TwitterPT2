//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Marco Cruz on 1/1/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // var means something that can change
    //let is a constant
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    var myrefreshControl = UIRefreshControl()
    
    @objc func loadTweets(){
        numberOfTweets = 20
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweets]

        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success:
        { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myrefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("could not retrieve")
        })
        
        
        
        
    }
    
    func loadMoreTweets(){
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let myParams = ["count": numberOfTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success:
           { (tweets: [NSDictionary]) in
               
               self.tweetArray.removeAll()
               for tweet in tweets {
                   self.tweetArray.append(tweet)
               }
               self.tableView.reloadData()
               
           }, failure: { (Error) in
               print("could not retrieve")
           })
        
        
        
    }
    
    
    
    

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        print("You logged out")
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(true, forKey: "userLoggedIn")
        
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        
        
        
        // THIS IS WHERE I CAN ADD EXTRA LABELS TO THE CELL TO CUSTUMIZE
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        
        
        cell.userNameLabel.text = user["name"] as? String
        cell.TweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        //dateCreated = tweetArray[indexPath.row]["created_at"] as? String
        //print(dateCreated)
        
        //Crating the image url
        
        let imageUrl = URL(string: ((user["profile_image_url_https"]) as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
            
        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        
        
        return cell
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
       
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
        
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        loadTweets()
        myrefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myrefreshControl
        
        
        
        

     }


}
