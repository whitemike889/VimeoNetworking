//
//  TranscodeStatusEndpointType.swift
//  VimeoNetworking-iOS
//
//  Created by Nicole Lehrer on 12/10/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import Foundation

/// Encapsulates all information required to fetch a video's transcode status
public struct TranscodeStatusEndpointType: EndpointType {
    public let headers: HTTPHeaders? = nil
    public let parameters: Any? = nil
    public let method = HTTPMethod.get
    public let path: String
    private let videoURI: String
    private let statusPathComponent = "/status"
    
    /// Initializer for creating a TranscodeStatusEndpointType
    /// - Parameter videoURI: the URI of the video
    public init(videoURI: String) {
        self.videoURI = videoURI
        self.path = videoURI + statusPathComponent
    }
    
    /// Provides a configured request for fetching a video's transcode status
    public func asURLRequest() throws -> URLRequest {
        return URLRequest(url: baseURL.appendingPathComponent(path))
    }
}
