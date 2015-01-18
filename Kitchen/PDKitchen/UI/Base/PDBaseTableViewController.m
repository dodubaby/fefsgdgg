//
//  PDBaseTableViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseTableViewController.h"

@interface PDBaseTableViewController ()
{
//    
//
//    UIView *loadingView;
//    UIImageView *animView;
}

@end

@implementation PDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    //修复下拉刷新位置错误
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }
}

-(void)backButtonTaped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupBackButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"center_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

// 登陆
-(BOOL)userLogined{
    if (![PDAccountManager sharedInstance].isLogined) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowLoginNotificationKey object:nil];
        return NO;
    }
    return YES;
}

//-(void)startLoading{
//    
//    if (!loadingView) {
//        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight)];
//        loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//        
//        animView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
//        [loadingView addSubview:animView];
//        animView.center = CGPointMake(kAppWidth/2, kAppHeight/2);
//        animView.animationRepeatCount = -1;
//        animView.animationDuration = 0.5;
//        animView.animationImages = @[[UIImage imageNamed:@"loading1"],
//                                     [UIImage imageNamed:@"loading2"],
//                                     [UIImage imageNamed:@"loading3"],
//                                     [UIImage imageNamed:@"loading4"],];
//        
//        
//    }
//    
//    [self.view addSubview:loadingView];
//    [animView startAnimating];
//}
//
//-(void)stopLoading{
//    [loadingView removeFromSuperview];
//    [animView stopAnimating];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
