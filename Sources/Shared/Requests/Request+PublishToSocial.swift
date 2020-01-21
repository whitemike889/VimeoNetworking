//
//  Request+PublishToSocial.swift
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

public extension Request where ModelType == PublishJob {
    /// Returns a request for fetching the `PublishJob` for a specified video ID.
    /// - Parameter videoID: The identifier for the video to be published.
    static func fetchPublishJob(for videoID: String) -> Request {
        let publishToSocialPath = String.videosURI + "/\(videoID)" + String.publishToSocialURI
        return Request(path: publishToSocialPath)
    }

    /// Returns a `put` request for publishing `SocialMediaPosts` for the given video ID.
    /// - Note: Post data should be validated prior to creating the publish request. Posts that fail server-side
    ///         validation will produce an error for that platform.
    /// - Parameters:
    ///   - posts: A structure containing all of the data necessary to publish to multiple platforms simultaneously.
    ///   - videoID: The identifier for the video to be published.
    static func publishPosts(_ posts: SocialMediaPosts, for videoID: String) -> Request {
        let publishToSocialPath = String.videosURI + "/\(videoID)" + String.publishToSocialURI
        var parameters = [String: Any]()

        posts.facebook.map {
            var post = [String: Any]()
            post[String.Key.title] = $0.title
            post[String.Key.description] = $0.description
            post[String.Key.destination] = $0.destination
            post[String.Key.categoryID] = $0.categoryID
            post[String.Key.allowEmbedding] = $0.allowEmbedding
            post[String.Key.shouldAppearOnNewsFeed] = $0.shouldAppearOnNewsFeed
            post[String.Key.isSecretVideo] = $0.isSecretVideo
            post[String.Key.allowSocialActions] = $0.allowSocialActions
            parameters[.facebook] = post
        }

        posts.linkedIn.map {
            var post = [String: Any]()
            post[String.Key.pageID] = $0.pageID
            post[String.Key.title] = $0.title
            post[String.Key.description] = $0.description
            parameters[.linkedin] = post
        }

        posts.twitter.map {
            var post = [String: String]()
            post[String.Key.tweet] = $0.tweet
            parameters[.twitter] = post
        }

        posts.youTube.map {
            var post = [String: Any]()
            post[String.Key.title] = $0.title
            post[String.Key.description] = $0.description
            post[String.Key.privacy] = $0.privacy.rawValue
            post[String.Key.categoryID] = $0.categoryID
            $0.tags.map { (tags) in  post[String.Key.tags] = tags }
            parameters[.youtube] = post
        }

        return Request(method: .put, path: publishToSocialPath, parameters: parameters)
    }
}

private extension String {
    static let videosURI = "/videos"
    static let publishToSocialURI = "/publish_to_social"

    struct Key {
        static let title = "title"
        static let description = "description"
        static let destination = "destination"
        static let pageID = "page_id"
        static let categoryID = "category_id"
        static let allowEmbedding = "allow_embedding"
        static let shouldAppearOnNewsFeed = "should_appear_on_news_feed"
        static let isSecretVideo = "is_secret_video"
        static let allowSocialActions = "allow_social_actions"
        static let tweet = "tweet"
        static let tags = "tags"
        static let privacy = "privacy"
    }
}
