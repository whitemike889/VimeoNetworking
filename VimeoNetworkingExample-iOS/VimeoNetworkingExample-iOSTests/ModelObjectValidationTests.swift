//
//  ModelObjectValidationTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 5/17/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworkingExample_iOS

class ModelObjectValidationTests: XCTestCase
{
    func testValidVideoPassesValidation()
    {
        let video = VIMVideo()
        
        video.uri = "/videos/1234567"
        video.resourceKey = "1234567:abcdef"
        
        do
        {
            try video.validateModel()
        }
        catch let error as NSError
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testVideoWithNilURIFailsValidation()
    {
        let video = VIMVideo()
        
        video.uri = nil
        video.resourceKey = "1234567:abcdef"
        
        do
        {
            try video.validateModel()
            
            XCTFail("Video with nil URI should have failed validation")
        }
        catch let error as NSError
        {
            XCTAssertEqual(error.code, VIMModelObjectValidationErrorCode)
        }
    }
    
    func testVideoWithNilResourceKeyFailsValidation()
    {
        let video = VIMVideo()
        
        video.uri = "/videos/1234567"
        video.resourceKey = nil
        
        do
        {
            try video.validateModel()
            
            XCTFail("Video with nil resourceKey should have failed validation")
        }
        catch let error as NSError
        {
            XCTAssertEqual(error.code, VIMModelObjectValidationErrorCode)
        }
    }
    
    func testValidUserPassesValidation()
    {
        let user = VIMUser()
        
        user.uri = "/users/1234567"
        
        do
        {
            try user.validateModel()
        }
        catch let error as NSError
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUserWithNilURIFailsValidation()
    {
        let user = VIMUser()
        
        user.uri = nil
        
        do
        {
            try user.validateModel()
            
            XCTFail("User with nil URI should have failed validation")
        }
        catch let error as NSError
        {
            XCTAssertEqual(error.code, VIMModelObjectValidationErrorCode)
        }
    }
}
