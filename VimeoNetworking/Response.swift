//
//  Response.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

struct Response<ModelType: MappableResponse>
{
    let model: ModelType
    
    let nextPagePath: String? = nil // TODO:  [RH] (4/5/16)
    var nextPageRequest: Request<ModelType>?
    {
        return nil // TODO: computed from nextPagePath [RH] (4/5/16)
    }
}