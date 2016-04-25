//
//  Request+Category.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias CategoryRequest = Request<VIMCategory>

public extension Request
{
    public static func getCategoryRequest(categoryURI categoryURI: String) -> Request
    {
        return Request(path: categoryURI)
    }
}
