//
//  Comment.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct Comment: UniqueModel
{
    // sourcery: jsonKey = resource_key
    public let resourceKey: String
    public let uri: String
    public let text: String?
    public let user: User?
    public let metadata: CommentMetadata?
}
