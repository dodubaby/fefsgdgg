//
//  PDCommentsInputViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/24.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCommentsInputViewController.h"

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(sendButtonTaped:)];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 260)];
    [self.view addSubview:textView];
    
    [self.view showDebugRect];
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
