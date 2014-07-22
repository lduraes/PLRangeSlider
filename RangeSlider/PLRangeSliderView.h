//
//  PLRangeSliderView.h
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PLRangeSliderViewDelegate <NSObject>

@optional
- (void)didChangeValueOnMove:(id)sender left:(CGFloat)left right:(CGFloat)right;
- (void)didChangeValueOnUp:(id)sender left:(CGFloat)left right:(CGFloat)right;

@end

@interface PLRangeSliderView : UIView

@property(assign, nonatomic) CGFloat minValue;
@property(assign, nonatomic) CGFloat maxValue;

@property(assign, nonatomic) CGFloat left;
@property(assign, nonatomic) CGFloat right;

@property(assign, nonatomic) CGFloat lineHeight;

@property(strong, nonatomic) UIColor *lineColorActive;
@property(strong, nonatomic) UIColor *lineColorInactive;

@property(strong, nonatomic) UIImage *slideHandleImageNormal;
@property(strong, nonatomic) UIImage *slideHandleImageHighlighted;

@property(weak, nonatomic) id<PLRangeSliderViewDelegate> delegate;
@end
