//
//  PlayRoomViewController.m
//  TVShow
//
//  Created by bob Chris on 2017/6/9.
//  Copyright © 2017年 AM. All rights reserved.
//

#import "PlayRoomViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

#import "VideoInfoModel.h"

@interface PlayRoomViewController ()<IJKMediaUrlOpenDelegate>

@property (nonatomic, strong)IJKFFMoviePlayerController *player;

@property (nonatomic, strong)VideoInfoModel *videoInfoModel;
@end

@implementation PlayRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestRoomDetails];
}

- (void)requestRoomDetails{
    
    Macro_CreateWeakSelf(self);
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&roomid=%@", XM_PlayRoomUrl, self.roomid]]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:requeset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // json 解析
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseSource = [json objectForKey:@"data"][@"info"];
        [weakSelf.videoInfoModel setValuesForKeysWithDictionary:responseSource[@"videoinfo"]];
        // 准备播放
        dispatch_async(dispatch_get_main_queue(), ^{
            
           [weakSelf playerPrepareToPlay];
        });
    }];
    [task resume];
}

#pragma mark -- 懒加载
- (VideoInfoModel *)videoInfoModel{
    
    if (_videoInfoModel == nil) {
        _videoInfoModel = [[VideoInfoModel alloc] init];
    }
    return _videoInfoModel;
}

#pragma mark -- Event
- (void)playerPrepareToPlay{

    NSString *wsts_tag = [self.videoInfoModel.ts substringWithRange:NSMakeRange(4, 11)];
    const char lastChar = [wsts_tag characterAtIndex:7];
    // 验证字符串最后是不是字母
    
    if (islower(lastChar) != 0) { // 是字母
        
        // ascll 转码
        int ascll = [wsts_tag characterAtIndex:7];
        ascll++;
        // 递增
        NSString *string =[NSString stringWithFormat:@"%c",ascll];
        wsts_tag = [wsts_tag stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:string];
    }
    
    // 拼接地址
//    NSString *tvUrlStr = [NSString stringWithFormat:@"%@%@.flv?sign=%@&time=%@&wshc_tag=0&wsts_tag=%@&wsid_tag=b4a85bbe&wsiphost=ipdbm", XM_PlayVideoUrl, self.videoInfoModel.room_key, self.videoInfoModel.sign, self.videoInfoModel.ts, wsts_tag];
//    if (self.videoInfoModel.slaveflag.count < 2) {
      NSString*  tvUrlStr = [NSString stringWithFormat:@"%@%@_mid.flv?sign=%@&time=%@", @"http://pl3.live.panda.tv/live_panda/", self.videoInfoModel.room_key, self.videoInfoModel.sign, self.videoInfoModel.ts];
//    }
    // 创建播放器
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:tvUrlStr] withOptions:nil];
    [self.player prepareToPlay];
    self.player.view.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
    [self.view insertSubview:self.player.view atIndex:1];
    
    self.player.liveOpenDelegate = self;
}

#pragma mark -- ijk Delegate
- (void)willOpenUrl:(IJKMediaUrlOpenData *)urlOpenData{
    
    NSLog(@"%@", urlOpenData);
}

#pragma mark -- System
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
    self.player = nil;
    [self.player.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
