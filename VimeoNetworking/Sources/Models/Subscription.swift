//
//  self.swift
//  Pods
//
//  Created by Lim, Jennifer on 2/8/17.
//
//

import Foundation

public class Subscription: VIMModelObject
{
    // MARK: - Properties
    
    public var comment: NSNumber?
    public var credit: NSNumber?
    public var like: NSNumber?
    public var mention: NSNumber?
    public var reply: NSNumber?
    public var follow: NSNumber?
    public var videoAvailable: NSNumber?
    public var vodPreorderAvailable: NSNumber?
    public var vodRentalExpirationWarning: NSNumber?
    public var accountExpirationWarning: NSNumber?
    public var share: NSNumber?
    
    public var toDictionary: [NSObject: AnyObject]
    {
        let dictionary = ["comment": self.comment ?? false,
                          "credit": self.credit ?? false,
                          "like": self.like ?? false,
                          "mention": self.mention ?? false,
                          "reply": self.reply ?? false,
                          "follow": self.follow ?? false,
                          "vod_preorder_available": self.vodPreorderAvailable ?? false,
                          "video_available": self.videoAvailable ?? false,
                          "share": self.share ?? false]
        
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
