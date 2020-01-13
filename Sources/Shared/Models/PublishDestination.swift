//
//  PublishJobDestination.swift
//  VimeoNetworking
//
//  Copyright © 2019 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

/// The status of the upload or post for the given platform.
/// - error: There was an error when trying to upload the video or create the post.
/// - finished: The upload and post were successfully completed.
/// - inProgress: The upload or post creation process is currently underway.
@objc public enum PublishStatus: Int {
    case error
    case finished
    case inProgress
}

extension PublishStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .error:
            return String.error
        case .finished:
            return String.finished
        case .inProgress:
            return String.inProgress
        }
    }
}

@objc public class PublishDestination: VIMModelObject {
    /// The status of the upload/post on the specified platform as a `String`.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `status` is preferred.
    @objc public var statusString: String?
    
    /// The status of the upload/post on the specified platform.
    public var status: PublishStatus? {
        switch self.statusString {
        case String.error:
            return .error
        case String.finished:
            return .finished
        case String.inProgress:
            return .inProgress
        default:
            return nil
        }
    }
    /// The URL of the upload/post on the specified platform.
    @objc public var thirdPartyPostURL: String?
    
    /// The ID of the upload/post on the specified platform.
    @objc public var thirdPartyPostID: String?
    
    // MARK: - Overrides
    
    public override func getObjectMapping() -> Any? {
        return [
            String.Key.thirdPartyPostURL: String.Value.thirdPartyPostURL,
            String.Key.thirdPartyPostID: String.Value.thirdPartyPostID,
            String.Key.status: String.Value.status
        ]
    }
}

/// An object that encapsulates data related to all of the supported platforms destinations.
@objcMembers
public class PublishDestinations: VIMModelObject {
    
    /// Information about the upload/post on Facebook.
    public var facebook: PublishDestination?
    
    /// Information about the upload/post on YouTube.
    public var youtube: PublishDestination?
    
    /// Information about the upload/post on LinkedIn.
    public var linkedin: PublishDestination?
    
    /// Information about the upload/post on Twitter.
    public var twitter: PublishDestination?

    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.facebook,
             String.Key.linkedin,
             String.Key.twitter,
             String.Key.youtube:
            return PublishDestination.self
        default:
            return nil
        }
    }
}

private extension String {
    struct Key {
        static let facebook = "facebook"
        static let linkedin = "linkedin"
        static let twitter = "twitter"
        static let youtube = "youtube"
        static let thirdPartyPostURL = "third_party_post_url"
        static let thirdPartyPostID = "third_party_post_id"
        static let status = "status"
    }
    
    struct Value {
        static let status = "statusString"
        static let thirdPartyPostURL = "thirdPartyPostURL"
        static let thirdPartyPostID = "thirdPartyPostID"
    }
    
    static let error = "error"
    static let finished = "finished"
    static let inProgress = "in_progress"
}
