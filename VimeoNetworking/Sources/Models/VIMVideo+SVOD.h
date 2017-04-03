//
//  VIMVideo+SVOD.h
//  Pods
//
//  Created by Lim, Jennifer on 3/30/17.
//
//

#import "VIMVideo.h"

typedef NS_ENUM(NSUInteger, VIMVideoSVODAccess) {
    VIMVideoSVODAccessNotPurchased,
    VIMVideoSVODAccessMonthly,
    VIMVideoSVODAccessInvalid,
    VIMVideoSVODAccessNotSVOD
};

@interface VIMVideo (SVOD)

- (BOOL)isSVOD;
- (VIMVideoSVODAccess)svodAccess;

@end
