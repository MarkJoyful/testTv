//
//  HomeViewController.m
//  TVShow
//
//  Created by bob Chris on 2017/6/8.
//  Copyright © 2017年 AM. All rights reserved.
//

#import "HomeViewController.h"
#import "PlayRoomViewController.h"

#import "RoomCollectionViewCell.h"

#import "RoomListModel.h"

#import "UIView+WebCache.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, copy) NSMutableArray *dataSource;
/**
 请求页数
 */
@property (nonatomic, assign) NSInteger pageno;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageno = 1;
    [self requestFromNet];
//    [self.view addSubview:self.collectionView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, 100, 20);
    [btn.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=0&spn=0&di=1&pi=0&rn=1&tn=baiduimagedetail&is=&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=4174197527%2C3602250184&os=933840479%2C36995473&simid=&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=-1&oriquery=&objurl=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fcaef76094b36acaf0accebde76d98d1001e99ce7.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bq7wg3tg2_z%26e3Bv54AzdH3Ft42k7yAzdH3F7saaan-d0b9_z%26e3Bip4s&gsm=0"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        
    }];
    [self.view addSubview:btn];
}

- (void)requestFromNet{
    
    Macro_CreateWeakSelf(self);
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&pageno=%ld", XM_ListUrl, self.pageno]]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:requeset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // json 解析
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *responseSource = [json objectForKey:@"data"][@"items"];
        
        if (responseSource.count == 0) { //没有更多数据
            [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }else if (weakSelf.pageno == 1){ // 下拉
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.collectionView.mj_header endRefreshing];
        }else{                           //上拉
            [weakSelf.collectionView.mj_footer endRefreshing];
        }
        [weakSelf addDataToSource:responseSource];
        dispatch_async(dispatch_get_main_queue(), ^{
            
           [weakSelf.collectionView reloadData];
        });
    }];
    [task resume];
}

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((self.view.frame.size.width-50)/2, (self.view.frame.size.width-50)/2/6*5);
        layout.sectionInset = UIEdgeInsetsMake(5, 15, 5, 15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[RoomCollectionViewCell class] forCellWithReuseIdentifier:@"tv"];
        
        Macro_CreateWeakSelf(self);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            weakSelf.pageno = 1;
            [weakSelf requestFromNet];
        }];
        _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            weakSelf.pageno ++;
            [weakSelf requestFromNet];
        }];
        
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

#pragma mark -- collection datasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tv" forIndexPath:indexPath];
    cell.roomListModel = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

#pragma mark -- collection delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayRoomViewController *playVc = [[PlayRoomViewController alloc] init];
    RoomListModel *model = self.dataSource[indexPath.row];
    playVc.roomid = model.roomid;
    [self.navigationController pushViewController:playVc animated:YES];
}

#pragma mark -- Event
- (void)addDataToSource:(NSArray *)responseSource{
    
    for (NSDictionary *tvDic in responseSource) {
        RoomListModel *roomListModel = [[RoomListModel alloc] init];
        [roomListModel setValuesForKeysWithDictionary:tvDic];
        [self.dataSource addObject:roomListModel];
        roomListModel = nil;
    }
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
