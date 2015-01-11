//
//  PDAllOrderTableViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDAllOrderTableViewController.h"
#import "PDOrderModel.h"
#import "PDOrderCell.h"
#import "PDHTTPEngine.h"
#import "VRGCalendarView.h"

@interface PDAllOrderTableViewController ()<UITabBarControllerDelegate,VRGCalendarViewDelegate>
{
    NSMutableArray *list;
    UIControl *_iPCalendarControl;
    UIView *footer;
}
@end

@implementation PDAllOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    list=[[NSMutableArray alloc] init];
    [list addObject:[[PDOrderModel alloc] init]];
    [list addObject:[[PDOrderModel alloc] init]];
    
    UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Back"]];
    img.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    [img addGestureRecognizer:tap];
    UIBarButtonItem *leftbar=[[UIBarButtonItem alloc] initWithCustomView:img];
    self.navigationItem.leftBarButtonItem=leftbar;
    UILabel *ttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kAppWidth, 44)];
    ttitle.text=@"全部订单";
    ttitle.font=[UIFont systemFontOfSize:kAppFontSize];
    ttitle.textColor=[UIColor colorWithHexString:kAppNormalColor];
    ttitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=ttitle;
    
    
    
    footer=[[UIView alloc] initWithFrame:CGRectMake(0, kAppHeight-50, kAppWidth, 50)];
    footer.backgroundColor=[UIColor colorWithRed:0.4000 green:0.4000 blue:0.4000 alpha:1.0f];
    UIWindow *keywindow=[[UIApplication sharedApplication] keyWindow];
    
    UIButton *calendarutton = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap/2, kAppWidth-2*kCellLeftGap, 40)];
    calendarutton.backgroundColor=[UIColor colorWithHexString:kAppRedColor];
    [footer addSubview:calendarutton];
    [calendarutton setTitle:@"日历" forState:UIControlStateNormal];
    [calendarutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [calendarutton.titleLabel setFont:[UIFont systemFontOfSize:kAppBtnSize]];
    [calendarutton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        if (!_iPCalendarControl) {
            _iPCalendarControl =[[UIControl alloc] initWithFrame:(CGRect){0,0,kAppWidth,kAppHeight}];
            _iPCalendarControl.backgroundColor=[UIColor clearColor];
            NSLog(@"_iPCalendarControl.frame=%@",NSStringFromCGRect(_iPCalendarControl.frame));
            VRGCalendarView *calendar =  [[VRGCalendarView alloc] initWithFrame:CGRectMake(0, kAppHeight-318, kAppWidth, 318)];
            calendar.tag =100;
            calendar.delegate =self;
            [_iPCalendarControl addSubview:calendar];
            [_iPCalendarControl addTarget:self action:@selector(dismissCalandar:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (!_iPCalendarControl.superview) {
            [keywindow addSubview:_iPCalendarControl];
            [(VRGCalendarView *)[_iPCalendarControl viewWithTag:100] reset];
        }
    }];
    calendarutton.layer.cornerRadius = kBtnCornerRadius;
    calendarutton.layer.masksToBounds = YES;
    calendarutton.layer.borderWidth = 1;
    calendarutton.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
    
    
    [keywindow addSubview:footer];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        PDHTTPEngine *engine=[[PDHTTPEngine alloc] init];
        [engine allOrderWithKitchenid:@"d97c065066afb1632ca78c02b4b6351b" start_date:@"2015-01-09" end_date:@"2015-01-10" page:0 success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIWindow *keywindow=[[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:footer];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [footer removeFromSuperview];
}
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40+kCellLeftGap*2;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
    header.backgroundColor=[UIColor whiteColor];

    UIButton *calendar = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-kCellLeftGap*2, 40)];
    calendar.backgroundColor=[UIColor whiteColor];
    [header addSubview:calendar];
    [calendar setTitle:@"日历" forState:UIControlStateNormal];
    [calendar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [calendar handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        if (!_iPCalendarControl) {
            _iPCalendarControl =[[UIControl alloc] initWithFrame:(CGRect){0,0,kAppWidth,kAppHeight}];
            NSLog(@"%@",NSStringFromCGRect(_iPCalendarControl.frame));
            _iPCalendarControl.backgroundColor =[UIColor clearColor];
            VRGCalendarView *calendar =  [[VRGCalendarView alloc] init];
            calendar.tag =100;
            calendar.delegate =self;
            [_iPCalendarControl addSubview:calendar];
            [_iPCalendarControl addTarget:self action:@selector(dismissCalandar:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (!_iPCalendarControl.superview) {
            [self.view addSubview:_iPCalendarControl];
            [(VRGCalendarView *)[_iPCalendarControl viewWithTag:100] reset];
        }
    }];
    return header;
}*/
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated{
    
    NSLog(@"%s,%@,select date :%@,labeltitle:%@",__func__,[NSString stringWithFormat:@"%@",calendarView.currentMonth],[NSString stringWithFormat:@"%@",calendarView.selectedDate],calendarView.labelCurrentMonth.text);
    
//    if ([SCShareFunc isIPhone]) {
//        CGRect frame = [[_iPCalendarControl viewWithTag:100] frame];
//        frame.size.height =targetHeight;
//        [[_iPCalendarControl viewWithTag:100] setFrame:(CGRect){KDeviceHight-frame.size.width-10,self.topCalanderBtn.frame.origin.y+self.topCalanderBtn.frame.size.height,frame.size.width,frame.size.height}]; //;
//    }else{
//        _calendarViewController.popoverContentSize=CGSizeMake(321, targetHeight);
//    }
//    
//    // then get the active day
//    //  getMonthActiveDays //2014-01-01 eg
//    riliMonthDay =[SCShareFunc firstDayStrFromMonth:calendarView.currentMonth];
//    NSLog(@"rilimonth --%@",riliMonthDay);
//    
//    [SCNetManager getSleepActivityInfoSuccess:^(BOOL success,NSDictionary *response){
//        if (success) {
//            [calendarView reDisplayViewUse:response];
//        }
//        
//    } faileture:^(BOOL faile){
//        if (faile) {
//            [calendarView reDisplayViewUse:nil];
//        }
//        
//    } withType:KgetMonthActiveDays andWithPeroid:0];
    
}
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date
{
    NSLog(@"date==%@",date);
}
-(void)dismissCalandar:(id)sender
{
    [_iPCalendarControl removeFromSuperview];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    
    
}

@end
