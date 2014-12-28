//
//  PDLoginViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDLoginViewController.h"
#import "PDRegisterViewController.h"
#import "PDFindPasswordViewController.h"
#import "PDUtils.h"

#define kLoginLeftGap 10

@interface PDLoginViewController ()
{
    UILabel *logintitle;
    UITextField *usernametfd;
    UITextField *passwordtfd;
    UIButton *loginbtn;
    UIButton *registbtn;
    UIButton *forgetbtn;
}
@end

@implementation PDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    logintitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kAppWidth, 40)];
    logintitle.text=@"登  录";
    [self.view addSubview:logintitle];
    logintitle.textAlignment = NSTextAlignmentCenter;
    usernametfd=[[UITextField alloc] initWithFrame:CGRectMake(40, 100, kAppWidth-80, 40)];
    usernametfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:usernametfd];
    passwordtfd=[[UITextField alloc] initWithFrame:CGRectMake(40, 150, kAppWidth-80, 40)];
    passwordtfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:passwordtfd];

    forgetbtn = [[UIButton alloc] initWithFrame:CGRectMake(passwordtfd.left, passwordtfd.bottom+kLoginLeftGap, 120, 40)];
    forgetbtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:forgetbtn];
    [forgetbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"forgetbtn");
        PDFindPasswordViewController *controller=[[PDFindPasswordViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(40, forgetbtn.bottom+kLoginLeftGap, 120, 40)];
    loginbtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:loginbtn];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"login");
        AppDelegate *app=[[UIApplication sharedApplication] delegate];
        [app changetoMainViewController];
    }];
    
    registbtn = [[UIButton alloc] initWithFrame:CGRectMake(220, forgetbtn.bottom+kLoginLeftGap, 120, 40)];
    registbtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:registbtn];
    [registbtn setTitle:@"注册" forState:UIControlStateNormal];
    [registbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"registbtn");
        PDRegisterViewController *controller=[[PDRegisterViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
