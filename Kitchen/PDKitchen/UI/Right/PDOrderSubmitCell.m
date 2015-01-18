//
//  PDOrderSubmitCell.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDOrderSubmitCell.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PDOrderSubmitCell()
{
    
    UILabel *address;
    
    NSMutableArray *list;
    
}

@end

@implementation PDOrderSubmitCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        CGFloat h = [PDOrderSubmitCell cellHeightWithData:nil];
        
        _back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, h-kCellLeftGap)];
        [self addSubview:_back];
        _back.layer.borderWidth = 0.5f;
        _back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        address = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, _back.width - 2*kCellLeftGap, _back.height)];
        [_back addSubview:address];
        address.numberOfLines = 2;
        address.font = [UIFont systemFontOfSize:15];
        address.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _back.height = self.height - kCellLeftGap;
}

-(void)configData:(id)data{
    
    
    address.frame = CGRectMake(kCellLeftGap, 0, _back.width - 2*kCellLeftGap, _back.height);
    
    if ([data isKindOfClass:[NSString class]]) {
        address.text = data;
    }
    
    [address sizeToFit];
    address.top = (_back.height - address.height)/2;
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 50+kCellLeftGap;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation PDOrderSubmitPhoneCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self.back addSubview:_textField];
        _textField.placeholder = @"输入你的手机号";
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor colorWithHexString:@"#333333"];
        _textField.delegate = self;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _textField.frame = CGRectMake(kCellLeftGap, 0, self.back.width - 2*kCellLeftGap, self.back.height);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 50+kCellLeftGap;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation PDOrderSubmitRequestCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        [self.back addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _textView.frame = CGRectMake(kCellLeftGap, 0, self.back.width - 2*kCellLeftGap, self.back.height);
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 100+kCellLeftGap;
}

@end


