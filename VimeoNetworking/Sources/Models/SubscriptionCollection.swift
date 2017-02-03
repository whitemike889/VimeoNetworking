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
    public var subscriptions: Subscription?
    
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

    static public func toSubscription(dictionary: [String : Bool]) -> Subscription?
    {
        let subscriptionCollections = SubscriptionCollection()
        
        if subscriptionCollections.subscriptions == nil
        {
           subscriptionCollections.subscriptions = Subscription()
        }
        
        guard let subscriptions = subscriptionCollections.subscriptions else
        {
            return nil
        }
        
        subscriptions.comment = dictionary["comment"] ?? false
        subscriptions.credit = dictionary["credit"] ?? false
        subscriptions.like = dictionary["like"] ?? false
        subscriptions.mention = dictionary["mention"] ?? false
        subscriptions.reply = dictionary["reply"] ?? false
        subscriptions.follow = dictionary["follow"] ?? false
        subscriptions.videoAvailable = dictionary["video_available"] ?? false
        subscriptions.vodPreorderAvailable = dictionary["vod_preorder_available"] ?? false
        subscriptions.vodRentalExpirationWarning = dictionary["vod_rental_expiration_warning"] ?? false
        subscriptions.share = dictionary["share"] ?? false
        
        return subscriptions
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
