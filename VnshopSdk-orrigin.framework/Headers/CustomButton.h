//
//  CustomButton.h
//  ProjectBase
//
//  Created by Eragon on 7/20/17.
//  Copyright © 2017 longtd. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomButton : UIButton

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor* borderColor;
@property (nonatomic, assign, getter=isLeftToRight) IBInspectable BOOL leftToRight;
@property (nonatomic, assign) CGFloat topCornerRadius;
@property (nonatomic, assign) CGFloat bottomCornerRadius;

- (void)initBase;
- (void)setImageAboveText;

@end
