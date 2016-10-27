//
//  Request+ProgrammedContent.swift
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 9/26/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// `Request` returning an array of `VIMVideo`
public typealias CinemaContentRequest = Request<[VIMProgrammedContent]>

public extension Request
{
    private static var CinemaPath: String { return "/programmed/cinema" }
    
    // MARK: -
    
    /**
     Create a `Request` to get the content for the Cinema
     
     - returns: a new `Request`
     */
    public static func getCinemaContentRequest() -> Request
    {
        return Request(path: self.CinemaPath)
    }
}
