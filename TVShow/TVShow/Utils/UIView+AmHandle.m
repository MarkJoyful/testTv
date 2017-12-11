//
//  UIView+AmHandle.m
//  FlipeTableView
//
//  Created by bob Chris on 2017/6/1.
//  Copyright © 2017年 bob Chris. All rights reserved.
//

#import "UIView+AmHandle.h"

@implementation UIView (AmHandle)

- (void)customClipCorner:(CGFloat)corner cornerType:(UIRectCorner)type{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:type cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
