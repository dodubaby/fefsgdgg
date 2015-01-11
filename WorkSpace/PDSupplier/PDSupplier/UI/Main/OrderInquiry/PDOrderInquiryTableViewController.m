//
//  PDOrderInquiryTableViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDOrderInquiryTableViewController.h"
#import "PDOrderModel.h"
#import "PDOrderCell.h"
#import "PDAllOrderTableViewController.h"
#import "PDHTTPEngine.h"


@interface PDOrderInquiryTableViewController ()
{
    NSMutableArray *list;
    UIView *footer;
}
@end

@implementation PDOrderInquiryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    list=[[NSMutableArray alloc] init];
    [list addObject:[[PDOrderModel alloc] init]];
    [list addObject:[[PDOrderModel alloc] init]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, 26, 40);
    [button setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    UILabel *ttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kAppWidth, 44)];
    ttitle.text=@"配送的";
    ttitle.font=[UIFont systemFontOfSize:kAppFontSize];
    ttitle.textColor=[UIColor colorWithHexString:kAppNormalColor];
    ttitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=ttitle;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.backgroundColor = [UIColor clearColor];
    rightbutton.frame = CGRectMake(0, 0, 64, 44);
    [rightbutton.titleLabel setFont:[UIFont systemFontOfSize:kAppFontSize]];
    [rightbutton setTitle:@"全部订单" forState:UIControlStateNormal];
    rightbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [rightbutton setTitleColor:[UIColor colorWithHexString:kAppNormalColor] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(allOrderAciton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightbarbutton  = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    [self.navigationItem setRightBarButtonItem:rightbarbutton animated:YES];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    footer=[[UIView alloc] initWithFrame:CGRectMake(0, kAppHeight-50, kAppWidth, 50)];
    footer.backgroundColor=[UIColor colorWithRed:0.4000 green:0.4000 blue:0.4000 alpha:1.0f];
//
//    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, 100, 40)];
//    AMButton.backgroundColor=[UIColor grayColor];
//    [footer addSubview:AMButton];
//    [AMButton setTitle:@"配送的订单" forState:UIControlStateNormal];
//    [AMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//        
//    }];
//    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(AMButton.right+kCellLeftGap, kCellLeftGap, 100, 40)];
//    PMButton.backgroundColor=[UIColor grayColor];
//    [footer addSubview:PMButton];
//    [PMButton setTitle:@"退款的订单" forState:UIControlStateNormal];
//    [PMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [PMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//        
//    }];
//    
//    
    UIButton *searchutton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-120, kCellLeftGap/2, 120, 40)];
    searchutton.backgroundColor=[UIColor colorWithHexString:kAppRedColor];
    [footer addSubview:searchutton];
    [searchutton setTitle:@"查询" forState:UIControlStateNormal];
    [searchutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchutton.titleLabel setFont:[UIFont systemFontOfSize:kAppBtnSize]];
    [searchutton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    searchutton.layer.cornerRadius = kBtnCornerRadius;
    searchutton.layer.masksToBounds = YES;
    searchutton.layer.borderWidth = 1;
    searchutton.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
    
    UITextField *input =[[UITextField alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap/2, kAppWidth-kCellLeftGap*2.5-searchutton.width, 40)];
    input.borderStyle=UITextBorderStyleNone;
    input.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    input.placeholder=@"输入手机号后4位";
    input.backgroundColor=[UIColor whiteColor];
    input.delegate=self;
    [footer addSubview:input];

    UIWindow *keywindow=[[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:footer];
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        PDHTTPEngine *engine=[[PDHTTPEngine alloc] init];
        [engine searchOrderWithKitchenid:@"d97c065066afb1632ca78c02b4b6351b" type:1 phone:@"6308" page:0 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject==%@",responseObject);
            PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
            NSLog(@"model===%@",model);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
    }];
    //
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        //
    }];
    
}
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)allOrderAciton:(id)sender
{
    PDAllOrderTableViewController*vc=[[PDAllOrderTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIWindow *keywindow=[[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:footer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disappearKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [footer removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)showKeyBoard:(NSNotification *)notification{
    NSDictionary *userinfo =notification.userInfo;
    NSLog(@"%@",userinfo);
    CGRect NeedToFrame=CGRectZero;
    double duration =[[userinfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endRect =[[userinfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float Y=0.0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        Y=[UIScreen mainScreen].bounds.size.height-endRect.size.height;
    }else{
        CGRect _rect        =[[userinfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //  需要手动 转化一下
        /* ios7
         "The key for an NSValue object containing a CGRect that identifies the start/end frame of the keyboard in screen coordinates. These coordinates do not take into account any rotation factors applied to the window’s contents as a result of interface orientation changes. Thus, you may need to convert the rectangle to window coordinates (using the convertRect:fromWindow: method) or to view coordinates (using the convertRect:fromView: method) before using it."
         
         大意说，这个CGRect不考虑任何旋转，用的时候一定要对这个rect进行坐标转换（convertRect:）。
         （这里找到资料说，The first view should be your view. The second view should be nil, meaning window/screen coordinates. ）
         */
        CGRect _convertRect=[self.view convertRect:_rect fromView:nil];
        NSLog(@"_convertRect=====%@",NSStringFromCGRect(_convertRect));
        Y  =[UIScreen mainScreen].bounds.size.width-_convertRect.size.height;
    }
    NeedToFrame =(CGRect){footer.origin.x,Y-footer.frame.size.height,footer.size.width,footer.size.height};
    [UIView animateWithDuration:duration animations:^{
        footer.frame =NeedToFrame;
    } completion:nil];
    
}
-(void)disappearKeyboard:(NSNotification *)notification{
    NSDictionary *userinfo =notification.userInfo;
    NSLog(@"%@",userinfo);
    double duration =[[userinfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        footer.frame =CGRectMake(0, kAppHeight-50, kAppWidth, 50);
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 60)];
    header.backgroundColor=[UIColor whiteColor];
    
    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(kGap, kGap, (kAppWidth-2*kGap)/2, 50)];
    AMButton.backgroundColor=[UIColor whiteColor];
    [header addSubview:AMButton];
    [AMButton setTitle:@"配送的订单" forState:UIControlStateNormal];
    [AMButton.titleLabel setFont:[UIFont systemFontOfSize:kAppFontSize]];
    [AMButton setTitleColor:[UIColor colorWithHexString:kAppNormalColor] forState:UIControlStateNormal];
    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    UIImageView *gapimg=[[UIImageView alloc] initWithFrame:CGRectMake(AMButton.right, AMButton.top+18, 1, 16)];
    gapimg.backgroundColor=[UIColor colorWithHexString:kAppLineColor];
    [header addSubview:gapimg];
    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(AMButton.right+1, kGap, (kAppWidth-2*kGap)/2, 50)];
    PMButton.backgroundColor=[UIColor whiteColor];
    [header addSubview:PMButton];
    [PMButton setTitle:@"退款的订单" forState:UIControlStateNormal];
    [PMButton setTitleColor:[UIColor colorWithHexString:kAppNormalColor] forState:UIControlStateNormal];
    [PMButton.titleLabel setFont:[UIFont systemFontOfSize:kAppFontSize]];
    [PMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDOrderCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellstring=@"inOrdercellID";
    PDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstring];
    if (!cell) {
        cell = [[PDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstring];
        cell.type=OrderTypeNormal;
    }
    [cell setData:nil];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    
    
}


@end
