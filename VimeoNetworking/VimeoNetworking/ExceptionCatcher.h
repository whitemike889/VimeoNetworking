//
//  ExceptionCatcher.h
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/26/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExceptionCatcher : NSObject

+ (nullable NSError *)_doUnsafe:(nonnull void(^)(void))unsafeBlock;

@end
