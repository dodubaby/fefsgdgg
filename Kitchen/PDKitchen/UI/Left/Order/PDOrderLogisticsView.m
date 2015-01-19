//
//  PDOrderLogisticsView.m
//  PDKitchen
//
//  Created by bright on 14/12/21.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderLogisticsView.h"
#import "PDLogisticsCell.h"

@interface PDOrderLogisticsView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *leftTableView;
}

@end

@implementation PDOrderLogisticsView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        
        leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, frame.size.height) style:UITableViewStylePlain];
        leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        [self addSubview:leftTableView];
        
        if (leftTableView.height<=self.height) {
            leftTableView.scrollEnabled = NO;
        }else{
            leftTableView.scrollEnabled = YES;
            leftTableView.height = self.height;
        }
    }
    return self;
}


-(void)setList:(NSMutableArray *)list_{

    _list = list_;
    [leftTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDLogisticsCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDLogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //cell.textLabel.text = list[indexPath.row];
    
    if (indexPath.row == _list.count-1) {
        cell.isCurrent = @YES;
    }else{
        cell.isCurrent = @NO;
    }
    [cell setData:_list[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
