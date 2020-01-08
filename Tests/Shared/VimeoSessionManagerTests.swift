//
//  VimeoSessionManagerTests.swift
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 7/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
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


class VimeoSessionManagerTests: XCTestCase {
    func test_VimeoSessionManager_defaultBaseUrl() {
        // Given a default base URL and configuration that doesn't specify a custom URL
        let testVimeoBaseURL = URL(string: "https://api.vimeo.com")!
        VimeoSessionManager.baseURL = testVimeoBaseURL
        let configuration = AppConfiguration(clientIdentifier: "{TEST CLIENT ID}",
                                             clientSecret: "{TEST CLIENT SECRET}",
                                             scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                             keychainService: "com.vimeo.keychain_service",
                                             apiVersion: "3.3")
        // When I create a new session manager
        let sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: configuration, configureSessionManagerBlock: nil)
        // Then it should use the default base URL
        XCTAssertEqual(sessionManager.httpSessionManager.baseURL, testVimeoBaseURL)
    }
    
    func test_VimeoSessionManager_canSetBaseUrl() {
        // Given a configuration that specifies a base URL
        let testApiServer = URL(string: "https://test.api.vimeo.com")!
        let configuration = AppConfiguration(clientIdentifier: "{TEST CLIENT ID}",
                                             clientSecret: "{TEST CLIENT SECRET}",
                                             scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                             keychainService: "com.vimeo.keychain_service",
                                             apiVersion: "3.3",
                                             baseUrl: testApiServer)
        // When I create a new session manager
        let sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: configuration, configureSessionManagerBlock: nil)
        // Then it should use the URL specified by the configuration object
        XCTAssertEqual(sessionManager.httpSessionManager.baseURL, testApiServer)
    }
    
    func test_VimeoSessionManager_canCreateTasksWithOverridenBaseUrl() {
        // Given a configuration that specifies a base URL
        let testApiServer = URL(string: "https://test.api.vimeo.com")!
        let configuration = AppConfiguration(clientIdentifier: "{TEST CLIENT ID}",
                                             clientSecret: "{TEST CLIENT SECRET}",
                                             scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                             keychainService: "com.vimeo.keychain_service",
                                             apiVersion: "3.3",
                                             baseUrl: testApiServer)

        // When I create a new session manager
        let sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: configuration, configureSessionManagerBlock: nil)
        
        let testPath = "/test/api/endpoint"
        let testUrl = testApiServer.appendingPathComponent(testPath)

        // Then the tasks created should use the base URL specified by the configuration object
        var task = sessionManager.httpSessionManager.get(testPath, parameters: nil, progress: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
        
        task = sessionManager.httpSessionManager.post(testPath, parameters: nil, progress: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
        
        task = sessionManager.httpSessionManager.put(testPath, parameters: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)

        task = sessionManager.httpSessionManager.patch(testPath, parameters: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)

        task = sessionManager.httpSessionManager.delete(testPath, parameters: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
    }
    
    func test_VimeoSessionManager_canCreateTasksWithDefaultBaseUrl() {
        // Given a default base URL and configuration that doesn't specify a custom URL
        let testVimeoBaseURL = URL(string: "https://api.vimeo.com")!
        VimeoSessionManager.baseURL = testVimeoBaseURL
        let configuration = AppConfiguration(clientIdentifier: "{TEST CLIENT ID}",
                                             clientSecret: "{TEST CLIENT SECRET}",
                                             scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                             keychainService: "com.vimeo.keychain_service",
                                             apiVersion: "3.3")

        // When I create a new session manager
        let sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: configuration, configureSessionManagerBlock: nil)
        
        let testPath = "/test/api/endpoint"
        let testUrl = testVimeoBaseURL.appendingPathComponent(testPath)

        // Then the tasks created should use the default base URL
        var task = sessionManager.httpSessionManager.get(testPath, parameters: nil, progress: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
        
        task = sessionManager.httpSessionManager.post(testPath, parameters: nil, progress: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
        
        task = sessionManager.httpSessionManager.put(testPath, parameters: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
        
        task = sessionManager.httpSessionManager.patch(testPath, parameters: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
        
        task = sessionManager.httpSessionManager.delete(testPath, parameters: nil, success: nil, failure: nil)
        XCTAssertEqual(task?.currentRequest?.url, testUrl)
    }
    
    func test_VimeoSessionManager_handleClientDidAuthenticate_setsCorrectTokenOnRequestSerializer() {
        let configuration = AppConfiguration(clientIdentifier: "{TEST CLIENT ID}",
                                             clientSecret: "{TEST CLIENT SECRET}",
                                             scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                             keychainService: "com.vimeo.keychain_service",
                                             apiVersion: "3.3")
        
        let sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: configuration, configureSessionManagerBlock: nil)
        
        let testAccount = VIMAccount()
        testAccount.accessToken = "TestAccessToken"
        
        sessionManager.clientDidAuthenticate(with: testAccount)
        
        let requestSerializer = sessionManager.jsonRequestSerializer
        
        XCTAssertEqual(requestSerializer.accessTokenProvider?(), testAccount.accessToken)
    }
    
    func test_VimeoSessionManager_handleClientDidClearAccount_clearsTokenOnRequestSerializer() {
        let configuration = AppConfiguration(clientIdentifier: "{TEST CLIENT ID}",
                                             clientSecret: "{TEST CLIENT SECRET}",
                                             scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                             keychainService: "com.vimeo.keychain_service",
                                             apiVersion: "3.3")
        
        let sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: configuration, configureSessionManagerBlock: nil)

        let testAccount = VIMAccount()
        testAccount.accessToken = "TestAccessToken"
        
        let requestSerializer = sessionManager.jsonRequestSerializer
        
        sessionManager.clientDidAuthenticate(with: testAccount)
        XCTAssertNotNil(requestSerializer.accessTokenProvider)
        
        sessionManager.clientDidClearAccount()
        XCTAssertNil(requestSerializer.accessTokenProvider)
    }
}
