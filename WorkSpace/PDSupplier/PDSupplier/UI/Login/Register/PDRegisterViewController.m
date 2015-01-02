//
//  PDRegisterViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDRegisterViewController.h"
#define TFDGAP 10

@interface PDRegisterViewController ()
{
    UITextField *phonetfd;
    UIButton *sendcodebtn;
    UITextField *codetfd;
    UITextField *passwordtfd;
    UIButton *submitbtn;
}
@end

@implementation PDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, 26, 40);
    [button setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    UILabel *ttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kAppWidth, 44)];
    ttitle.text=@"注册";
    ttitle.font=[UIFont systemFontOfSize:kAppFontSize];
    ttitle.textColor=[UIColor colorWithHexString:kAppNormalColor];
    ttitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=ttitle;
    
    phonetfd=[[UITextField alloc] initWithFrame:CGRectMake(kGap, 64+kGap*2, kAppWidth-kGap*2, 50)];
    phonetfd.placeholder=@"请输入手机号";
    phonetfd.layer.cornerRadius = 0;
    phonetfd.layer.masksToBounds = YES;
    phonetfd.layer.borderWidth = 1;
    phonetfd.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
    phonetfd.font=[UIFont systemFontOfSize:kAppFontSize];
    phonetfd.textColor=[UIColor colorWithHexString:kAppRedColor];
    [self.view addSubview:phonetfd];
    
    
    
    sendcodebtn = [[UIButton alloc] initWithFrame:CGRectMake(phonetfd.right-130-kGap, phonetfd.top, 90, 50)];
    sendcodebtn.backgroundColor=[UIColor clearColor];
    [self.view addSubview:sendcodebtn];
    [sendcodebtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendcodebtn setTitleColor:[UIColor colorWithHexString:kAppPlaceHoderColor] forState:UIControlStateNormal];
    [sendcodebtn.titleLabel setFont:[UIFont systemFontOfSize:kAppBtnSize]];
    [sendcodebtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"forgetBtn");
        
    }];
    UIImageView *sendimg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"发送"]];
    [self.view addSubview:sendimg];
    sendimg.frame=CGRectMake(sendcodebtn.right+5, sendcodebtn.top+5, 40, 40);
    
    
    codetfd=[[UITextField alloc] initWithFrame:CGRectMake(kGap, phonetfd.bottom+kGap, kAppWidth-kGap*2, 50)];
    codetfd.layer.cornerRadius = 0;
    codetfd.layer.masksToBounds = YES;
    codetfd.layer.borderWidth = 1;
    codetfd.layer.borderColor = [[UIColor colorWithHexString:kAppLineColor] CGColor];
    codetfd.font=[UIFont systemFontOfSize:kAppFontSize];
    codetfd.textColor=[UIColor colorWithHexString:kAppNormalColor];
    codetfd.placeholder=@"请输入验证码";
    [self.view addSubview:codetfd];
    
    
    passwordtfd=[[UITextField alloc] initWithFrame:CGRectMake(kGap, codetfd.bottom+kGap, kAppWidth-kGap*2, 50)];
    passwordtfd.borderStyle=UITextBorderStyleLine;
    passwordtfd.layer.cornerRadius = 0;
    passwordtfd.layer.masksToBounds = YES;
    passwordtfd.layer.borderWidth = 1;
    passwordtfd.layer.borderColor = [[UIColor colorWithHexString:kAppLineColor] CGColor];
    passwordtfd.font=[UIFont systemFontOfSize:kAppFontSize];
    passwordtfd.textColor=[UIColor colorWithHexString:kAppNormalColor];
    passwordtfd.placeholder=@"请输入密码";
    [self.view addSubview:passwordtfd];
    
    submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(kGap, passwordtfd.bottom+kGap, kAppWidth-kGap*2, 40)];
    submitbtn.backgroundColor=[UIColor colorWithHexString:kAppRedColor];
    [submitbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:submitbtn];
    [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitbtn setTitle:@"提交" forState:UIControlStateNormal];
    submitbtn.layer.cornerRadius = kBtnCornerRadius;
    submitbtn.layer.masksToBounds = YES;
    submitbtn.layer.borderWidth = 1;
    submitbtn.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
    [submitbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"registBtn");
        
    }];
    
}
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
