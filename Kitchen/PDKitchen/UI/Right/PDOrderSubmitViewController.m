//
//  PDOrderSubmitViewController.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDOrderSubmitViewController.h"
#import "PDOrderSubmitCell.h"
#import "PDAddressViewController.h"
#import "PDCouponViewController.h"
#import "PDOrderTimeViewController.h"
#import "PDOrderSubmitSuccessViewController.h"

@interface PDOrderSubmitCellItem : NSObject

@property (nonatomic,strong) Class cellClazz;         // cell类型
@property (nonatomic,strong) NSIndexPath *indexPath;  // cell索引
@property (nonatomic,assign) CGFloat cellHeight;      // cell 高度
@property (nonatomic,strong) id data;                 // 填充数据
@property (nonatomic,strong) NSDictionary *extInfo;   // 额外信息

+(PDOrderSubmitCellItem *)itemWithClazz:(Class) clazz data:(id) data;

@end

@implementation PDOrderSubmitCellItem

+(PDOrderSubmitCellItem *)itemWithClazz:(Class) clazz data:(id) data{
    PDOrderSubmitCellItem *item = [[PDOrderSubmitCellItem alloc] init];
    item.cellClazz = clazz;
    item.data = data;
    return item;
}

@end


@interface PDOrderSubmitViewController()<
PDCouponViewControllerDelegate,
PDAddressViewControllerDelegate,
PDOrderTimeViewControllerDelegate>
{
    
    UIButton *addButton;
    
}

@property (nonatomic,strong) NSMutableArray *cellItems;

@property (nonatomic,strong) PDModelAddress *currentAddress;
@property (nonatomic,strong) PDModelCoupon *currentCoupon;
@property (nonatomic,strong) NSString *currentTime;


@property (nonatomic,assign) BOOL canResignFirstResponder;

@end


@implementation PDOrderSubmitViewController


