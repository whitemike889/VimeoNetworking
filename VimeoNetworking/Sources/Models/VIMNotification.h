//
//  VIMNotification.h
//  Pods
//
//  Created by Guhit, Fiel on 1/19/17.
//
//

#import "VIMModelObject.h"

@interface VIMNotification : VIMModelObject

@property (nonatomic, copy, nullable) NSString *uri;
@property (nonatomic) BOOL old;
@property (nonatomic) BOOL seen;

@end
