//
//  VIMNotification.m
//  Pods
//
//  Created by Fiel Guhit on 1/20/17.
//  Copyright (c) 2014-2017 Vimeo (https://vimeo.com)
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

#import "VIMNotification.h"
#import "VIMVideo.h"
#import "VIMUser.h"
#import "VIMCredit.h"

@implementation VIMNotification

#pragma mark - <VIMMappable>

- (id)getObjectMapping
{
     return @{@"clip": @"video"};
}

- (Class)getClassForObjectKey:(NSString *)key
{
    if ([key isEqualToString:@"clip"])
    {
        return [VIMVideo class];
    }
    
    if ([key isEqualToString:@"user"])
    {
        return [VIMUser class];
    }
    
    if ([key isEqualToString:@"credit"])
    {
        return [VIMCredit class];
    }
    
    return nil;
}

- (void)didFinishMapping
{
    if ([self.createdTime isKindOfClass:[NSString class]])
    {
        self.createdTime = [[VIMModelObject dateFormatter] dateFromString:(NSString *)self.createdTime];
    }
    
    [self setNotificationType];
}

- (void)setNotificationType
{
    VIMNotificationType notificationType = VIMNotificationTypeNone;
    
    if (self.type)
    {
        NSDictionary *enumMap = @{@"comment" : @(VIMNotificationTypeComment),
                                  @"credit" : @(VIMNotificationTypeCredit),
                                  @"follow" : @(VIMNotificationTypeFollow),
                                  @"like" : @(VIMNotificationTypeLike),
                                  @"mention" : @(VIMNotificationTypeMention),
                                  @"reply" : @(VIMNotificationTypeReply),
                                  @"share" : @(VIMNotificationTypeShare),
                                  @"video_available" : @(VIMNotificationTypeVideoAvailable),
                                  @"vod_preorder_available" : @(VIMNotificationTypeVODPreorderAvailable),
                                  @"vod_rental_expiration_warning" : @(VIMNotificationTypeVODRentalExpirationWarning),
                                  @"vod_purchase" : @(VIMNotificationTypeVODPurchase),
                                  @"account_expiration_warning" : @(VIMNotificationTypeAccountExpirationWarning),
                                  @"storage_warning" : @(VIMNotificationTypeStorageWarning)};
        
        NSNumber *notificationNumber = enumMap[self.type];
        if (notificationNumber)
        {
            notificationType = [notificationNumber unsignedIntegerValue];
        }
    }
    
    self.notificationType = notificationType;
}

@end
