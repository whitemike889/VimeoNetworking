//
//  VIMUploadQuota.swift
//  VimeoNetworking
//
//  Created by Lim, Jennifer on 3/26/18.
//

import Foundation

public class VIMUploadQuota: VIMModelObject
{
    /// The values within `VIMSpace` reflect the lowest of lifetime or period for free and max.
    @objc dynamic public var space: VIMSpace?
    
    /// Represents the current quota perio
    @objc dynamic public private(set) var periodic: VIMPeriodic?
    
    /// Represents the lifetime quota period
    @objc dynamic public private(set) var lifetime: VIMSizeQuota?
    
    public override func getClassForObjectKey(_ key: String!) -> AnyClass!
    {
        if key == "space"
        {
            return VIMSpace.self
        }
        else if key == "periodic"
        {
            return VIMPeriodic.self
        }
        else if key == "lifetime"
        {
            return VIMSizeQuota.self
        }
        
        return nil
    }
}

public class VIMSpace: VIMSizeQuota
{
    /// Whether the values of the upload_quota.space fields are for the lifetime quota or the periodic quota.
    @objc dynamic public private(set) var showing: String?
}

public class VIMPeriodic: VIMSizeQuota
{
    /// The time in ISO 8601 format when your upload quota resets.
    @objc dynamic public private(set) var resetDate: Date?

    // MARK: - VIMMappable

    public override func getObjectMapping() -> Any
    {
        return ["reset_date" : "resetDate"]
    }
}
