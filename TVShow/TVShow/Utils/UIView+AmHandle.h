//
//  UIView+AmHandle.h
//  FlipeTableView
//
//  Created by bob Chris on 2017/6/1.
//  Copyright © 2017年 bob Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AmHandle)

/**
 圆角

 @param corner 圆角角度
 @param type 圆角个数
 */
- (void)customClipCorner:(CGFloat)corner cornerType:(UIRectCorner)type;

@end
