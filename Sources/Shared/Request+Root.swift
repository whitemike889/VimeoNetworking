//
//  Request+Root.swift
//  AFNetworking
//
//  Created by Song, Alexander on 8/10/19.
//

import Foundation

extension Request {
    
    public static func rootRequest(with userURI: String) -> Request {
        
        let path = "\(userURI)/folders/root"
        
        return Request(method: .GET, path: path)
    }
}
