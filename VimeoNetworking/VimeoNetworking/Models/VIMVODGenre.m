//
//  VIMVODGenre.m
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 12/19/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import "VIMVODGenre.h"

@interface VIMVODGenre ()

@end

@implementation VIMVODGenre

#pragma mark - Public API

- (VIMConnection *)connectionWithName:(NSString *)connectionName
{
    return [self.connections objectForKey:connectionName];
}

#pragma mark - VIMMappable

- (void)didFinishMapping
{
    [self parseConnections];
}

#pragma mark - Parsing Helpers

- (void)parseConnections
{
    NSMutableDictionary *connections = [NSMutableDictionary dictionary];
    
    NSDictionary *dict = self.connections;
    if([dict isKindOfClass:[NSDictionary class]])
    {
        for(NSString *key in [dict allKeys])
        {
            NSDictionary *value = [dict valueForKey:key];
            if([value isKindOfClass:[NSDictionary class]])
            {
                VIMConnection *connection = [[VIMConnection alloc] initWithKeyValueDictionary:value];
                if([connection respondsToSelector:@selector(didFinishMapping)])
                    [connection didFinishMapping];
                
                [connections setObject:connection forKey:key];
            }
        }
    }
    
    self.connections = connections;
}

@end
