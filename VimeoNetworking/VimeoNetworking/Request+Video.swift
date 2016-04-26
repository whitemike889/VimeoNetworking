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
    private static var TitleKey: String { return "name" }
    private static var DescriptionKey: String { return "description" }
    private static var ViewKey: String { return "view" }
    private static var PrivacyKey: String { return "privacy" }
    private static var QueryKey: String { return "query" }
    
    private static var VideosPath: String { return "/videos" }
    
    // MARK: - 
    
    public static func getVideoRequest(videoURI videoURI: String) -> Request
    {
        return Request(path: videoURI)
    }
    
    // MARK: - Search
    
    public static func queryVideos(query query: String, refinements: VimeoClient.RequestParameters? = nil) -> Request
    {
        var parameters = refinements ?? [:]
        
        parameters[self.QueryKey] = query
        
        return Request(path: self.VideosPath, parameters: parameters)
    }
    
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