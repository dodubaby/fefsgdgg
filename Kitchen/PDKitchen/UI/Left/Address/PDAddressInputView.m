//
//  PDAddressInputView.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDAddressInputView.h"

@implementation PDAddressInputView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        
        CGFloat buttonWidth = (frame.size.width - 30)/2;
        
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        [self addSubview:line];
        
        _city = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, buttonWidth, 50)];
        [self addSubview:_city];
        _city.backgroundColor = [UIColor whiteColor];
        _city.titleLabel.font = [UIFont systemFontOfSize:15];
        [_city setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _city.layer.borderWidth = 0.5f;
        _city.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        [_city setTitle:@"北京市" forState:UIControlStateNormal];
        
        _district = [[UIButton alloc] initWithFrame:CGRectMake(20+buttonWidth, 10, buttonWidth, 50)];
        [self addSubview:_district];
        _district.backgroundColor = [UIColor whiteColor];
        _district.titleLabel.font = [UIFont systemFontOfSize:15];
        [_district setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _district.layer.borderWidth = 0.5f;
        _district.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        [_district setTitle:@"朝阳区" forState:UIControlStateNormal];
        [_district handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            
            if (_delegate&&[_delegate respondsToSelector:@selector(pdAddressInputView:districtButtonTaped:)]) {
                [_delegate pdAddressInputView:self districtButtonTaped:nil];
            }
        }];
        
        
        _address = [[UITextField alloc] initWithFrame:CGRectMake(10, _city.bottom+10, frame.size.width-20, 50)];
        _address.delegate = self;
        [self addSubview:_address];
        _address.backgroundColor = [UIColor whiteColor];
        _address.font = [UIFont systemFontOfSize:15];
        _address.textColor = [UIColor colorWithHexString:@"#333333"];
        _address.layer.borderWidth = 0.5f;
        _address.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        _address.placeholder = @"详细地址";
        
        _phone = [[UITextField alloc] initWithFrame:CGRectMake(10, _address.bottom+10, frame.size.width-20, 50)];
        _phone.delegate = self;
        [self addSubview:_phone];
        _phone.backgroundColor = [UIColor whiteColor];
        _phone.placeholder = @"手机号";
        _phone.font = [UIFont systemFontOfSize:15];
        _phone.textColor = [UIColor colorWithHexString:@"#333333"];
        _phone.layer.borderWidth = 0.5f;
        _phone.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
    }
    
    return self;
}

-(void)reset{
    [_district setTitle:@"" forState:UIControlStateNormal];
    _address.text = nil;
    _phone.text = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [UIView animateWithDuration:0.3 animations:^{
        self.top = self.top - 190;
    } completion:^(BOOL finished) {
        //
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    [UIView animateWithDuration:0.3 animations:^{
        self.top = self.top + 190;
    } completion:^(BOOL finished) {
        //
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}


@end
