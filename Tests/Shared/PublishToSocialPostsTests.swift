//
//  PublishToSocialPostsTests.swift
//  VimeoNetworking
//
//  Copyright © 2020 Vimeo. All rights reserved.
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
import VimeoNetworking

class PublishToSocialPostsTests: XCTestCase {
    func test_publishToFacebookPost_canBeCreatedSuccessfully() {
        let facebookPost = PublishToFacebookPost(
            title: "Hello",
            description: "This is only a test",
            destination: 12345,
            categoryID: "Fashion",
            allowEmbedding: true,
            shouldAppearOnNewsFeed: true,
            isSecretVideo: false,
            allowSocialActions: true
        )

        XCTAssertEqual(facebookPost.title, "Hello")
        XCTAssertEqual(facebookPost.description, "This is only a test")
        XCTAssertEqual(facebookPost.destination, 12345)
        XCTAssertEqual(facebookPost.categoryID, "Fashion")
        XCTAssertTrue(facebookPost.allowEmbedding)
        XCTAssertTrue(facebookPost.shouldAppearOnNewsFeed)
        XCTAssertFalse(facebookPost.isSecretVideo)
        XCTAssertTrue(facebookPost.allowSocialActions)
    }

    func test_publishToLinkedInPost_canBeCreatedSuccessfull() {
        let linkedInPost = PublishToLinkedInPost(
            pageID: 1234,
            title: "Important Information",
            description: "You are facing the wrong way."
        )

        XCTAssertEqual(linkedInPost.pageID, 1234)
        XCTAssertEqual(linkedInPost.title, "Important Information")
        XCTAssertEqual(linkedInPost.description, "You are facing the wrong way.")
    }

    func test_publishToTwitterPost_canBeCreatedSuccessfully() {
        let twitterPost = PublishToTwitterPost(
            tweet: "just salad walk for lunch holla"
        )

        XCTAssertEqual(twitterPost.tweet, "just salad walk for lunch holla")
    }

    func test_publishToYouTubePost_canBeCreateSuccessfully() {
        let youTubePost = PublishToYouTubePost(
            title: "How to Publish Everywhere With a Single Click",
            description: "Learn everything you need to know right here.",
            tags: ["Vimeo", "Publish", "Educational"],
            privacy: .public,
            categoryID: "Space"
        )

        XCTAssertEqual(youTubePost.title, "How to Publish Everywhere With a Single Click")
        XCTAssertEqual(youTubePost.description, "Learn everything you need to know right here.")
        XCTAssertEqual(youTubePost.tags?.count, 3)
        XCTAssertEqual(youTubePost.tags, ["Vimeo", "Publish", "Educational"])
        XCTAssertEqual(youTubePost.privacy, .public)
        XCTAssertEqual(youTubePost.categoryID, "Space")
    }

    func test_socialMediaPostsObject_canBeCreatedSuccessfully() {
        let youTubePost = PublishToYouTubePost(
            title: "How to Publish Everywhere With a Single Click",
            description: "Learn everything you need to know right here.",
            tags: ["Vimeo", "Publish", "Educational"],
            privacy: .public,
            categoryID: "Geology"
        )

        var posts = SocialMediaPosts(youTube: youTubePost)

        XCTAssertNil(posts.facebook)
        XCTAssertNil(posts.linkedIn)
        XCTAssertNil(posts.twitter)
        XCTAssertNotNil(posts.youTube)
        XCTAssertEqual(posts.youTube?.title, "How to Publish Everywhere With a Single Click")
        XCTAssertEqual(posts.youTube?.description, "Learn everything you need to know right here.")
        XCTAssertEqual(posts.youTube?.tags?.count, 3)
        XCTAssertEqual(posts.youTube?.tags, ["Vimeo", "Publish", "Educational"])
        XCTAssertEqual(posts.youTube?.privacy, .public)
        XCTAssertEqual(posts.youTube?.categoryID, "Geology")

        let twitterPost = PublishToTwitterPost(tweet: "Test tweet.")
        posts.twitter = twitterPost

        XCTAssertNotNil(posts.twitter)
        XCTAssertNotNil(posts.youTube)
        XCTAssertNil(posts.linkedIn)
        XCTAssertNil(posts.facebook)
        XCTAssertEqual(posts.twitter?.tweet, "Test tweet.")
    }
}
