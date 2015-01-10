//
//  PDFavoritesCell.m
//  PDKitchen
//
//  Created by bright on 15/1/10.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDFavoritesCell.h"

@interface PDFavoritesCell()
{
    
    EGOImageView *thumbnail;
    EGOImageView *avatar;
    
    UILabel *name;
    UILabel *price;
    UILabel *person;
    UILabel *from;
    
    UIButton *addButton;
}
@end

@implementation PDFavoritesCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        //NSLog(@"self.width == %f",self.width);
        
        thumbnail = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_food"]];
        thumbnail.frame = CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 205);
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        thumbnail.layer.borderWidth = 0.5f;
        thumbnail.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        avatar = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_owner"]];
        avatar.frame = CGRectMake(kCellLeftGap, thumbnail.bottom + 15, 45, 45);
        [self addSubview:avatar];
        avatar.backgroundColor = [UIColor clearColor];
        avatar.layer.borderWidth = 0.5f;
        avatar.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + kCellLeftGap, avatar.top, 120, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth - kCellLeftGap -100, thumbnail.bottom+15, 100, 40)];
        price.textAlignment = NSTextAlignmentRight;
        [self addSubview:price];
        price.font = [UIFont systemFontOfSize:24];
        price.textColor = [UIColor colorWithHexString:@"#666666"];
        
    }
    
    return self;
}

-(void)configData:(id)data{
    
    name.text = @"红烧鸡腿";
    price.text = @"¥23.5";
    [price sizeToFit];
    price.right = kAppWidth - kCellLeftGap;
    //    person.text = @"person";
    [person sizeToFit];
    from.text = @"大胡子";
    
    thumbnail.image = [UIImage imageNamed:@"菜1.jpg"];
    avatar.image = [UIImage imageNamed:@"厨师.jpg"];
    
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 10+205+70;
    
    //return 210;
}

@end