//
//  PDNewsDetailViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDNewsDetailViewController.h"
#import "PDNewsDetailCell.h"

@interface PDNewsDetailViewController ()


@property (nonatomic,strong) PDModelNews *newsDetail;

@end

@implementation PDNewsDetailViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
    
    __weak PDNewsDetailViewController *weakSelf = self;
    
    NSString *userid = [PDAccountManager sharedInstance].userid;
    [[PDHTTPEngine sharedInstance] newsDetailWithUserid:userid news_id:@1 success:^(AFHTTPRequestOperation *operation, PDModelNews *newsDetail) {
        //
        weakSelf.newsDetail = newsDetail;
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDNewsDetailCell cellHeightWithData:_newsDetail];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDNewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDNewsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.delegate = self;
    [cell setData:_newsDetail];
    return cell;
}

// 赞消息
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell likeNewsWithData:(id)data{

    if ([self userLogined]) {
    
        NSString *userid = [PDAccountManager sharedInstance].userid;
        PDModelNews *news = (PDModelNews *)data;
        [[PDHTTPEngine sharedInstance] newsLikeWithUserid:userid news_id:news.news_id success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"赞成功");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
