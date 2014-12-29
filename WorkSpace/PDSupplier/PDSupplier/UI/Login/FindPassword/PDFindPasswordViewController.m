//
//  PDFindPasswordViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDFindPasswordViewController.h"

#define TFDGAP 10
@interface PDFindPasswordViewController ()
{
    UITextField *phonetfd;
    UIButton *sendcodebtn;
    UITextField *codetfd;
    UITextField *passwordtfd;
    UIButton *submitbtn;
}
@end

@implementation PDFindPasswordViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    phonetfd=[[UITextField alloc] initWithFrame:CGRectMake(40, 40+64, kAppWidth-80, 40)];
    phonetfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:phonetfd];
    
    sendcodebtn = [[UIButton alloc] initWithFrame:CGRectMake(phonetfd.right-120, phonetfd.top, 120, 40)];
    sendcodebtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:sendcodebtn];
    [sendcodebtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendcodebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendcodebtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"forgetBtn");
        
    }];
    
    codetfd=[[UITextField alloc] initWithFrame:CGRectMake(40, phonetfd.bottom+TFDGAP, kAppWidth-80, 40)];
    codetfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:codetfd];
    
    passwordtfd=[[UITextField alloc] initWithFrame:CGRectMake(40, codetfd.bottom+TFDGAP, kAppWidth-80, 40)];
    passwordtfd.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:passwordtfd];

    submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(40, passwordtfd.bottom+TFDGAP, kAppWidth-80, 40)];
    submitbtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:submitbtn];
    [submitbtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        NSLog(@"registBtn");

    }];
    
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
