//
//  PLRangeSliderView.h
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RangeSliderSide) {
    RangeSliderSideNone,
    RangeSliderSideLeft,
    RangeSliderSideRight
};

@class PLRangeSliderView;

@interface PLRangeSliderView : UIControl

/**
 *  Default is NO, but if you need cancel gesture recognizer set this property to YES
 */
@property(assign, nonatomic) BOOL cancelGestureRecognizer;

/**
 *  Default is NO
 */
@property(assign, nonatomic) BOOL singleRange;

@property(strong, nonatomic) UIColor *lineColorActive;
@property(strong, nonatomic) UIColor *lineColorInactive;

@property(strong, nonatomic) UIColor *circleColorActive;
@property(strong, nonatomic) UIColor *circleColorInactive;

@property(strong, nonatomic) UIColor *circleBorderColorActive;
@property(strong, nonatomic) UIColor *circleBorderColorInactive;

@property(strong, nonatomic) UIImage *slideHandleImageNormal;
@property(strong, nonatomic) UIImage *slideHandleImageHighlighted;

@property(assign, nonatomic) CGFloat lineHeight;

@property(assign, nonatomic) CGFloat maximumValue;
@property(assign, nonatomic) CGFloat minimumValue;

@property(assign, nonatomic) CGFloat selectedMaximumValue;
@property(assign, nonatomic) CGFloat selectedMinimumValue;

@property(assign, nonatomic, getter = isMoved, readonly) BOOL moved;
@property(assign, nonatomic, readonly) RangeSliderSide lastSelectedSide;

@end
