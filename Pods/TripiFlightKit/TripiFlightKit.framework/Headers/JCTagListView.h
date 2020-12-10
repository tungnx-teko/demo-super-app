//
//  JCTagListView.h
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JCTagListViewBlock)(NSInteger index);

@interface JCTagListView : UIView

@property (nonatomic, strong) UIColor *deselectBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *deselectTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *selectedBorderColor;
@property (nonatomic, strong) UIColor *deselectBorderColor;

@property (nonatomic, assign) CGFloat tagBorderWidth;

@property (nonatomic, assign) CGFloat tagCornerRadius;

@property (nonatomic, assign) BOOL canSeletedTags;

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *seletedTags;

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setCompletionBlockWithSeleted:(JCTagListViewBlock)completionBlock;

@end
