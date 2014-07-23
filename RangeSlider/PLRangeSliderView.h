//
//  PLRangeSliderView.h
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLRangeSliderView;

@protocol PLRangeSliderViewDelegate <NSObject>

@optional

- (void)didChangeValueOnMove:(PLRangeSliderView *)rangeSliderView selectedMinimumValue:(CGFloat)selectedMinimumValue selectedMaximumValue:(CGFloat)selectedMaximumValue;
- (void)didChangeValueOnUp:(PLRangeSliderView *)rangeSliderView selectedMinimumValue:(CGFloat)selectedMinimumValue selectedMaximumValue:(CGFloat)selectedMaximumValue;

@end

@interface PLRangeSliderView : UIControl

/**
 *  Default is NO, but if you need cancel gesture recognizer set this property to YES
 */
@property(assign, nonatomic) BOOL cancelGestureRecognizer;

@property(weak, nonatomic) IBOutlet id<PLRangeSliderViewDelegate> delegate;

@property(strong, nonatomic) UIColor *lineColorActive;
@property(strong, nonatomic) UIColor *lineColorInactive;

@property(assign, nonatomic) CGFloat lineHeight;

@property(assign, nonatomic) CGFloat maximumValue;
@property(assign, nonatomic) CGFloat minimumValue;

@property(assign, nonatomic) CGFloat selectedMaximumValue;
@property(assign, nonatomic) CGFloat selectedMinimumValue;

@property(strong, nonatomic) UIImage *slideHandleImageNormal;
@property(strong, nonatomic) UIImage *slideHandleImageHighlighted;

@end
