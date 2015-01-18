//
//  PDAddressInputView.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseView.h"

@protocol PDAddressInputViewDelegate;

@interface PDAddressInputView : PDBaseView<UITextFieldDelegate>


@property (nonatomic,weak) id <PDAddressInputViewDelegate> delegate;

@property (nonatomic,strong) UIButton *city;
@property (nonatomic,strong) UIButton *district;

@property (nonatomic,strong) UITextField *address;
@property (nonatomic,strong) UITextField *phone;

-(void)reset;

@end


@protocol PDAddressInputViewDelegate <NSObject>

-(void)pdAddressInputView:(UIView *)addressView districtButtonTaped:(id)sender;

@end