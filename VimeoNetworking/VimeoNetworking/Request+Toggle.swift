//
//  Request+Toggle.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/26/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias ToggleRequest = Request<VIMNullResponse>

public extension Request
{
    public static func toggle(URI URI: String, newValue: Bool) -> Request
    {
        return Request(method: newValue ? .PUT : .DELETE, path: URI)
    }
}