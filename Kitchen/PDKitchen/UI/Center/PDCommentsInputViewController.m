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

    PDBaseTextView *textView;
    
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(sendButtonTaped:)];
    
    textView = [[PDBaseTextView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 260)];
    textView.placeholderColor = [UIColor colorWithHexString:@"#e6e6e6"];
    textView.placeholder = @"请输入你的评论";
    [self.view addSubview:textView];
    
    [self.view showDebugRect];
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    //[textView becomeFirstResponder];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
