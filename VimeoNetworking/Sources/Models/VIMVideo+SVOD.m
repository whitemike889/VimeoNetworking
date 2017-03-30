//
//  VIMVideo+SVOD.m
//  Pods
//
//  Created by Lim, Jennifer on 3/30/17.
//
//

#import "VIMVideo+SVOD.h"
#import "VIMConnection.h"
#import "VIMInteraction.h"

@implementation VIMVideo (SVOD)

- (BOOL)isSVOD
{
    VIMInteraction *interation = [self interactionWithName:VIMInteractionNameSVOD];
    
    return interation != nil;
}

- (VIMVideoSVODAccess)svodAccess
{
    VIMInteraction *interation = [self interactionWithName:VIMInteractionNameSVOD];
    
    if (interation != nil)
    {
        if ([interation.status isEqualToString:VIMSVODStatus_NotPurchased])
        {
            return VIMVideoSVODAccessNotPurchased;
        }
        else if ([interation.status isEqualToString:VIMSVODStatus_MonthlySubscription])
        {
            return VIMVideoSVODAccessMonthly;
        }
        else
        {
            return VIMVideoSVODAccessUnknown;
        }
    }
}

@end
