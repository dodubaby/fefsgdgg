//
//  PDSettingTableViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDSettingTableViewController.h"
#import "PDSettingCell.h"

@interface PDSettingTableViewController ()
{
    NSMutableArray *list;
}
@end

@implementation PDSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    list=[[NSMutableArray alloc] init];
    [list addObject:@"检查更新"];
    [list addObject:@"退出账号"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDSettingCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellstring=@"PDSettingCell";
    PDSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstring];
    if (!cell) {
        cell = [[PDSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstring];
    }
    [cell setData:[list objectAtIndex:indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有新版本" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"立即更新",@"稍后更新", nil];
        
        [alert showWithClickedBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 0:
                    //
                {
                    NSLog(@"立即更新");
                    
                    
                }
                    
                    break;
                case 1:
                    //
                {
                    NSLog(@"稍后更新");
                    
                }
                    break;
                default:
                    break;
            }
        }];
    }else{
        AppDelegate *app=[[UIApplication sharedApplication] delegate];
        [app changetoLoginViewController];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
