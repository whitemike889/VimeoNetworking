//
//  Request.swift
//  VimeoNetworking
//
//  Created by Rogerio de Paula Assis on 8/31/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import Foundation

protocol NetworkRequestDelegate {}

class NetworkRequest {
    
    private let requestConvertible: URLRequestConvertible
    
    init(requestConvertible: URLRequestConvertible) {
        self.requestConvertible = requestConvertible
    }
    
    func resume() {
        
    }
}
