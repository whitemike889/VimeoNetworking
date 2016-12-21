//
//  VIMVODGenre.h
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 12/19/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#import <VimeoNetworking/VimeoNetworking.h>

@interface VIMVODGenre : VIMModelObject

@property (nonatomic, copy, nullable) NSString *uri;
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *canonical;
@property (nonatomic, copy, nullable) NSString *link;
@property (nonatomic, strong, nullable) NSDictionary *connections;

- (nullable VIMConnection *)connectionWithName:(nonnull NSString *)connectionName;

@end
