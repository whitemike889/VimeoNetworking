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
    
    var isCachedResponse: Bool
    var isFinalResponse: Bool
    
    let nextPagePath: String? // TODO: implement [RH] (4/5/16)
    var nextPageRequest: Request<ModelType>?
    {
        return nil // TODO: computed from nextPagePath [RH] (4/5/16)
    }
    
    // MARK: - 
    
    init(model: ModelType,
         isCachedResponse: Bool = false,
         isFinalResponse: Bool = true,
         nextPagePath: String? = nil)
    {
        self.model = model
        self.isCachedResponse = isCachedResponse
        self.isFinalResponse = isFinalResponse
        self.nextPagePath = nextPagePath
    }
}