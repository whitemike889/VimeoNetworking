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
    public var subscription: Subscription?
    
    // MARK: - VIMMappable
    
    public override func getObjectMapping() -> AnyObject!
    {
        return ["modified_time": "modifiedTime",
                "subscriptions": "subscription"]
    }
    
    public override func getClassForObjectKey(key: String!) -> AnyClass!
    {
        if key == "subscriptions"
        {
            return Subscription.self
        }
        
        return nil
    }
}
