//
//  VIMSoundtrack.h
//  VimeoNetworking
//
//  Created by Westendorf, Michael on 4/26/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

@import VIMObjectMapper;

@interface VIMSoundtrack : VIMModelObject

@property (nonatomic, copy, nullable) NSString *status;
@property (nonatomic, copy, nullable) NSString *audioUrl;
@property (nonatomic, copy, nullable) NSString *thumbUrl;
@property (nonatomic, copy, nullable) NSString *urlArtist;
@property (nonatomic, copy, nullable) NSString *urlItunes;
@property (nonatomic, copy, nullable) NSString *streamUrl;
@property (nonatomic, copy, nullable) NSString *track;
@property (nonatomic, copy, nullable) NSString *thumbUrl_billboard;
@property (nonatomic, copy, nullable) NSString *artist;
@property (nonatomic, copy, nullable) NSString *coverColor;
@property (nonatomic, copy, nullable) NSString *soundtrackHash;
@property (nonatomic, copy, nullable) NSString *thumbUrlFeatured;
@property (nonatomic, copy, nullable) NSString *genre;
@property (nonatomic, copy, nullable) NSString *album;
@property (nonatomic, copy, nullable) NSString *soundtrackDescription;

@property (nonatomic, strong, nullable) NSNumber *orderBillboard;
@property (nonatomic, strong, nullable) NSDate *added;
@property (nonatomic, strong, nullable) NSNumber *orderFeatured;

@property (nonatomic, assign) BOOL billboard;
@property (nonatomic, assign) BOOL featured;

@end
