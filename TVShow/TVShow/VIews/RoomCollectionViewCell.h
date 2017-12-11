//
//  RoomCollectionViewCell.h
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomListModel.h"

@interface RoomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)RoomListModel *roomListModel;
@property (nonatomic, strong)UIImageView *tvSnapshot;
@property (nonatomic, strong)UILabel *roomName;
@property (nonatomic, strong)UILabel *djName;
@property (nonatomic, strong)UILabel *watchPersonNum;

@end
