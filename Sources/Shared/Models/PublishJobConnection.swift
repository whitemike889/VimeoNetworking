//
//  PublishJobConnection.swift
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

/// A `VIMConnection` subclass that includes additional data related to publishing to multiple social media platforms.
@objcMembers
public class PublishJobConnection: VIMConnection {

    /// Reasons for which this video cannot be published, split by platform.
    /// - Note: Values will return as `nil` unless a blocker is present.
    public private(set) var publishBlockers: PublishJobBlockers?

    /// Parameters describing maximum values for a video post, split by platfrom.
    /// - Note: Constraints vary by platform and are hard coded server-side.
    public private(set) var publishConstraints: PublishJobConstraints?

    /// Whether or not a post has been published, split by platform.
    public private(set) var publishDestinations: PublishJobDestinations?
    
    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.publishBlockers:
            return PublishJobBlockers.self
        case String.Key.publishConstraints:
            return PublishJobConstraints.self
        case String.Key.publishDestinations:
            return PublishJobDestinations.self
        default:
            return nil
        }
    }
}

/// Reasons for which this video cannot be published, split by platform.
@objcMembers
public class PublishJobBlockers: VIMModelObject {

    /// Current blockers that will prevent posting to Facebook. If `nil`, publishing is not blocked for this platform.
    public private(set) var facebook: [String]?

    /// Current blockers that will prevent posting to YouTube. If `nil`, publishing is not blocked for this platform.
    public private(set) var youtube: [String]?

    /// Current blockers that will prevent posting to LinkedIn. If `nil`, publishing is not blocked for this platform.
    public private(set) var linkedin: [String]?

    /// Current blockers that will prevent posting to Twitter. If `nil`, publishing is not blocked for this platform.
    public private(set) var twitter: [String]?
}

/// Parameters describing maximum values for a video post, split by platfrom.
/// - Note: Constraints vary by platform and are hard coded server-side.
@objcMembers
public class PublishJobConstraints: VIMModelObject {

    /// Publishing constraints for Facebook.
    public private(set) var facebook: PublishConstraints?

    /// Publishing constraints for YouTube.
    public private(set) var youtube: PublishConstraints?

    /// Publishing constraints for LinkedIn.
    public private(set) var linkedin: PublishConstraints?

    /// Publishing constraints for Twitter.
    public private(set) var twitter: PublishConstraints?

    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.facebook,
             String.Key.youtube,
             String.Key.linkedin,
             String.Key.twitter:
            return PublishConstraints.self
        default:
            return nil
        }
    }
}

/// Whether or not a post has been published, split by platform.
@objcMembers
public class PublishJobDestinations: VIMModelObject {

    /// Whether the video was ever published to Facebook.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `facebook` is preferred.
    public private(set) var publishedToFacebook: NSNumber?

    /// Whether the video was ever published to LinkedIn.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `linkedin` is preferred.
    public private(set) var publishedToLinkedIn: NSNumber?

    /// Whether the video was ever published to Twitter.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `twitter` is preferred.
    public private(set) var publishedToTwitter: NSNumber?

    /// Whether the video was ever published to YouTube.
    /// - Note: This property is available to provide interoperability with Objective-C codebases.
    ///         Using `youtube` is preferred.
    public private(set) var publishedToYouTube: NSNumber?

    /// Whether the video was ever published to Facebook.
    @nonobjc public lazy var facebook: Bool = {
        return self.publishedToFacebook?.boolValue == true
    }()

    /// Whether the video was ever published to LinkedIn.
    @nonobjc public lazy var linkedin: Bool = {
        return self.publishedToLinkedIn?.boolValue == true
    }()

    /// Whether the video was ever published to Twitter.
    @nonobjc public lazy var twitter: Bool = {
        return self.publishedToTwitter?.boolValue == true
    }()

    /// Whether the video was ever published to YouTube.
    @nonobjc public lazy var youtube: Bool = {
        return self.publishedToYouTube?.boolValue == true
    }()

    public override func getObjectMapping() -> Any! {
        return [
            String.Key.facebook: String.Value.facebook,
            String.Key.linkedin: String.Value.linkedin,
            String.Key.twitter: String.Value.twitter,
            String.Key.youtube: String.Value.youtube
        ]
    }
}

/// Parameters describing maximum values for a video post on a social media platform.
@objcMembers
public class PublishConstraints: VIMModelObject {

    /// The maximum time in seconds for a video to be uploaded to a platform.
    public private(set) var duration: NSNumber?

    /// The maximum file size in bytes for a video to be uploaded to a platform.
    public private(set) var size: NSNumber?
}

private extension String {
    struct Key {
        static let publishBlockers = "publish_blockers"
        static let publishConstraints = "publish_constraints"
        static let publishDestinations = "publish_destinations"
        static let facebook = "facebook"
        static let youtube = "youtube"
        static let linkedin = "linkedin"
        static let twitter = "twitter"
    }

    struct Value {
        static let facebook = "publishedToFacebook"
        static let linkedin = "publishedToLinkedIn"
        static let twitter = "publishedToTwitter"
        static let youtube = "publishedToYouTube"
    }

    struct Blockers {
        static let size = "size"
        static let duration = "duration"
        static let facebookNoPages = "fb_no_pages"
        static let linkedInNoOrganizations = "li_no_organizations"
    }

    struct Constraints {
        static let size = "size"
        static let duration = "duration"
    }
}
