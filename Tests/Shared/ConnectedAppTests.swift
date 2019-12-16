//
//  ConnectedAppTests.swift
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

class ConnectedAppTests: XCTestCase {
    func test_isDataAccessExpired_returnsTrue_whenTypeIsFacebook_andDataAccessIsExpired() throws {
        let json: [String: Any] = [
            "type": "facebook",
            "data_access_is_expired": true
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type, .facebook)
        XCTAssertTrue(connectedApp.isDataAccessExpired)
    }
    
    func test_isDataAccessExpired_returnsFalse_whenTypeIsFacebook_andDataAccessIsNotExpired() throws {
        let json: [String: Any] = [
            "type": "facebook",
            "data_access_is_expired": false
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type, .facebook)
        XCTAssertFalse(connectedApp.isDataAccessExpired)
    }
    
    func test_isDataAccessExpired_returnsFalse_whenTypeIsNotFacebook() throws {
        let json: [String: Any] = [
            "type": "youtube",
            "data_access_is_expired": true
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertNotEqual(connectedApp.type, .facebook)
        XCTAssertEqual(connectedApp.type, .youtube)
        XCTAssertFalse(connectedApp.isDataAccessExpired)
    }
    
    func test_isDataAccessExpired_returnsTrue_whenDataAccessIsExpired_isMissingFromResponse() throws {
        let json: [String: Any] = [
            "type": "facebook"
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertTrue(connectedApp.isDataAccessExpired)
    }
    
    func test_connectedAppType_returnsExpectedStringValue_forFacebookAppType() throws {
        let json: [String: Any] = [
            "type": "facebook"
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "facebook")
    }
    
    func test_connectedAppType_returnsExpectedStringValue_forYouTubeAppType() throws {
        let json: [String: Any] = [
            "type": "youtube"
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "youtube")
    }
    
    func test_connectedAppType_returnsExpectedStringValue_forTwitterAppType() throws {
        let json: [String: Any] = [
            "type": "twitter"
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "twitter")
    }
    
    func test_connectedAppType_returnsExpectedStringValue_forLinkedInAppType() throws {
        let json: [String: Any] = [
            "type": "linkedin"
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "linkedin")
    }
    
    func test_connectedAppType_returnsNil_whenTypeIsUnexpected() throws {
        let json: [String: Any] = [
            "type": "friendster"
        ]
        let connectedApp = try VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertNil(connectedApp.type)
        XCTAssertNil(connectedApp.type?.stringValue)
    }
    
    func test_connectedApp_returnsExpectedPublishCategories_fromInputPublishOptionItems() throws {
        let artDict: [String: Any] = [
            "identifier": 12345,
            "name": "art"
        ]
        let vacationDict: [String: Any] = [
            "identifier": 67890,
            "name": "vacation"
        ]
        
        let art = PublishOptionItem(keyValueDictionary: artDict)
        let vacation = PublishOptionItem(keyValueDictionary: vacationDict)
        
        let connectedAppDict: [String: Any] = [
            "publishCategories": [art, vacation] as Any
        ]
        let connectedApp = try XCTUnwrap(ConnectedApp(keyValueDictionary: connectedAppDict))
        
        XCTAssertNotNil(connectedApp.publishCategories)
        XCTAssertEqual(connectedApp.publishCategories?.count, 2)
        XCTAssertEqual(try XCTUnwrap(connectedApp.publishCategories)[0].name, "art")
        XCTAssertEqual(try XCTUnwrap(connectedApp.publishCategories)[0].identifier, 12345)
        XCTAssertEqual(try XCTUnwrap(connectedApp.publishCategories)[1].name, "vacation")
        XCTAssertEqual(try XCTUnwrap(connectedApp.publishCategories)[1].identifier, 67890)
    }

    func test_connectedAppsArray_parsedCorrectly_fromJSONFixture() throws {
        guard let jsonDictionary = ResponseUtilities.loadResponse(
            from: "connected-app.json"
        ) else {
            XCTFail()
            return
        }

        let connectedApps = try XCTUnwrap(
            VIMObjectMapper.mapObject(
                responseDictionary: jsonDictionary,
                modelKeyPath: "data"
            ) as [ConnectedApp]
        )

        XCTAssertNotNil(connectedApps)
        XCTAssertTrue(connectedApps.count == 2)

        let facebookApp = connectedApps[0]
        XCTAssertNotNil(facebookApp)
        XCTAssertEqual(facebookApp.type, .facebook)
        XCTAssertEqual(facebookApp.typeString, "facebook")
        XCTAssertEqual(facebookApp.thirdPartyUserID, "123456789")
        XCTAssertEqual(facebookApp.thirdPartyUserDisplayName, "Dr. Vimeo")
        XCTAssertEqual(facebookApp.uri, "/me/connected_apps/facebook")
        XCTAssertTrue(facebookApp.pages?.count == 0)
        XCTAssertTrue(facebookApp.neededScopes?.publishToSocial?.count == 0)
        XCTAssertEqual(facebookApp.publishCategories?.count, 19)
        XCTAssertFalse(try XCTUnwrap(facebookApp.dataAccessIsExpired?.boolValue))

        let youtubeApp = connectedApps[1]
        XCTAssertNotNil(youtubeApp)
        XCTAssertEqual(youtubeApp.type, .youtube)
        XCTAssertEqual(youtubeApp.typeString, "youtube")
        XCTAssertEqual(youtubeApp.thirdPartyUserID, "123456789")
        XCTAssertEqual(youtubeApp.thirdPartyUserDisplayName, "Dr. Vimeo")
        XCTAssertEqual(youtubeApp.uri, "/me/connected_apps/youtube")
        XCTAssertTrue(youtubeApp.pages?.count == 0)
        XCTAssertTrue(youtubeApp.neededScopes?.publishToSocial?.count == 0)
        XCTAssertEqual(youtubeApp.publishCategories?.count, 15)
        XCTAssertFalse(try XCTUnwrap(youtubeApp.dataAccessIsExpired?.boolValue))
    }

    func test_facebookConnectedApp_parsesCorrectly_fromJSONFixture() throws {
        guard let json = ResponseUtilities.loadResponse(
            from: "connected-app-facebook.json"
        ) else {
            XCTFail()
            return
        }

        let facebookApp = try XCTUnwrap(
            VIMObjectMapper.mapObject(
                responseDictionary: json
            ) as ConnectedApp
        )

        XCTAssertNotNil(facebookApp)
        XCTAssertEqual(facebookApp.type, .facebook)
        XCTAssertEqual(facebookApp.typeString, "facebook")
        XCTAssertEqual(facebookApp.thirdPartyUserID, "123456789")
        XCTAssertEqual(facebookApp.thirdPartyUserDisplayName, "Dr. Vimeo")
        XCTAssertEqual(facebookApp.uri, "/me/connected_apps/facebook")
        XCTAssertTrue(facebookApp.pages?.count == 0)
        XCTAssertTrue(facebookApp.neededScopes?.publishToSocial?.count == 0)
        XCTAssertEqual(facebookApp.publishCategories?.count, 19)
        XCTAssertFalse(try XCTUnwrap(facebookApp.dataAccessIsExpired?.boolValue))
    }

    func test_youtubeConnectedApp_parsesCorrectly_fromJSONFixture() throws {
        guard let json = ResponseUtilities.loadResponse(
            from: "connected-app-youtube.json"
        ) else {
            XCTFail()
            return
        }

        let youtubeApp = try XCTUnwrap(
            VIMObjectMapper.mapObject(
                responseDictionary: json
            ) as ConnectedApp
        )

        XCTAssertNotNil(youtubeApp)
        XCTAssertEqual(youtubeApp.type, .youtube)
        XCTAssertEqual(youtubeApp.typeString, "youtube")
        XCTAssertEqual(youtubeApp.thirdPartyUserID, "123456789")
        XCTAssertEqual(youtubeApp.thirdPartyUserDisplayName, "Dr. Vimeo")
        XCTAssertEqual(youtubeApp.uri, "/me/connected_apps/youtube")
        XCTAssertTrue(youtubeApp.pages?.count == 0)
        XCTAssertTrue(youtubeApp.neededScopes?.publishToSocial?.count == 0)
        XCTAssertEqual(youtubeApp.publishCategories?.count, 15)
        XCTAssertFalse(try XCTUnwrap(youtubeApp.dataAccessIsExpired?.boolValue))
    }
}
