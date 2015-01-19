//
//  PDAddressViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDAddressViewController.h"
#import "PDAddressCell.h"
#import "PDAddressInputView.h"
#import "PDModel.h"

@interface PDAddressViewController ()<PDAddressInputViewDelegate,PDAddressDistrictViewControllerDelegate>
{
    PDAddressInputView *inputView;
    UIButton *cancelButton;
    UIButton *addButton;
    
    
    BOOL isShowAdd;
}

@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,assign) int currentPage;


@property (nonatomic,strong) PDModelDistrict *currentDistrict;


@property (nonatomic,strong) NSMutableArray *districtList;

@end

@implementation PDAddressViewController

- (void)setupData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bj_district.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@",result);
    NSArray *arr = result[@"data"];
    NSMutableArray *dtList = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arr) {
        PDModelDistrict *dt = [PDModelDistrict objectWithJoy:dict];
        if (dt) {
            [dtList addObject:dt];
        }
    }
    
    _districtList = dtList;
    
    if ([_districtList count]>0) {
        _currentDistrict = _districtList[0];
    }
    
    _dataList = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(_isForOrder){
        [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
    }else{
        [self.mm_drawerController setPanDisableSide:MMPanDisableSideRight];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的地址";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.height = self.view.height - 50;
    
    [self setupBackButton];
    
    [self setupData];
    
    __weak PDAddressViewController *weakSelf = self;
    
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] addressMyAddressWithUserid:userid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            if ([list count]==0) {
                [weakSelf showDefaultView];
            }
            
            weakSelf.currentPage +=1;
            
            [weakSelf.dataList removeAllObjects];
            [weakSelf.dataList addObjectsFromArray:list];
            [weakSelf.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
        
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        // 高度不够不用加载更多
        CGFloat h = [PDAddressCell cellHeightWithData:nil]*weakSelf.dataList.count;
        if (h<weakSelf.tableView.bounds.size.height) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] addressMyAddressWithUserid:userid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            
            weakSelf.currentPage +=1;
            
            if (list.count>0) {
                [weakSelf.dataList addObjectsFromArray:list];
                [weakSelf.tableView reloadData];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
        }];
    }];
    
    [self.tableView triggerPullToRefresh];
     
    
    inputView = [[PDAddressInputView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 215+50)];
    inputView.delegate = self;
    [self.view addSubview:inputView];
    
    inputView.hidden = YES;
    
    UIView *buttonBack = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50, kAppWidth, 50)];
    [self.view addSubview:buttonBack];
    buttonBack.backgroundColor = [UIColor colorWithHexString:@"#666666"];
    
    inputView.bottom = buttonBack.top+50;
    
    // 刷新区域
    [inputView.district setTitle:_currentDistrict.title forState:UIControlStateNormal];

    addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 120, 40)];
    addButton.right = buttonBack.width - 10;
    [buttonBack addSubview:addButton];
    addButton.backgroundColor = [UIColor redColor];

    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:addButton.size];
    [addButton setBackgroundImage:image forState:UIControlStateNormal];
    [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    addButton.layer.cornerRadius = 4;
    addButton.clipsToBounds = YES;
    isShowAdd = YES;
    
    [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        
        if (isShowAdd) {  // 显示添加
            inputView.hidden = NO;
            [addButton setTitle:@"添加" forState:UIControlStateNormal];
            isShowAdd = NO;
            
            cancelButton.hidden = NO;
            
        }else{
            // 添加到服务器
            if ([inputView.address.text length]==0) {
                //
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"请输入地址"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定", nil];
                [alert show];
                return ;
            }
            
            if ([inputView.phone.text length]==0) {
                //
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"请输入手机号"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定", nil];
                [alert show];
                return ;
            }
            
            NSString *userid = [PDAccountManager sharedInstance].userid;
            [[PDHTTPEngine sharedInstance] addressAddWithUserid:userid city_id:_currentDistrict.parentid district_id:_currentDistrict.id address:inputView.address.text phone:inputView.phone.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //
                
                
                inputView.hidden = YES;
                isShowAdd = YES;
                [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
                [inputView reset];
                cancelButton.hidden = YES;
                
                // 刷新区域
                [inputView.district setTitle:_currentDistrict.title forState:UIControlStateNormal];
                
                
                // 刷新数据
                [self.tableView triggerPullToRefresh];
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"地址添加成功"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定", nil];
                [alert show];
                
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //
                
                NSString *message = error.userInfo[@"Message"];
                if (!message) {
                    message = [error localizedDescription];
                }
                UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:message
                                                                delegate:nil
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
                [alert show];
            }];
        }
    }];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 120, 40)];
    [buttonBack addSubview:cancelButton];
    cancelButton.right = addButton.left - 10;
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [cancelButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        inputView.hidden = YES;
        cancelButton.hidden = YES;
        [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
        isShowAdd = YES;
    }];
    
    cancelButton.hidden = YES;
    
    [self.view bringSubviewToFront:buttonBack];
}

-(void)pdAddressInputView:(UIView *)addressView districtButtonTaped:(id)sender{

    PDAddressDistrictViewController *district = [[PDAddressDistrictViewController alloc] init];
    district.selectDelegate = self;
    district.dataList = _districtList;
    [self.navigationController pushViewController:district animated:YES];
}


-(void)pdAddressDistrictViewController:(UIViewController *)vc didSelectDistrict:(PDModelDistrict *)district{

    _currentDistrict  = district;
    [inputView.district setTitle:_currentDistrict.title forState:UIControlStateNormal];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDAddressCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataList.count==0) {
    }else{
        [self hiddenDefaultView];
    }
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.delegate = self;
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isForOrder) {
        if (_selectDelegete&&[_selectDelegete respondsToSelector:@selector(pdAddressViewController:didSelectAddress:)]) {
            [_selectDelegete pdAddressViewController:self didSelectAddress:_dataList[indexPath.row]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell deleteAddressWithData:(id)data
{
    
    PDModelAddress *ad = (PDModelAddress *)data;
    
    NSString *userid = [PDAccountManager sharedInstance].userid;
    [[PDHTTPEngine sharedInstance] addressDelWithUserid:userid address_id:ad.address_id success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        [_dataList removeObject:data];
        
        [self.tableView beginUpdates];
        NSIndexPath *indexpath=[self.tableView indexPathForCell:cell];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSString *message = error.userInfo[@"Message"];
        if (!message) {
            message = [error localizedDescription];
        }
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定", nil];
        [alert show];
        
    }];
}

@end
