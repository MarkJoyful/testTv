//
//  VideoInfoModel.m
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import "VideoInfoModel.h"

@implementation VideoInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]){
        [super setValue:value forKey:key];
    }else{
        [super setValue:[NSString stringWithFormat:@"%@", value] forKey:key];
    }
}

@end
