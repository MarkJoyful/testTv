//
//  UILabel+Haibei.m
//  Haibei-iOS
//
//  Created by MarkJ on 2016/9/19.
//  Copyright © 2016年 BiJie. All rights reserved.
//

#import "UILabel+AmHandle.h"

@implementation UILabel (AmHandle)

- (void)sizeToFit_originalHeight{
    
    CGRect adjustFrontFrame = self.frame;
    self.frame = CGRectMake(adjustFrontFrame.origin.x, adjustFrontFrame.origin.y, [UIScreen mainScreen].bounds.size.width, adjustFrontFrame.size.height);
    [self sizeToFit];
    CGRect adjustAfterFrame = self.frame;
    self.frame = CGRectMake(adjustFrontFrame.origin.x, adjustFrontFrame.origin.y, adjustAfterFrame.size.width, adjustFrontFrame.size.height);
}

- (void)sizeToFit_originalWidth{
    
    CGRect adjustFrontFrame = self.frame;
    self.frame = CGRectMake(adjustFrontFrame.origin.x, adjustFrontFrame.origin.y, [UIScreen mainScreen].bounds.size.width, adjustFrontFrame.size.height);
    [self sizeToFit];
    CGRect adjustAfterFrame = self.frame;
    self.frame = CGRectMake(adjustFrontFrame.origin.x, adjustFrontFrame.origin.y, adjustFrontFrame.size.width, adjustAfterFrame.size.height);
}

@end
