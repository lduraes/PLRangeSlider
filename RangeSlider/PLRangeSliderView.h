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

@interface PLRangeSliderView : UIControl

@property(assign, nonatomic) CGFloat mininumValue;
@property(assign, nonatomic) CGFloat maximumValue;

@property(assign, nonatomic) CGFloat selectedMininumValue;
@property(assign, nonatomic) CGFloat selectedMaximumValue;

@property(assign, nonatomic) CGFloat lineHeight;

@property(strong, nonatomic) UIColor *lineColorActive;
@property(strong, nonatomic) UIColor *lineColorInactive;

@property(strong, nonatomic) UIImage *slideHandleImageNormal;
@property(strong, nonatomic) UIImage *slideHandleImageHighlighted;

/**
 *  Default is NO, but if you need cancel gesture recognizer set this property to YES
 */
@property(assign, nonatomic) BOOL cancelGestureRecognizer;

@property(weak, nonatomic) IBOutlet id<PLRangeSliderViewDelegate> delegate;

@end
