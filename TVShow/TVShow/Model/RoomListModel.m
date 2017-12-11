//
//  RoomListModel.m
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import "RoomListModel.h"

@implementation RoomListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        [super setValue:value forKey:@"roomid"];
    }else if ([value isKindOfClass:[NSDictionary class]]){
        [super setValue:value forKey:key];
    }else{
        [super setValue:[NSString stringWithFormat:@"%@", value] forKey:key];
    }
}

@end