- (void)setupData{
    
    _cellItems = [[NSMutableArray alloc] init];
    
    // 地址
    {
        PDOrderSubmitCellItem *item = [PDOrderSubmitCellItem new];
        item.cellClazz = [PDOrderSubmitCell class];
        item.data = @"地址";
        item.extInfo = @{@"isShowArrow":@YES};
        [_cellItems addObject:item];
    }

    
    // 优惠
    {
    
        PDOrderSubmitCellItem *item = [PDOrderSubmitCellItem new];
        item.cellClazz = [PDOrderSubmitCell class];
        item.cellClazz = [PDOrderSubmitCell class];
        item.data = @"优惠券";
        item.extInfo = @{@"isShowArrow":@YES};
        [_cellItems addObject:item];
    }

    
    // 手机
    {
        PDOrderSubmitCellItem *item = [PDOrderSubmitCellItem new];
        item.cellClazz = [PDOrderSubmitCell class];
        item.cellClazz = [PDOrderSubmitPhoneCell class];
        
        [_cellItems addObject:item];
    }

    
    // 时间
    {
        PDOrderSubmitCellItem *item = [PDOrderSubmitCellItem new];
        item.cellClazz = [PDOrderSubmitCell class];
        item.data = @"就餐时间";
        item.extInfo = @{@"isShowArrow":@YES};
        [_cellItems addObject:item];
    }

    
    // 配送费
    {
        PDOrderSubmitCellItem *item = [PDOrderSubmitCellItem new];
        item.cellClazz = [PDOrderSubmitCell class];
        item.data = @"配送费：0元";
        item.extInfo = @{@"isActive":@YES};
        
        [_cellItems addObject:item];
    }

    
    // 要求
    {
        PDOrderSubmitCellItem *item = [PDOrderSubmitCellItem new];
        item.cellClazz = [PDOrderSubmitRequestCell class];
    
        [_cellItems addObject:item];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交订单";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.height = self.view.height - 50-40;
    
    
    _canResignFirstResponder = YES;
    
    // 为了能起来
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    self.tableView.tableFooterView = footer;
    
    [self setupBackButton];
    [self setupData];
    
    // 总价  // @"3份美食 共计113元";
    NSInteger c = 0;
    CGFloat price = 0.0f;
    NSArray *fdList = [PDCartManager sharedInstance].cartList;
    for (PDModelFood *fd in fdList) {
        c = c + [fd.count integerValue];
        price = price + [fd.price floatValue]*[fd.count integerValue];
    }
    NSString *priceStr = [NSString stringWithFormat:@"%ld份美食 共计%.02f元",c,price];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height - 50-40, kAppWidth-10, 40)];
    priceLabel.userInteractionEnabled = YES;
    priceLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:priceLabel];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.text= priceStr;
        
    UIView *buttonBack = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50, kAppWidth, 50)];
    [self.view addSubview:buttonBack];
    buttonBack.backgroundColor = [UIColor colorWithHexString:@"#666666"];
    
    
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 120, 40)];
    addButton.right = buttonBack.width - 10;
    [buttonBack addSubview:addButton];
    addButton.backgroundColor = [UIColor redColor];
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:addButton.size];
    [addButton setBackgroundImage:image forState:UIControlStateNormal];
    [addButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    addButton.layer.cornerRadius = 4;
    addButton.clipsToBounds = YES;
    
    [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
        
        /*
         userid	string	Y	用户唯一标识码
         food_ids	string	Y	选择购买的菜品及数量，如1*2**2*5，则为第一个菜品买了两个，ID编号为2的菜品买了5个。
         address	int	Y	地址
         phone	string	Y	联系电话
         coupon_id	int	N	优惠券ID
         eat_time	time	N	就餐时间，若选择立即送餐，则此项填空，后台进行判断。
         注意：eat_time为时间戳格式。
         message	string	N	个性化要求留言
         sum_price	float	N	总共价格
         */
        
        // 地址
        if (!_currentAddress) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请选择地址"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            
            return;
        }
        
        // 手机
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        PDOrderSubmitPhoneCell *cell = (PDOrderSubmitPhoneCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        NSString *cellPhone = cell.textField.text;
        
        
        if ([cellPhone length]==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请填写手机号"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            
            return;
        }
        
        // 时间
        if (!_currentTime) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请选择时间"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            
            return;
        }
        
        NSArray *arr = [PDCartManager sharedInstance].cartList;
        NSMutableString *ids = [[NSMutableString alloc] init];
        
        CGFloat totalPrice = 0.0f;
        for (PDModelFood *food in arr) {
            [ids appendString:[NSString stringWithFormat:@"%@*%@*",food.food_id,food.count]];
            totalPrice =  totalPrice + [food.count integerValue]*[food.price floatValue];
        }
        NSString *foodids = [ids substringToIndex:ids.length -1];// 去掉最后 *
        
        NSLog(@"%@",foodids);
        
        // 信息
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:5 inSection:0];
        PDOrderSubmitRequestCell *cell2 = (PDOrderSubmitRequestCell *)[self.tableView cellForRowAtIndexPath:indexPath2];
        NSString *message = cell2.textView.text;
        
        NSString *time = [_currentTime toTimestamp];

        NSString *userid = [PDAccountManager sharedInstance].userid;
        
        
        [self startLoading];
        
        [[PDHTTPEngine sharedInstance] orderAddWithUserid:userid
                                                  foodids:foodids
                                                  address:_currentAddress.address
                                                    phone:cellPhone
                                                 couponid:_currentCoupon.coupon_id
                                                  eatTime:time
                                                  message:message
                                                 sumPrice:[NSNumber numberWithFloat:totalPrice] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     //
                                                     /*
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                     UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                                      message:@"订单提交成功"
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:nil
                                                                                            otherButtonTitles:@"确定", nil];
                                                     [alert show];
                                                     */
                                                     
                                                     [self stopLoading];
                                                     
                                                     // 清空购物车
                                                     [[PDCartManager sharedInstance] clear];
                                                     
                                                     PDOrderSubmitSuccessViewController *vc = [PDOrderSubmitSuccessViewController new];
                                                     [self.navigationController pushViewController:vc animated:YES];
                                                     
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     //
                                                     [self stopLoading];
                                                     
                                                     NSString *message = error.userInfo[@"Message"];
                                                     if (!message) {
                                                         message = [error localizedDescription];
                                                     }
                                                     UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                                      message:@"提交失败提示你的订单提交不成功，请重新提交"
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:nil
                                                                                            otherButtonTitles:@"确定", nil];
                                                     [alert show];
                                                     
                                                 }];

    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PDOrderSubmitCellItem *item = _cellItems[indexPath.row];
    return [item.cellClazz cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDOrderSubmitCellItem *item = _cellItems[indexPath.row];
    
    NSString *cellID = NSStringFromClass(item.cellClazz);
    PDOrderSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[item.cellClazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.extInfo = item.extInfo;
    [cell setData:item.data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.view findAndResignFirstResponder];
    
    switch (indexPath.row) {
        case 0:
            // 地址
        {
            PDAddressViewController *address = [[PDAddressViewController alloc] init];
            address.isForOrder = YES;
            address.selectDelegete = self;
            [self.navigationController pushViewController:address animated:YES];
            
        }
            break;
        case 1:
            // 优惠券
        {
        
            PDCouponViewController *coupon = [[PDCouponViewController alloc] init];
            coupon.isForOrder = YES;
            coupon.selectDelegate = self;
            [self.navigationController pushViewController:coupon animated:YES];
        }
            break;
        case 2:
            //
        {
        
        }
            break;
        case 3:
            // 时间
        {
            PDOrderTimeViewController *time = [[PDOrderTimeViewController alloc] init];
            time.selectDelegete = self;
            [self.navigationController pushViewController:time animated:YES];
        
        }
            break;
        case 4:
            //
        {

        
        }
            break;
        case 5:
            //
        {
        
        }
            break;
            
        default:
            break;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (_canResignFirstResponder) {
        [self.view findAndResignFirstResponder];
    }
}

// 控制拖动收回键盘
-(void)enableResignFirstResponder{
    _canResignFirstResponder = YES;
}

// 开始输入手机号
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell phoneTextFieldDidBeginEditing:(UITextField *)textField{

    _canResignFirstResponder = NO;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self performSelector:@selector(enableResignFirstResponder) withObject:nil afterDelay:0.3];
    
}

// 开始输入其它要求
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell requestTextViewDidBeginEditing:(UITextView *)textView{

    _canResignFirstResponder = NO;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self performSelector:@selector(enableResignFirstResponder) withObject:nil afterDelay:0.3];
}

