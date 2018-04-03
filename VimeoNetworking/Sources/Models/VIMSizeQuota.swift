//
//  VIMSizeQuota.swift
//  VimeoNetworking
//
//  Created by Lim, Jennifer on 4/3/18.
//

public class VIMSizeQuota: VIMModelObject
{
    @objc dynamic public private(set) var free: NSNumber?
    @objc dynamic public private(set) var max: NSNumber?
    @objc dynamic public private(set) var used: NSNumber?
}
