//
//  VimeoClientTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Guhit, Fiel on 1/17/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworkingExample_iOS

class VimeoClientTests: XCTestCase
{
    let configuration = AppConfiguration(clientIdentifier: "13175bcf4414a49c8ce74be465c441c3daec9de9",
                                         clientSecret: "22d869d54feb4ee729b9fd87802c9cedcf3a9b71",
                                         scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                         keychainService: "com.vimeo.keychain_service",
                                         apiVersion: "3.3")
    
    lazy var client: VimeoClient =
    {
        return VimeoClient(appConfiguration: self.configuration)
    }()
    
    func testInitialCurrentAccountNotificationUserInfo()
    {
        let expectation = self.expectationWithDescription("Wait for initial account notification")
        let token: ObservationToken? = Notification.AuthenticatedAccountDidChange.observe() { [unowned self] (notification: NSNotification) in
            XCTAssert(self.client.currentAccount != nil)
            XCTAssert(notification.userInfo != nil)
            XCTAssert(notification.userInfo![UserInfoKey.PreviousAccount.rawValue] as? VIMAccount == nil)
            
            expectation.fulfill()
        }
        
        XCTAssert(token != nil)
        
        self.client.currentAccount = VIMAccount()
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
        Notification.AuthenticatedAccountDidChange.removeObserver(self)
    }
    
    func testSubsequentAccountNotificationUserInfo()
    {
        let firstAccount = VIMAccount()
        let secondAccount = VIMAccount()
        self.client.currentAccount = firstAccount
        
        let expectation = self.expectationWithDescription("Wait for subsequent account notification")
        let token: ObservationToken? = Notification.AuthenticatedAccountDidChange.observe() { (notification: NSNotification) in
            XCTAssert(notification.userInfo != nil)
            
            if let previousAccount = notification.userInfo![UserInfoKey.PreviousAccount.rawValue] as? VIMAccount {
                XCTAssert(previousAccount == firstAccount)
                expectation.fulfill()
            }
        }
        
        XCTAssert(token != nil)
        
        self.client.currentAccount = secondAccount
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
        Notification.AuthenticatedAccountDidChange.removeObserver(self)
    }
}
