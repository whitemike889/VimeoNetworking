//
//  NSStringCharValueTests.m
//  VimeoNetworking-iOSTests
//
//  Created by Rogerio de Paula Assis on 7/8/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSStringCharValueTests : XCTestCase
@end

/// This class tests for device compatibility with the dynamic parsing done through `VIMModelObject`.
/// On 32 bit devices, BOOL is defined as `char`, whereas on other devices it is defined as `bool`.
/// This causes our dynamic parser to trip on `true` values passed by the API. These get bridged
/// as `__NSCFString`. When we call `set(value, forKey:key)` where the key type is a BOOL, the system
/// automatically tries to call `charValue` on NSString which causes the app to crash with an
/// unrecognized selector sent to instance message.
/// The solution we found was to extend `NSString` vai category to respond to `charValue` only in
/// environments where `OBJC_BOOL_IS_CHAR` is defined.
/// For more information on `OBJC_BOOL_IS_CHAR` see the Objective-C runtime header `objc.h`
/// More discussion, comments and proposed solutions here https://stackoverflow.com/a/32146513

@implementation NSStringCharValueTests

#if defined(OBJC_BOOL_IS_CHAR)

- (void)testNSStringRespondsToCharValueOn32BitDevices {
    BOOL respondsToSelector = [[NSString new] respondsToSelector:@selector(charValue)];
    XCTAssertTrue(respondsToSelector);
}

- (void)testCharValueIsTrue {
    id trueString = @"true";
    BOOL trueValue = [trueString charValue];
    XCTAssertTrue(trueValue);
}

- (void)testCharValueIsFalse {
    id falseString = @"false";
    BOOL falseValue = [falseString charValue];
    XCTAssertFalse(falseValue);
    
    falseString = @"other value";
    falseValue = [falseString charValue];
    XCTAssertFalse(falseValue);
}

#else

- (void)testNSString_DOES_NOT_RespondsToCharValueOnOtherDevices {
    BOOL respondsToSelector = [[NSString new] respondsToSelector:@selector(charValue)];
    XCTAssertFalse(respondsToSelector);
}

#endif

@end

