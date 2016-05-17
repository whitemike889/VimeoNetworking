//
//  Request+Soundtrack.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 4/21/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// Request that returns an array of `VIMSoundtrack`
public typealias SoundtrackListRequest = Request<[VIMSoundtrack]>

public extension Request
{
    private static var SoundtracksURI: String { return "/songs" }
    
    /**
     Create a `Request` to get all soundtracks
     
     - returns: the new `Request`
     */
    public static func getSoundtrackListRequest() -> Request
    {
        return self.getSoundtrackListRequest(soundtracksURI: self.SoundtracksURI)
    }
    
    /**
     Create a `Request` to get all soundtracks at a specific URI
     
     - parameter soundtracksURI: the soundtrack URI
     
     - returns: the new `Request`
     */
    public static func getSoundtrackListRequest(soundtracksURI soundtracksURI: String) -> Request
    {
        return Request(path: soundtracksURI)
    }
}
