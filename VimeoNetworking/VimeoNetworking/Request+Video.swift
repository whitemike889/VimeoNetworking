//
//  Request+Video.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias VideoRequest = Request<VIMVideo>

public extension Request
{
    public static var TitleKey: String { return "name" }
    public static var DescriptionKey: String { return "description" }
    public static var ViewKey: String { return "view" }
    public static var PrivacyKey: String { return "privacy" }
    
    // MARK: - 
    
    public static func getVideoRequest(videoURI videoURI: String) -> Request
    {
        return Request(path: videoURI)
    }
    
    // MARK: - Search
    
    // TODO: search with query [RH] (4/25/16)
    
    // MARK: - Edit Video
    
    public static func patchVideoRequest(videoURI videoURI: String, newTitle: String?, newDescription: String?, newPrivacy: String?) -> Request
    {
        var parameters = VimeoClient.RequestParameters()
        
        if let newTitle = newTitle
        {
            parameters[self.TitleKey] = newTitle
        }
        
        if let newDescription = newDescription
        {
            parameters[self.DescriptionKey] = newDescription
        }
        
        if let newPrivacy = newPrivacy
        {
            parameters[self.PrivacyKey] = [self.ViewKey: newPrivacy]
        }
        
        return Request(method: .PATCH, path: videoURI, parameters: parameters)
    }
}