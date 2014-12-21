//
//  PDLoginViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDLoginViewController.h"
#import "PDRegisterViewController.h"

@interface PDLoginViewController ()
{
    UILabel *logintitle;
    UITextField *usernameTfd;
    UITextField *passwordTfd;
    UIButton *loginBtn;
    UIButton *registBtn;
}
@end

@implementation PDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    logintitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, kAppWidth, 40)];
    logintitle.text=@"登  录";
    [self.view addSubview:logintitle];
    logintitle.textAlignment = NSTextAlignmentCenter;
    usernameTfd=[[UITextField alloc] initWithFrame:CGRectMake(40, 250, kAppWidth-80, 40)];
    usernameTfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:usernameTfd];
    passwordTfd=[[UITextField alloc] initWithFrame:CGRectMake(40, 300, kAppWidth-80, 40)];
    passwordTfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:passwordTfd];
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 350, 120, 40)];
    loginBtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:loginBtn];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"login");
        AppDelegate *app=[[UIApplication sharedApplication] delegate];
        [app changetoMainViewController];
    }];
    
    registBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 350, 120, 40)];
    registBtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:registBtn];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"registBtn");
    }];
    
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
