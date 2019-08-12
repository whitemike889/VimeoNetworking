//
//  UserItem.swift
//  AFNetworking
//
//  Created by Song, Alexander on 8/10/19.
//

import Foundation

public class UserItem: VIMModelObject {
    
    /// The folder for the UserItem if one exists
    @objc var folder: Project?
    
    /// The item type for the UserItem, mapped to a Swift-only enum
    var type: UserItemType?
    
    /// The video of the UserItem if one exists
    @objc var video: VIMVideo?
}

extension UserItem {
    
    public enum UserItemType: String {
        case folder
        case video
    }
}
