//
//  NSErrorExtensionTests.swift
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 7/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import XCTest

class NSErrorExtensionTests: XCTestCase {
    
    var testApiError: NSError!
    
    override func setUp() {
        super.setUp()
        
        let fakeErrorJSON = ["link": NSNull(),
                             "error": "You have provided an invalid parameter. Please contact developer of this application.",
                             "developer_message": "The parameters passed to this API endpoint did not pass Vimeo\'s validation. Please check the invalid_parameters list for more information",
                             "error_code": 2204,
                             "invalid_parameters": [
                                    ["developer_message": "Password and/or email provided are invalid",
                                     "error": "Unable to log in Please enter a valid email address and/or password",
                                     "error_code": 2218,
                                     "field": "password"
                                    ]
                                ]
                            ]
        
        let fakeErrorData = try! NSJSONSerialization.dataWithJSONObject(fakeErrorJSON, options: NSJSONWritingOptions.init(rawValue: 0))
        
        let userInfo = [NSLocalizedDescriptionKey: "Request failed: bad request (400)", "com.alamofire.serialization.response.error.data": fakeErrorData]
        self.testApiError = NSError(domain: "com.vimeo.networking-test", code: -1011, userInfo: userInfo)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVimeoInvalidParametersErrorCodes() {
        XCTAssertEqual(self.testApiError.vimeoInvalidParametersErrorCodes.count, 1)
        XCTAssertEqual(self.testApiError.vimeoInvalidParametersErrorCodes[0], 2218)
    }
    
    func testVimeoInvalidParametersFirstErrorCode() {
        XCTAssertEqual(self.testApiError.vimeoInvalidParametersFirstErrorCode, 2218)
    }
    
    func testVimeoInvalidParametersErrorCodesString() {
        XCTAssertEqual(self.testApiError.vimeoInvalidParametersErrorCodesString, "2218")
    }
    
    func testVimeoUserMessage() {
        XCTAssertEqual(self.testApiError.vimeoUserMessage, "You have provided an invalid parameter. Please contact developer of this application.")
    }
    
    func testVimeoDeveloperMessage() {
        XCTAssertEqual(self.testApiError.vimeoDeveloperMessage, "The parameters passed to this API endpoint did not pass Vimeo\'s validation. Please check the invalid_parameters list for more information")
    }
    
    func testVimeoServerErrorCode() {
        XCTAssertNotNil(self.testApiError.vimeoServerErrorCode)
        XCTAssertEqual(self.testApiError.vimeoServerErrorCode!, 2204)
    }
    
    func testLocalizedDescription() {
        XCTAssertEqual(self.testApiError.localizedDescription, "Request failed: bad request (400)")
    }
    
    func testErrorResponseBodyJSON() {
        XCTAssertNotNil(self.testApiError.errorResponseBodyJSON)
        
        let invalidParameters = self.testApiError.errorResponseBodyJSON!["invalid_parameters"]
        XCTAssertNotNil(invalidParameters)
        
        XCTAssertNotNil(invalidParameters as? NSArray)
        
        let invalidParamsDict = invalidParameters![0]
        XCTAssertEqual(invalidParamsDict["error"], "Unable to log in Please enter a valid email address and/or password")
        XCTAssertEqual(invalidParamsDict["developer_message"], "Password and/or email provided are invalid")
        XCTAssertEqual(invalidParamsDict["error_code"], 2218)
        XCTAssertEqual(invalidParamsDict["field"], "password")
    }
    
    func testVimeoInvalidParametersFirstVimeoUserMessage() {
        XCTAssertEqual(self.testApiError.vimeoInvalidParametersFirstVimeoUserMessage, "Unable to log in Please enter a valid email address and/or password")
    }
    
}
