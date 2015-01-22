//
//  PDCommentsInputViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCommentsInputViewController.h"
#import "PDBaseTextView.h"
//#import "UIPlaceHolderTextView.h"

@interface PDCommentsInputViewController ()
{
    UIPlaceHolderTextView *textView;
}

@end

@implementation PDCommentsInputViewController

- (void)sendButtonTaped:(id)sender{

    sleep(1.5);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
    
    [textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    [self setupBackButton];

    
    CGFloat offsetY = 0;
    if (kAppHeight<=480) {
        offsetY = 45;
    }
    
    textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(10, 64+10, kAppWidth-20, 130-offsetY)];
    [self.view addSubview:textView];
    textView.font = [UIFont systemFontOfSize:15];
    textView.layer.borderColor = [UIColor colorWithHexString:@"#e6e6e6"].CGColor;
    textView.layer.borderWidth = 0.5f;
    textView.clipsToBounds = YES;
    textView.placeholder = @"输入评论内容";
    
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    //修复textView位置错误
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        UIEdgeInsets insets = textView.contentInset;
        insets.top = self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].statusBarFrame.size.height-64;
        textView.contentInset = insets;
        textView.scrollIndicatorInsets = insets;
    }
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(10, textView.bottom+20, kAppWidth - 20, 40)];
    [self.view addSubview:submit];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:submit.size];
    [submit setBackgroundImage:image forState:UIControlStateNormal];
    [submit setTitle:@"发送" forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor colorWithHexString:@"#c14a41"];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    submit.layer.cornerRadius = 4;
    submit.clipsToBounds = YES;
    [submit handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
        if ([self userLogined]) {
        
            if ([textView.text length]==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"请输入评价内容"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定", nil];
                [alert show];
                return ;
            }
            
            NSString *userid = [PDAccountManager sharedInstance].userid;
            [[PDHTTPEngine sharedInstance] messageAddwithUserid:userid foodid:self.foodid cookerid:self.cookerid text:textView.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //
                NSLog(@"发送成功");

                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //
                NSLog(@"发送失败");
            }];
        }
    }];
    
    //[self.view showDebugRect];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
