//
//  PDOrderSubmitSuccessViewController.m
//  PDKitchen
//
//  Created by bright on 15/1/21.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDOrderSubmitSuccessViewController.h"
#import "PDOrderViewController.h"
#import "AppDelegate.h"

@interface PDOrderSubmitSuccessViewController()
{
    UIButton *addButton;
}
@end

@implementation PDOrderSubmitSuccessViewController


-(void)backButtonTaped:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setupUI{
    
    UIImageView *smile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"od_smile"]];
    [self.view addSubview:smile];
    smile.top = 100;
    smile.left = (kAppWidth - smile.width)/2;
    
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, smile.bottom+20, kAppWidth, 20)];
    resultLabel.text = @"你的订单已提交成功";
    [self.view addSubview:resultLabel];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.font = [UIFont systemFontOfSize:15];
    resultLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    
    
    CGFloat left = 25;
    
    if (kAppWidth<=320) {
        left = 7;
    }
    
    CGFloat offsetY = 0;
    if (kAppHeight<=480) {
        offsetY = 50;
    }
    
    UILabel *otherHint = [[UILabel alloc] initWithFrame:CGRectMake(left, 320-offsetY, 0, 0)];
    otherHint.text = @"分享到：";
    [self.view addSubview:otherHint];
    otherHint.textColor = [UIColor colorWithHexString:@"#666666"];
    [otherHint sizeToFit];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:
                            @{@"新浪微博":@"lg_weibo"},
                            @{@"微信":@"lg_weixin"},
                            @{@"朋友圈":@"lg_weixin_pyq"},
                            @{@"QQ":@"lg_qq"}, nil];
    
    for (int i = 0; i<[list count]; i++) {
        
        NSDictionary *data = list[i];
        NSString *key = [data allKeys][0];
        NSString *value = data[key];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left+i*(69+10), otherHint.bottom + 15, 69, 69)];
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
                case 2:  // 微信
                {
                    
                    [delegate loginWeixin];
                }
                    break;
                case 3:  // QQ
                {
                    [delegate loginQQ];
                    
                }
                    break;
                default:
                    break;
            }
        }];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left+i*(69+10), button.bottom + 8, 69, 20)];
        [self.view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.text = key;
    }

    
    UIView *buttonBack = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50, kAppWidth, 50)];
    [self.view addSubview:buttonBack];
    buttonBack.backgroundColor = [UIColor colorWithHexString:@"#666666"];
    
    
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 120, 40)];
    addButton.right = buttonBack.width - 10;
    [buttonBack addSubview:addButton];
    addButton.backgroundColor = [UIColor redColor];
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:addButton.size];
    [addButton setBackgroundImage:image forState:UIControlStateNormal];
    [addButton setTitle:@"查看订单" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    addButton.layer.cornerRadius = 4;
    addButton.clipsToBounds = YES;
    [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        // 我的订单
        PDOrderViewController *vc = [PDOrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
                
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交成功";
    [self setupBackButton];
    [self setupUI];
}


@end
