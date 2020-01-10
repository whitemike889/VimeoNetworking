//
//  PublishToSocialPostsTests.swift
//  VimeoNetworking
//
//  Created by Hawkins, Jason on 1/10/20.
//  Copyright © 2020 Vimeo. All rights reserved.
//

import XCTest
import VimeoNetworking

class PublishToSocialPostsTests: XCTestCase {
    func test_publishToFacebookPost_canBeCreatedSuccessfully() {
        let facebookPost = PublishToFacebookPost(
            title: "Hello",
            description: "This is only a test",
            pageID: 12345,
            categoryID: 3,
            allowEmbedding: true,
            shouldAppearOnNewsFeed: true,
            isSecretVideo: false,
            allowSocialActions: true
        )

        XCTAssertEqual(facebookPost.title, "Hello")
        XCTAssertEqual(facebookPost.description, "This is only a test")
        XCTAssertEqual(facebookPost.pageID, 12345)
        XCTAssertEqual(facebookPost.categoryID, 3)
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
            categoryID: 987
        )

        XCTAssertEqual(youTubePost.title, "How to Publish Everywhere With a Single Click")
        XCTAssertEqual(youTubePost.description, "Learn everything you need to know right here.")
        XCTAssertEqual(youTubePost.tags?.count, 3)
        XCTAssertEqual(youTubePost.tags, ["Vimeo", "Publish", "Educational"])
        XCTAssertEqual(youTubePost.privacy, .public)
        XCTAssertEqual(youTubePost.categoryID, 987)
    }

    func test_socailMediaPostsObject_canBeCreatedSuccessfully() {
        let youTubePost = PublishToYouTubePost(
            title: "How to Publish Everywhere With a Single Click",
            description: "Learn everything you need to know right here.",
            tags: ["Vimeo", "Publish", "Educational"],
            privacy: .public,
            categoryID: 987
        )

        var posts = SocialMediaPosts(youTube: youTubePost)
        XCTAssertNotNil(posts.youTube)
        XCTAssertEqual(posts.youTube?.title, "How to Publish Everywhere With a Single Click")
        XCTAssertEqual(posts.youTube?.description, "Learn everything you need to know right here.")
        XCTAssertEqual(posts.youTube?.tags?.count, 3)
        XCTAssertEqual(posts.youTube?.tags, ["Vimeo", "Publish", "Educational"])
        XCTAssertEqual(posts.youTube?.privacy, .public)
        XCTAssertEqual(posts.youTube?.categoryID, 987)

        XCTAssertNil(posts.facebook)
        XCTAssertNil(posts.linkedIn)
        XCTAssertNil(posts.twitter)

        let twitterPost = PublishToTwitterPost(tweet: "Test tweet.")
        posts.twitter = twitterPost

        XCTAssertNotNil(posts.twitter)
        XCTAssertNotNil(posts.youTube)
        XCTAssertNil(posts.linkedIn)
        XCTAssertNil(posts.facebook)
        XCTAssertEqual(posts.twitter?.tweet, "Test tweet.")
    }
}
