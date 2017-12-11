//
//  VideoInfoModel.h
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoInfoModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, copy) NSDictionary *stream_addr;
/**
 拼接直播地址需要
 */
@property (nonatomic, strong) NSString *room_key;
@property (nonatomic, strong) NSString *plflag;
@property (nonatomic, strong) NSString *status;
/**
 拼接直播地址需要
 */
@property (nonatomic, strong) NSString *sign;
/**
 拼接直播地址需要
 */
@property (nonatomic, strong) NSString *ts;
@property (nonatomic, strong) NSString *hardware;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSArray *slaveflag;
@property (nonatomic, strong) NSString *watermark;

@end
