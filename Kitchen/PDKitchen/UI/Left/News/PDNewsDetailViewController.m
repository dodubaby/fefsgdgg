//
//  PDNewsDetailViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDNewsDetailViewController.h"

@interface PDNewsDetailViewController ()

@end

@implementation PDNewsDetailViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupBackButton];
    
    NSString *userid = [PDAccountManager sharedInstance].userid;
    [[PDHTTPEngine sharedInstance] newsDetailWithUserid:userid news_id:@1 success:^(AFHTTPRequestOperation *operation, NSArray *list) {
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
