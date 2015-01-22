//
//  PDBaseViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseViewController.h"

@interface PDBaseViewController ()
{

    UIView *loadingView;
    UIImageView *animView;
    
}

@end

@implementation PDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonTaped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupBackButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 40);
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:@"center_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

// 登陆
-(BOOL)userLogined{
    if (![PDAccountManager sharedInstance].isLogined) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowLoginNotificationKey object:nil];
        return NO;
    }
    return YES;
}

-(void)startLoading{

    if (!loadingView) {
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight)];
        loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        animView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [loadingView addSubview:animView];
        animView.center = CGPointMake(kAppWidth/2, kAppHeight/2);
        animView.animationRepeatCount = -1;
        animView.animationDuration = 0.5;
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i<=29; i++) {
            
            NSString *name = [NSString stringWithFormat:@"Preloader_%d",i];
            
            [arr addObject:[UIImage imageNamed:name]];
        }
        
        animView.animationImages = arr;
    }
    
    [self.view addSubview:loadingView];
    [animView startAnimating];
}

-(void)stopLoading{
    [loadingView removeFromSuperview];
    [animView stopAnimating];
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
