//
//  VIMUpload.swift
//  Pods
//
//  Created by Lehrer, Nicole on 4/18/18.
//

import Foundation

/// Encapsulates the upload-related information on a video object.
public class VIMUpload: VIMModelObject
{
    /// The type of upload approach
    ///
    /// - streaming: Two-step upload without using tus; this will be deprecated
    /// - post: Upload with an HTML form or POST
    /// - pull: Upload from a video file that already exists on the internet
    /// - tus: Upload using the open-source tus protocol
    public enum UploadApproach: String
    {
        case streaming
        case post
        case pull
        case tus
    }
    
    /// The status of the upload
    ///
    /// - complete: The upload is complete
    /// - error: The upload ended with an error
    /// - underway: The upload is in progress
    public enum UploadStatus: String
    {
        case complete
        case error
        case underway = "in_progress"
    }
    
    @objc dynamic public private(set) var approach: String?

    @objc dynamic public private(set) var size: NSNumber?

    @objc dynamic public private(set) var status: String?
    
    @objc dynamic public private(set) var form: String?
    
    @objc dynamic public private(set) var link: String?

    @objc dynamic public private(set) var completeUri: String?
    
    @objc dynamic public private(set) var redirectUrl: String?

    @objc dynamic public private(set) var uploadLink: String?
    
    public private(set) var uploadApproach: UploadApproach?
    
    public private(set) var uploadStatus: UploadStatus?
    
    public override func didFinishMapping()
    {
        if let approachString = self.approach
        {
            self.uploadApproach =  UploadApproach(rawValue: approachString)
        }
        
        if let statusString = self.status
        {
            self.uploadStatus = UploadStatus(rawValue: statusString)
        }
    }
}
