//
//  RoomListModel.h
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomListModel : NSObject

/**
 房间id
 */
@property (nonatomic, strong) NSString *roomid;
/**
 房间名称
 */
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *hostid;
/**
 观看人数
 */
@property (nonatomic, strong) NSString *person_num;
/**
 所属分类 -cname：英雄联盟 ename：lol
 */
@property (nonatomic, copy) NSDictionary *classification;
/**
 图片
 */
@property (nonatomic, copy) NSDictionary *pictures;
@property (nonatomic, strong) NSString *display_type;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *tag_switch;
@property (nonatomic, strong) NSString *tag_color;
@property (nonatomic, strong) NSString *style_type;
@property (nonatomic, strong) NSString *reliable;
/**
 开播状态
 */
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *stream_status;
/**
 创建时间 2017-05-13 06:48:06
 */
@property (nonatomic, strong) NSString *createtime;
/**
 开播时间 1496973308
 */
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *schedule;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *room_key;
@property (nonatomic, strong) NSString *fans;
/**
 主播信息
 "nickName": "熊猫TV黄药师",
 "rid": 81936888,
 "avatar": "http://i5.pdim.gs/a15f9cf5e162b27858b097bddc06795d.jpeg",
 "userName": ""
 */
@property (nonatomic, copy) NSDictionary *userinfo;
@property (nonatomic, copy) NSString *announcement;
@property (nonatomic, copy) NSString *duration;
@end
