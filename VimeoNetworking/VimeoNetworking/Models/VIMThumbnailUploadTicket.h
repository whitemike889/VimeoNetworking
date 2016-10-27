//
//  VIMThumbnailUploadTicket.h
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 6/28/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

#include "VIMModelObject.h"

@interface VIMThumbnailUploadTicket : VIMModelObject

@property (nonatomic, copy, nullable) NSString *uri;
@property (nonatomic, copy, nullable) NSString *link;
@property (nonatomic, copy, nullable) NSString *resourceKey;

@end
