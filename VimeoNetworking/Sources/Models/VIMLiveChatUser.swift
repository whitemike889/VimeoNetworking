//
//  VIMLiveChatUser.swift
//  Pods
//
//  Created by Nguyen, Van on 10/10/17.
//

public enum AccountType: String
{
    case basic = "basic"
    case business = "business"
    case liveBusiness = "live_business"
    case livePro = "live_pro"
    case plus = "plus"
    case pro = "pro"
    case proUnlimited = "pro_unlimited"
}

public class VIMLiveChatUser: VIMModelObject
{
    public private(set) var account: String?
    public var accountType: AccountType?
    {
        guard let accountValue = self.account else
        {
            return nil
        }
        
        return AccountType(rawValue: accountValue)
    }
    
    public private(set) var id: NSNumber?
    public private(set) var isCreator: NSNumber?
    public private(set) var isStaff: NSNumber?
    public private(set) var link: String?
    public private(set) var name: String?
    public private(set) var pictures: VIMPicture?
    public private(set) var uri: NSNumber?
}
