//
//  PDOrderSubmitCell.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseTableViewCell.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PDOrderSubmitCell : PDBaseTableViewCell
@property (nonatomic,strong) UIView *back;
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PDOrderSubmitPhoneCell : PDOrderSubmitCell<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PDOrderSubmitRequestCell : PDOrderSubmitCell

@property (nonatomic,strong) UITextView *textView;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////