//
//  RoomCollectionViewCell.m
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import "RoomCollectionViewCell.h"


static const CGFloat _padding = 5.0f;

@implementation RoomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.tvSnapshot];
        [self.contentView addSubview:self.roomName];
        [self.contentView addSubview:self.djName];
        [self.contentView addSubview:self.watchPersonNum];
    }
    return self;
}

- (void)setRoomListModel:(RoomListModel *)roomListModel{

    _roomListModel = roomListModel;
    
    [self.tvSnapshot sd_setImageWithURL:[NSURL URLWithString:roomListModel.pictures[@"img"]]];
    self.roomName.text = roomListModel.name;
    self.djName.text = roomListModel.userinfo[@"nickName"];
    [self.djName sizeToFit_originalHeight];
    self.watchPersonNum.text = [self unitConversionString:roomListModel.person_num];
    [self.watchPersonNum sizeToFit_originalHeight];
    self.watchPersonNum.frame = CGRectMake(self.frame.size.width-_padding-self.watchPersonNum.frame.size.width, self.djName.frame.origin.y, self.watchPersonNum.frame.size.width, self.watchPersonNum.frame.size.height);
}

#pragma mark -- 懒加载
- (UIImageView *)tvSnapshot{
    
    if (_tvSnapshot == nil) {
        _tvSnapshot = [[UIImageView alloc] initWithFrame:CGRectMake(_padding, 0, self.frame.size.width-2*_padding, self.frame.size.height-50)];
        [_tvSnapshot customClipCorner:5.0f cornerType:UIRectCornerAllCorners];
        _tvSnapshot.backgroundColor = [UIColor cyanColor];
    }
    return _tvSnapshot;
}

- (UILabel *)roomName{
    
    if (_roomName == nil) {
        _roomName = [[UILabel alloc] initWithFrame:CGRectMake(_padding, self.tvSnapshot.frame.size.height+_padding, self.tvSnapshot.frame.size.width, 20)];
        _roomName.text = @"未知";
        _roomName.font = [UIFont systemFontOfSize:13.0f];
    }
    return _roomName;
}

- (UILabel *)djName{
    
    if (_djName == nil) {
        _djName = [[UILabel alloc] initWithFrame:CGRectMake(_padding, self.roomName.frame.origin.y+self.roomName.frame.size.height+_padding, 0, 15)];
        _djName.text = @"未知";
        _djName.font = [UIFont systemFontOfSize:10.0f];
        _djName.textColor = [UIColor lightGrayColor];
    }
    return _djName;
}

- (UILabel *)watchPersonNum{
    
    if (_watchPersonNum == nil) {
        _watchPersonNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        _watchPersonNum.text = @"未知";
        _watchPersonNum.font = [UIFont systemFontOfSize:10.0f];
        _watchPersonNum.textColor = [UIColor lightGrayColor];
    }
    return _watchPersonNum;
}

#pragma mark -- Method
- (NSString *)unitConversionString:(NSString *)string{
    
    if ([string integerValue]/100000000 >= 1) {
        string = [NSString stringWithFormat:@"%.1f亿", [string integerValue]/100000000.0];
    }else if ([string integerValue]/10000 >= 1){
        string = [NSString stringWithFormat:@"%.1f万", [string integerValue]/10000.0];
    }
    return string;
}

@end
