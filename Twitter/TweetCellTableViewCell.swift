//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Marco Cruz on 1/1/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var TweetContent: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var RetweetButton: UIButton!
    
    
    @IBAction func FavoriteAction(_ sender: Any) {
        
        let tobeFavorited = !favorited
             
             if (tobeFavorited){
                 TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                     self.setFavorite(true)
                 }, failure: { (error) in
                     print("Favorite did not Succed")
                 })
             }
             else{
                 TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                     self.setFavorite(false)
                 }, failure: { (error) in
                     print("Unfavorite did not succeed")
                 })
                 
             }
            
        
        
    }
    @IBAction func RetweetAction(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
               self.setRetweeted(true)
           }, failure: { (error) in
               print("Error is retweeting: \(error)")
           })
        
        
    }
    func setRetweeted(_ isRetweeted: Bool){
        
        if(isRetweeted){
            print("made it here")
            RetweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            RetweetButton.isEnabled = false
        }
        else{
            RetweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            RetweetButton.isEnabled = true
            
        }
        
    }
    
    
    
    
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    func setFavorite(_ isFavorited:Bool){
          favorited = isFavorited
          if(favorited){
              
              FavoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
          }
              
          else{
                FavoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
              
              
          }
          
          
      }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