-(void)pdAddressViewController:(UIViewController *)vc didSelectAddress:(PDModelAddress *)address{

    NSLog(@"%@",address);
    
    _currentAddress = address;

    // 地址
    PDOrderSubmitCellItem *item = _cellItems[0];
    item.extInfo = @{@"isActive":@YES,@"isShowArrow":@YES};
    item.data = [NSString stringWithFormat:@"地址：%@",_currentAddress.address];
    
    // 手机
    PDOrderSubmitCellItem *item2 = _cellItems[2];
    item2.data = _currentAddress.phone;
    
    [self.tableView reloadData];
}

-(void)pdCouponViewController:(UIViewController *)vc didSelectCoupon:(PDModelCoupon *)coupon{


    NSLog(@"%@",coupon);
    
    _currentCoupon = coupon;
    PDOrderSubmitCellItem *item = _cellItems[1];
    item.extInfo = @{@"isActive":@YES,@"isShowArrow":@YES};
    item.data = [NSString stringWithFormat:@"优惠券：%@元",coupon.price];
    [self.tableView reloadData];
}

-(void)pdOrderTimeViewController:(UIViewController *)vc didSelectTime:(NSString *)time{

    NSLog(@"%@",time);
    
    _currentTime = time;
    PDOrderSubmitCellItem *item = _cellItems[3];
    item.extInfo = @{@"isActive":@YES,@"isShowArrow":@YES};
    item.data = [NSString stringWithFormat:@"就餐时间：%@", _currentTime];
    [self.tableView reloadData];
}

@end
