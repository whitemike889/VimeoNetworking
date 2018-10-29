//
//  AlbumTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Hawkins, Jason on 10/26/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class AlbumTests: XCTestCase {
    private var testAlbum: Album?
    private var albumJSONDictionary: VimeoClient.ResponseDictionary?

    override func setUp() {
        guard let albumJSONDictionary = ResponseUtilities.loadResponse(from: "album-response.json") else {
            return
        }
        
        self.albumJSONDictionary = albumJSONDictionary
        self.testAlbum = try! VIMObjectMapper.mapObject(responseDictionary: albumJSONDictionary) as Album
    }

    override func tearDown() {
        self.testAlbum = nil
        self.albumJSONDictionary = nil
    }

    func test_AlbumObject_ParsesCorrectly() {
        guard let album = self.testAlbum else {
            assertionFailure("Failed to unwrap the test album.")
            return
        }
        
        XCTAssertEqual(album.albumName, "2018")
        XCTAssertEqual(album.albumDescription, "Favorites from 2018.")
        XCTAssertEqual(album.albumLogo?.uri, "/users/267176/albums/5451829/logos/18363")
        XCTAssertEqual(album.privacy?.view, "anybody")
        XCTAssertEqual(album.duration, 1003)
        XCTAssertEqual(album.uri, "/users/267176/albums/5451829")
        XCTAssertEqual(album.link, "https://vimeo.com/album/5451829")
        XCTAssertNotNil(album.embed?.html)
        XCTAssertNotNil(album.pictures)
        XCTAssertNotNil(album.user)
        XCTAssertEqual(album.theme, "dark")
    }
    
    func test_AlbumDates_ParseAndFormatCorrectly() {
        guard let album = self.testAlbum else {
            assertionFailure("Failed to unwrap the test album.")
            return
        }
        
        XCTAssertNotNil(album.createdTimeString)
        XCTAssertEqual(album.createdTime!.timeIntervalSince1970, TimeInterval(1538405413))
        XCTAssertNotNil(album.modifiedTimeString)
        XCTAssertEqual(album.modifiedTime!.timeIntervalSince1970, TimeInterval(1540585280))
    }
    
    func test_AlbumLogoOjbect_ParsesCorrectly() {
        guard let album = self.testAlbum else {
            assertionFailure("Failed to unwrap the test album.")
            return
        }
        
        guard let logo = album.albumLogo?.pictures?.first as? VIMPicture else {
            assertionFailure("Failed to unwrap the test album's logo.")
            return
        }
        
        XCTAssertEqual(logo.width, 200)
        XCTAssertEqual(logo.height, 200)
        XCTAssertEqual(logo.link, "https://i.vimeocdn.com/album_custom_logo/18363_200x200")
    }
    
    func test_AlbumEmbedObject_ParsesCorrectly() {
        guard let album = self.testAlbum else {
            assertionFailure("Failed to unwrap the test album.")
            return
        }
        
        XCTAssertNotNil(album.embed)
        XCTAssertEqual(album.embed?.html,
"""
<div style='padding:56.25% 0 0 0;position:relative;'><iframe src='https://vimeo.com/album/5451829/embed' allowfullscreen frameborder='0' style='position:absolute;top:0;left:0;width:100%;height:100%;'></iframe></div>
""")
    }
}
