//
//  Request+Category.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias CategoryRequest = Request<VIMCategory>
public typealias CategoryListRequest = Request<[VIMCategory]>

public extension Request
{
    private static var CategoriesPath: String { return "/categories" }
    
    public static func getCategoryRequest(categoryURI categoryURI: String) -> Request
    {
        return Request(path: categoryURI)
    }
    
    public static func getCategoriesRequest() -> Request
    {
        return Request(path: self.CategoriesPath)
    }
}
