//
//  Request+Video.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

typealias ToggleRequest = Request<VIMNullResponse>

extension Request
{
    static func watchLaterRequest(videoURI videoURI: String) -> Request
    {
        return Request(method: .PUT, path: "/users/10895030/likes/7235817")
    }
}