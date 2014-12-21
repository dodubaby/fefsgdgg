//
//  PDOrderLogisticsView.m
//  PDKitchen
//
//  Created by bright on 14/12/21.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderLogisticsView.h"
#import "PDBaseTableViewCell.h"

@interface PDOrderLogisticsView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *leftTableView;
    
    NSMutableArray *list;
}

@end

@implementation PDOrderLogisticsView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        list = [[NSMutableArray alloc] initWithObjects:
                @"1111",
                @"2222",
                @"3333",
                @"4444",
                @"1111",
                @"2222",
                @"3333",
                @"4444",
                @"1111",
                @"2222",
                @"3333",
                @"4444",
                @"1111",
                @"2222",
                @"3333",
                @"4444",nil];
        
        leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, list.count*80) style:UITableViewStylePlain];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = list[indexPath.row];
    [cell setData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
