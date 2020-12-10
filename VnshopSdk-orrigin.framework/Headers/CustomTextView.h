//
//  LPTextView.h
//  LifePalette
//
//  Created by Tinhvv on 7/16/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CustomTextView : UITextView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor* borderColor;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@property (nonatomic, assign) IBInspectable CGFloat paddingLeft;
@property (nonatomic, assign) IBInspectable CGFloat paddingTop;
@property (nonatomic, assign) IBInspectable CGFloat paddingBottom;
@property (nonatomic, assign) IBInspectable CGFloat paddingRight;

@property (nonatomic, assign) BOOL expandable;
@end
