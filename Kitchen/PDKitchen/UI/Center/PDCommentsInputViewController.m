//
//  PDCommentsInputViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCommentsInputViewController.h"
#import "PDBaseTextView.h"

@interface PDCommentsInputViewController ()
{
    UITextView *textView;
}

@end

@implementation PDCommentsInputViewController

- (void)sendButtonTaped:(id)sender{

    sleep(1.5);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    [self setupBackButton];

    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 64+10, kAppWidth-20, 200)];
    [self.view addSubview:textView];
    textView.layer.borderColor = [UIColor colorWithHexString:@"#e6e6e6"].CGColor;
    textView.layer.borderWidth = 0.5f;
    textView.clipsToBounds = YES;
    
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
    
    //[self.view showDebugRect];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [textView becomeFirstResponder];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
