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
    
    UIImageView *arrow;
    
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
        
        arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"od_expand"]];
        [_back addSubview:arrow];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _back.height = self.height - kCellLeftGap;
    
    arrow.top = (_back.height - arrow.height)/2;
    arrow.right = _back.width - 5;
}

-(void)configData:(id)data{
    
    
    address.frame = CGRectMake(kCellLeftGap, 0, _back.width - 2*kCellLeftGap, _back.height);
    
    if ([data isKindOfClass:[NSString class]]) {
        address.text = data;
    }
    
    [address sizeToFit];
    address.top = (_back.height - address.height)/2;
    
    BOOL active = [_extInfo[@"isActive"] boolValue];
    if (active) { // 激活颜色
        address.textColor = [UIColor colorWithHexString:@"#333333"];
    }else{
        address.textColor = [UIColor colorWithHexString:@"#e6e6e6"];
    }
    
    BOOL isShowArrow = [_extInfo[@"isShowArrow"] boolValue];
    if (isShowArrow) {
        [_back bringSubviewToFront:arrow];
        arrow.hidden = NO;
    }else{
        arrow.hidden = YES;
    }
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
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

-(void)configData:(id)data{
    
    [super configData:data];
    
    if ([data isKindOfClass:[NSString class]]) {
        _textField.text = data;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:phoneTextFieldDidBeginEditing:)]) {
        [self.delegate pdBaseTableViewCellDelegate:self phoneTextFieldDidBeginEditing:textField];
    }
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
        _textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectZero];
        [self.back addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = [UIColor colorWithHexString:@"#333333"];
        _textView.placeholder = @"输入你的特殊要求";
        _textView.delegate = self;
    }
    return self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:requestTextViewDidBeginEditing:)]) {
        [self.delegate pdBaseTableViewCellDelegate:self requestTextViewDidBeginEditing:textView];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _textView.frame = CGRectMake(kCellLeftGap-5, 0, self.back.width - 2*kCellLeftGap+10, self.back.height);
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 100+kCellLeftGap;
}

@end


