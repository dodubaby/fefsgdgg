//
//  PDBaseTableViewCell.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseTableViewCell.h"

@implementation PDBaseTableViewCell


-(void)setData:(id)data{
    _data = data;
    [self configData:_data];
    
    //[self showDebugRect];
}

-(void)configData:(id)data{
    // override
    
    
}

+(CGFloat )cellHeightWithData:(id)data{
    return 44;
}

@end
