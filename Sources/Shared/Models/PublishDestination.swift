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
/// - error: There was an error trying to upload the video or create the post.
/// - finished: The post was successfully published.
/// - inProgress: The post creation process is currently underway.
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

@objcMembers
public class PublishDestination: VIMModelObject {
    /// The status of the post on the specified platform as a `String`.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `status` is preferred.
    public private(set) var statusString: String?
    
    /// The status of the post for a given platform.
    @nonobjc public var status: PublishStatus? {
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
    /// The URL of the post on a given platform.
    public private(set) var thirdPartyPostURL: String?
    
    /// The ID of the post on a given platform.
    public private(set) var thirdPartyPostID: String?

    /// The number of views this post has, as reported by the third party platform.
    public private(set) var thirdPartyViewCount: NSNumber?

    /// The number of likes (or equivalent) this post has, as reported by the third party platform.
    public private(set) var thirdPartyLikeCount: NSNumber?

    /// The number of comments this post has, as reported by the third party platform.
    public private(set) var thirdPartyCommentCount: NSNumber?
    
    // MARK: - Overrides
    
    public override func getObjectMapping() -> Any? {
        return [
            String.Key.thirdPartyPostURL: String.Value.thirdPartyPostURL,
            String.Key.thirdPartyPostID: String.Value.thirdPartyPostID,
            String.Key.thirdPartyViewCount: String.Value.thirdPartyViewCount,
            String.Key.thirdPartyLikeCount: String.Value.thirdPartyLikeCount,
            String.Key.thirdPartyCommentCount: String.Value.thirdPartyCommentCount,
            String.Key.status: String.Value.status
        ]
    }
}

/// Encapsulates data related to all supported platform destinations.
@objcMembers
public class PublishDestinations: VIMModelObject {
    
    /// Information about a post on Facebook.
    public private(set) var facebook: PublishDestination?
    
    /// Information about a post on YouTube.
    public private(set) var youtube: PublishDestination?
    
    /// Information about a post on LinkedIn.
    public private(set) var linkedin: PublishDestination?
    
    /// Information about a post on Twitter.
    public private(set) var twitter: PublishDestination?

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
        static let thirdPartyViewCount = "third_party_view_count"
        static let thirdPartyLikeCount = "third_party_like_count"
        static let thirdPartyCommentCount = "third_party_comment_count"
        static let status = "status"
    }
    
    struct Value {
        static let status = "statusString"
        static let thirdPartyPostURL = "thirdPartyPostURL"
        static let thirdPartyPostID = "thirdPartyPostID"
        static let thirdPartyViewCount = "thirdPartyViewCount"
        static let thirdPartyLikeCount = "thirdPartyLikeCount"
        static let thirdPartyCommentCount = "thirdPartyCommentCount"
    }
    
    static let error = "error"
    static let finished = "finished"
    static let inProgress = "in_progress"
}
