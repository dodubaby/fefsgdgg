//
//  PDLoginViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/30.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDLoginViewController.h"
#import "AppDelegate.h"

@interface PDLoginViewController ()
{

    UITextField *phoneField;
    UIButton *sendCodeButton;
    
    UITextField *codeField;
    
    UIButton *loginButton;
}

@end

@implementation PDLoginViewController

-(void)backButtonTaped:(id)sender{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [delegate removeLogin];
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self setupBackButton];
    
    [self setupUI];
    
    [self.view showDebugRect];
}

-(void)setupUI{

    UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(10, 20+64, kAppWidth - 20, 50)];
    [self.view addSubview:back1];
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, back1.width - 150, 50)];
    [back1 addSubview:phoneField];
    phoneField.font = [UIFont systemFontOfSize:15];
    phoneField.textColor = [UIColor colorWithHexString:@"#c14a41"];
    phoneField.placeholder = @"手机号";
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendCodeButton.frame = CGRectMake(phoneField.right, 0, back1.width - phoneField.width-10, 50);
    [back1 addSubview:sendCodeButton];
    sendCodeButton.backgroundColor = [UIColor redColor];
    [sendCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    UIView *back2 = [[UIView alloc] initWithFrame:CGRectMake(10, back1.bottom + 10, kAppWidth - 20, 50)];
    [self.view addSubview:back2];
    
    codeField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, back2.width - 20, 50)];
    [back2 addSubview:codeField];
    codeField.font = [UIFont systemFontOfSize:15];
    codeField.textColor = [UIColor colorWithHexString:@"#333333"];
    codeField.placeholder = @"验证码";
    codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(10, back2.bottom + 15, kAppWidth - 20, 40);
    [self.view addSubview:loginButton];
    loginButton.backgroundColor = [UIColor redColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            //
            [self.view findAndResignFirstResponder];
        }];
    }];
    
    
    UILabel *otherHint = [[UILabel alloc] initWithFrame:CGRectMake(25, loginButton.bottom+115, 0, 0)];
    otherHint.text = @"合作账号登录";
    [self.view addSubview:otherHint];
    otherHint.textColor = [UIColor colorWithHexString:@"#666666"];
    [otherHint sizeToFit];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:
            @{@"新浪微博":@"lg_weibo"},
            @{@"微信":@"lg_weixin"},
            @{@"QQ":@"lg_qq"}, nil];
    
    for (int i = 0; i<[list count]; i++) {
        
        NSDictionary *data = list[i];
        NSString *key = [data allKeys][0];
        NSString *value = data[key];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25+i*(69+10), otherHint.bottom + 15, 69, 69)];
        [button setBackgroundImage:[UIImage imageNamed:value] forState:UIControlStateNormal];
        [self.view addSubview:button];
        button.tag = i;
        [button handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            //[delegate loginWeibo];
        
                        
            switch (button.tag) {
                case 0:  // 微博
                {
                
                    [delegate loginWeibo];
                    
                }
                    break;
                case 1:  // 微信
                {
                
                    [delegate loginWeixin];
                }
                    break;
                case 2:  // QQ
                {
                
                }
                    break;
                default:
                    break;
            }
            
        }];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25+i*(69+10), button.bottom + 8, 69, 20)];
        [self.view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.text = key;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    // 收回键盘
    [self.view findAndResignFirstResponder];
}

-(void)cleanup{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
