//
//  Request+PublishToSocialTests.swift
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

import XCTest
@testable import VimeoNetworking

class Request_PublishToSocialTests: XCTestCase {

    private var facebookPost: PublishToFacebookPost {
        return PublishToFacebookPost(
            title: "Test Facebook post",
            description: "Test Facebook description",
            destination: 1234,
            categoryID: 5678,
            allowEmbedding: true,
            shouldAppearOnNewsFeed: true,
            isSecretVideo: false,
            allowSocialActions: true
        )
    }

    private var linkedInPost: PublishToLinkedInPost {
        return PublishToLinkedInPost(
            pageID: 1234,
            title: "Test LinkedIn post",
            description: "Test LinkedIn description"
        )
    }

    private var twitterPost: PublishToTwitterPost {
        return PublishToTwitterPost(tweet: "Test tweet")
    }

    private var youTubePost: PublishToYouTubePost {
        return PublishToYouTubePost(
            title: "Test YouTube post",
            description: "Test YouTube description",
            tags: ["test", "tags"],
            privacy: .public,
            categoryID: 6789
        )
    }

    // MARK: - Tests

    func test_fetchPublishJobRequest_returnsExpectedMethod_andURI() {
        let request = Request<PublishJob>.fetchPublishJob(for: "12345")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.URI, "/videos/12345/publish_to_social")
    }

    func test_publishPostRequest_forFacebookPost_returnsRequest_withExpectedParameters() throws {
        let socialMediaPosts = SocialMediaPosts(facebook: facebookPost)
        let request = Request<PublishJob>.publishPosts(socialMediaPosts, for: "12345")

        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/videos/12345/publish_to_social")

        let parameters = try XCTUnwrap(request.parameters as? [String: Any])

        XCTAssertNil(parameters["youtube"])
        XCTAssertNil(parameters["linkedin"])
        XCTAssertNil(parameters["twitter"])
        XCTAssertNotNil(parameters["facebook"])

        let facebookParameters = try XCTUnwrap(parameters["facebook"] as? [String: AnyHashable])
        XCTAssertEqual(facebookParameters["title"], facebookPost.title)
        XCTAssertEqual(facebookParameters["description"], facebookPost.description)
        XCTAssertEqual(facebookParameters["destination"], facebookPost.destination)
        XCTAssertEqual(facebookParameters["category_id"], facebookPost.categoryID)
        XCTAssertEqual(facebookParameters["allow_embedding"], facebookPost.allowEmbedding)
        XCTAssertEqual(facebookParameters["should_appear_on_news_feed"], facebookPost.shouldAppearOnNewsFeed)
        XCTAssertEqual(facebookParameters["is_secret_video"], facebookPost.isSecretVideo)
        XCTAssertEqual(facebookParameters["allow_social_actions"], facebookPost.allowSocialActions)
    }

    func test_publishPostRequest_forLinkedInPost_returnsRequest_withExpectedParameters() throws {
        let socialMediaPosts = SocialMediaPosts(linkedIn: linkedInPost)
        let request = Request<PublishJob>.publishPosts(socialMediaPosts, for: "56789")

        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/videos/56789/publish_to_social")

        let parameters = try XCTUnwrap(request.parameters as? [String: Any])

        XCTAssertNil(parameters["facebook"])
        XCTAssertNil(parameters["twitter"])
        XCTAssertNil(parameters["youtube"])
        XCTAssertNotNil(parameters["linkedin"])

        let linkedInParameters = try XCTUnwrap(parameters["linkedin"] as? [String: AnyHashable])
        XCTAssertEqual(linkedInParameters["page_id"], linkedInPost.pageID)
        XCTAssertEqual(linkedInParameters["title"], linkedInPost.title)
        XCTAssertEqual(linkedInParameters["description"], linkedInPost.description)
    }

    func test_publishPostRequest_forTwitterPost_returnsRequest_withExpectedParameters() throws {
        let socialMediaPosts = SocialMediaPosts(twitter: twitterPost)
        let request = Request<PublishJob>.publishPosts(socialMediaPosts, for: "56789")

        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/videos/56789/publish_to_social")

        let parameters = try XCTUnwrap(request.parameters as? [String: Any])

        XCTAssertNil(parameters["facebook"])
        XCTAssertNil(parameters["linkedin"])
        XCTAssertNil(parameters["youtube"])
        XCTAssertNotNil(parameters["twitter"])

        let twitterParameters = try XCTUnwrap(parameters["twitter"] as? [String: AnyHashable])
        XCTAssertEqual(twitterParameters["tweet"], twitterPost.tweet)
    }

    func test_publishPostRequest_forYouTubePost_returnsRequest_withExpectedParameters() throws {
        let socialMediaPosts = SocialMediaPosts(youTube: youTubePost)
        let request = Request<PublishJob>.publishPosts(socialMediaPosts, for: "34567")

        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/videos/34567/publish_to_social")

        let parameters = try XCTUnwrap(request.parameters as? [String: Any])

        XCTAssertNil(parameters["facebook"])
        XCTAssertNil(parameters["linkedin"])
        XCTAssertNil(parameters["twitter"])
        XCTAssertNotNil(parameters["youtube"])

        let youtubeParameters = try XCTUnwrap(parameters["youtube"] as? [String: AnyHashable])
        XCTAssertEqual(youtubeParameters["title"], youTubePost.title)
        XCTAssertEqual(youtubeParameters["description"], youTubePost.description)
        XCTAssertEqual(youtubeParameters["tags"], ["test", "tags"])
        XCTAssertEqual(youtubeParameters["privacy"], youTubePost.privacy.rawValue)
        XCTAssertEqual(youtubeParameters["category_id"], youTubePost.categoryID)
    }

    func test_publishPostRequests_forAllPlatformPosts_returnsRequest_withNonNillPostParameters() throws {
        let socialMediaPosts = SocialMediaPosts(
            facebook: facebookPost,
            linkedIn: linkedInPost,
            twitter: twitterPost,
            youTube: youTubePost
        )

        let request = Request<PublishJob>.publishPosts(socialMediaPosts, for: "89012")

        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/videos/89012/publish_to_social")

        let parameters = try XCTUnwrap(request.parameters as? [String: Any])

        XCTAssertNotNil(parameters["facebook"])
        XCTAssertNotNil(parameters["linkedin"])
        XCTAssertNotNil(parameters["twitter"])
        XCTAssertNotNil(parameters["youtube"])
    }

    func test_socialMediaPosts_mayBeAddedAfterInstantiation() {
        var socialMediaPosts = SocialMediaPosts()
        socialMediaPosts.facebook = facebookPost
        socialMediaPosts.twitter = twitterPost

        XCTAssertNotNil(socialMediaPosts.facebook)
        XCTAssertNotNil(socialMediaPosts.twitter)
        XCTAssertNil(socialMediaPosts.linkedIn)
        XCTAssertNil(socialMediaPosts.youTube)
    }
}
