//
//  PDModelNews.h
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"


@interface PDModelNews : PDBaseModel

@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *news_id;
@property (nonatomic,strong) NSString *time_str;
@property (nonatomic,strong) NSString *title;


@property (nonatomic,strong) NSString *contents;
@property (nonatomic,strong) NSString *like;
@property (nonatomic,strong) NSString *read;

@property (nonatomic,strong) NSString *is_read;// 新标记

@end
