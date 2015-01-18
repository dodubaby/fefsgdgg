//
//  PDAddressDistrictViewController.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseTableViewController.h"


@protocol PDAddressDistrictViewControllerDelegate;
@interface PDAddressDistrictViewController : PDBaseTableViewController


@property (nonatomic,weak) id<PDAddressDistrictViewControllerDelegate> selectDelegate;

@property (nonatomic,strong) NSArray *dataList;

@end


@protocol PDAddressDistrictViewControllerDelegate <NSObject>

-(void)pdAddressDistrictViewController:(UIViewController *)vc didSelectDistrict:(PDModelDistrict *)district;

@end