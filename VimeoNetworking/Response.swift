//
//  Response.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

struct Response<ModelType: Mappable>
{
    let model: ModelType
    
    let nextPagePath: String? = nil
}