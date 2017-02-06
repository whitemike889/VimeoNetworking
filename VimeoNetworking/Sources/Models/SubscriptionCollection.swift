//
//  SubscriptionCollection.swift
//  Pods
//
//  Created by Lim, Jennifer on 1/20/17.
//
//

import Foundation

public class SubscriptionCollection: VIMModelObject
{
    // MARK: - Properties
    
    public var uri: String?
    public var modifiedTime: NSDate?
    public var subscription = Subscription()
    
    // MARK: - VIMMappable
    
    public override func getObjectMapping() -> AnyObject!
    {
        return ["modified_time": "modifiedTime"]
    }
    
    public override func getClassForObjectKey(key: String!) -> AnyClass!
    {
        if key == "subscriptions"
        {
            return Subscription.self
        }
        
        return nil
    }
    
    // MARK: - Helper

    public convenience init(dictionary: [String : Bool])
    {
        self.init()
        self.subscription = Subscription(dictionary: dictionary)
    }
}

public class Subscription: VIMModelObject
{
    // MARK: - Properties
    
    public var comment: Bool = false
    public var credit: Bool = false
    public var like: Bool = false
    public var mention: Bool = false
    public var reply: Bool = false
    public var follow: Bool = false
    public var videoAvailable: Bool = false
    public var vodPreorderAvailable: Bool = false
    public var vodRentalExpirationWarning: Bool = false
    public var accountExpirationWarning: Bool = false
    public var share: Bool = false
    
    public convenience init(dictionary: [String : Bool])
    {
        self.init()
        
        self.comment = dictionary["comment"] ?? false
        self.credit = dictionary["credit"] ?? false
        self.like = dictionary["like"] ?? false
        self.mention = dictionary["mention"] ?? false
        self.reply = dictionary["reply"] ?? false
        self.follow = dictionary["follow"] ?? false
        self.videoAvailable = dictionary["video_available"] ?? false
        self.vodPreorderAvailable = dictionary["vod_preorder_available"] ?? false
        self.vodRentalExpirationWarning = dictionary["vod_rental_expiration_warning"] ?? false
        self.share = dictionary["share"] ?? false
    }

    public var toDictionary: [String: Bool]
    {
        let dictionary = ["comment" : self.comment,
                          "credit" : self.credit,
                          "like" : self.like,
                          "mention" : self.mention,
                          "reply" : self.reply,
                          "follow" : self.follow,
                          "video_available" : self.videoAvailable,
                          "vod_preorder_available" : self.vodPreorderAvailable,
                          "vod_rental_expiration_warning" : self.vodRentalExpirationWarning,
                          "account_expiration_warning" : self.accountExpirationWarning,
                          "share" : self.share]
        
        return dictionary
    }

    // MARK: - VIMMappable
    
    public override func getObjectMapping() -> AnyObject!
    {
        return [
                "video_available": "videoAvailable",
                "vod_preorder_available": "vodPreorderAvailable",
                "vod_rental_expiration_warning": "vodRentalExpirationWarning",
                "account_expiration_warning": "accountExpirationWarning"]
    }
}
