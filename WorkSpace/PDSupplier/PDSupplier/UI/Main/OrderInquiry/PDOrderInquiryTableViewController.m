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
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc] initWithTitle:@"全部订单" style:UIBarButtonItemStylePlain target:self action:@selector(allOrderAciton:)];
    self.navigationItem.rightBarButtonItem=rightitem;
    
    
    footer=[[UIView alloc] initWithFrame:CGRectMake(0, kAppHeight-90, kAppWidth, 90)];
    footer.backgroundColor=[UIColor grayColor];
    
    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, 100, 40)];
    AMButton.backgroundColor=[UIColor grayColor];
    [footer addSubview:AMButton];
    [AMButton setTitle:@"配送的订单" forState:UIControlStateNormal];
    [AMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(AMButton.right+kCellLeftGap, kCellLeftGap, 100, 40)];
    PMButton.backgroundColor=[UIColor grayColor];
    [footer addSubview:PMButton];
    [PMButton setTitle:@"退款的订单" forState:UIControlStateNormal];
    [PMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [PMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    
    UIButton *searchutton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-100, PMButton.bottom+kCellLeftGap, 100, 20)];
    searchutton.backgroundColor=[UIColor grayColor];
    [footer addSubview:searchutton];
    [searchutton setTitle:@"查询" forState:UIControlStateNormal];
    [searchutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchutton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    UITextField *input =[[UITextField alloc] initWithFrame:CGRectMake(kCellLeftGap, PMButton.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*2-searchutton.width-20, 20)];
    input.borderStyle=UITextBorderStyleLine;
    input.delegate=self;
    [footer addSubview:input];
    

    UIWindow *keywindow=[[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:footer];
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
        footer.frame =CGRectMake(0, kAppHeight-90, kAppWidth, 90);
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
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 80;
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
//    header.backgroundColor=[UIColor grayColor];
//    
//    UIButton *searchutton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-100, kCellLeftGap, 100, 20)];
//    searchutton.backgroundColor=[UIColor grayColor];
//    [header addSubview:searchutton];
//    [searchutton setTitle:@"查询" forState:UIControlStateNormal];
//    [searchutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [searchutton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//        
//    }];
//    
//    UITextField *input =[[UITextField alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-kCellLeftGap*2-searchutton.width-20, 20)];
//    input.borderStyle=UITextBorderStyleLine;
//    [header addSubview:input];
//    
//    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, input.bottom+kCellLeftGap, 100, 40)];
//    AMButton.backgroundColor=[UIColor grayColor];
//    [header addSubview:AMButton];
//    [AMButton setTitle:@"配送的订单" forState:UIControlStateNormal];
//    [AMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//        
//    }];
//    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(AMButton.right+kCellLeftGap, input.bottom+kCellLeftGap, 100, 40)];
//    PMButton.backgroundColor=[UIColor grayColor];
//    [header addSubview:PMButton];
//    [PMButton setTitle:@"退款的订单" forState:UIControlStateNormal];
//    [PMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [PMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//        
//    }];
//    
//    return header;
//}
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
