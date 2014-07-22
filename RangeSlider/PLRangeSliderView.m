//
//  PLRangeSliderView.m
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import "PLRangeSliderView.h"

typedef NS_ENUM(NSUInteger, RangeSliderSide) {
    RangeSliderSideNone,
    RangeSliderSideLeft,
    RangeSliderSideRight
};

CGFloat const kSlideHandleWidth = 26;
CGFloat const kSlideHandleHeight = 31;

@interface PLRangeSliderView ()

@property(assign, nonatomic) CGPoint touchBegin;
@property(assign, nonatomic) RangeSliderSide selectedSide;
@property(assign, nonatomic) RangeSliderSide lastSelectedSide;

@property(assign, nonatomic) CGFloat lastLeft;
@property(assign, nonatomic) CGFloat lastRight;

@end

@implementation PLRangeSliderView

#pragma mark - Private

- (CGPoint)pointFromEvent:(UIEvent *)event {
    UITouch *touch = event.allTouches.anyObject;
    return [touch locationInView:self];
}

- (CGFloat)unitToOnePixel {
    return self.maxValue / self.maxPixel;
}

- (CGFloat)positionInPixelLeft {
    CGFloat fromLeft = self.left - self.minValue;
    return fromLeft / self.unitToOnePixel;
}

- (CGFloat)positionInPixelRight {
    CGFloat fromRight = self.right - self.minValue;
    return fromRight / self.unitToOnePixel;
}

- (CGFloat)currentInPixel {
    
    if(self.selectedSide == RangeSliderSideLeft) {
        return self.positionInPixelLeft;
    }else if(self.selectedSide == RangeSliderSideRight) {
        return self.positionInPixelRight;
    }
    
    return 0.0;
    
}

- (CGFloat)maxPixel {
    return self.frame.size.width - kSlideHandleWidth;
}

#pragma mark - Init

- (void)__config {
    
    self.slideHandleImageHighlighted = [UIImage imageNamed:@"slider-handle-highlighted"];
    self.slideHandleImageNormal = [UIImage imageNamed:@"slider-handle"];

    self.left = self.minValue = 0;
    self.right = self.maxValue = 10000000;
    self.lineHeight = 2;
    
    CGRect frame = self.frame;
    frame.size.height = kSlideHandleHeight;
    self.frame = frame;
    
    self.opaque = NO;
    self.selectedSide = RangeSliderSideNone;
    
    self.lineColorActive = [UIColor colorWithRed:37.0/255.0 green:165.0/255.0 blue:225.0/255.0 alpha:1.0];
    self.lineColorInactive = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1.0];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self __config];
    }
    return self;
}

#pragma mark - Draw events

- (void)drawRect:(CGRect)rect {
    
    CGFloat leftPosition = [self positionInPixelLeft];
    CGFloat diffLeftRightSize = [self positionInPixelRight] - leftPosition;
    
    CGFloat middleSelf = (self.frame.size.height / 2.0);
    CGFloat middleLine = (self.lineHeight / 2.0);
    CGRect off = {1, middleSelf - middleLine, CGRectGetWidth(self.frame) - 2, self.lineHeight};
    CGRect on = {leftPosition + 1, middleSelf - middleLine, diffLeftRightSize - 1, self.lineHeight};
    
    [self.lineColorInactive setFill];
    UIRectFill(off);
    
    [self.lineColorActive setFill];
    UIRectFill(on);
    
    if(self.selectedSide == RangeSliderSideLeft) {
        [self drawImageWithPosition:[self positionInPixelRight] isHighlighted:NO];
        [self drawImageWithPosition:[self positionInPixelLeft] isHighlighted:YES];
    }else if(self.selectedSide == RangeSliderSideRight){
        [self drawImageWithPosition:[self positionInPixelLeft] isHighlighted:NO];
        [self drawImageWithPosition:[self positionInPixelRight] isHighlighted:YES];
    }else{
        
        if(self.lastSelectedSide == RangeSliderSideLeft) {
            [self drawImageWithPosition:[self positionInPixelRight] isHighlighted:NO];
            [self drawImageWithPosition:[self positionInPixelLeft] isHighlighted:NO];
        }else{
            [self drawImageWithPosition:[self positionInPixelLeft] isHighlighted:NO];
            [self drawImageWithPosition:[self positionInPixelRight] isHighlighted:NO];
        }
        
    }
    
}

- (void)drawImageWithPosition:(CGFloat)position isHighlighted:(BOOL)highlighted {

    UIImage *image;
    
    if(highlighted) {
        image = self.slideHandleImageHighlighted;
    }else{
        image = self.slideHandleImageNormal;
    }
    
    CGRect drawImageRect = {position, 0, kSlideHandleWidth, kSlideHandleHeight};
    
    [image drawInRect:drawImageRect];
    
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.touchBegin = [self pointFromEvent:event];
    self.lastLeft = self.left;
    self.lastRight = self.right;
    
    CGFloat leftFirstPixel = [self positionInPixelLeft];
    CGFloat rightFirstPixel = [self positionInPixelRight];
    
    if(CGRectContainsPoint(CGRectMake(leftFirstPixel, 0, kSlideHandleWidth, kSlideHandleHeight), self.touchBegin)) {
        self.selectedSide = RangeSliderSideLeft;
    }else if(CGRectContainsPoint(CGRectMake(rightFirstPixel, 0, kSlideHandleWidth, kSlideHandleHeight), self.touchBegin)) {
        self.selectedSide = RangeSliderSideRight;
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(self.selectedSide == RangeSliderSideNone) return;
    
    CGPoint moved  = [self pointFromEvent:event];
    CGFloat dif = moved.x - self.touchBegin.x;
    
    CGFloat realValue = dif * self.unitToOnePixel;
    
    [self updatePosition:realValue];
    
    [self setNeedsDisplay];
    
    if([self.delegate respondsToSelector:@selector(didChangeValueOnMove: left: right:)]) {
        [self.delegate didChangeValueOnMove:self left:self.left right:self.right];
    }
    
}

- (void)updatePosition:(CGFloat)updateValue {
    
    if(self.selectedSide == RangeSliderSideLeft) {
    
        self.left = self.lastLeft + updateValue;
        
        if(self.left < self.minValue) {
            self.left = self.minValue;
        }else if(self.left > self.maxValue) {
            self.left = self.maxValue;
        }
        
        if(self.left > self.right) {
            
            //define temp vars
            CGFloat tmpLeft = self.left;
            CGFloat tmpRight = self.right;
            
            //get current diference
            self.left = self.lastLeft;
            CGFloat diffBegin = self.touchBegin.x - [self positionInPixelLeft];
            
            //Change current value
            self.lastRight = self.right = tmpLeft;
            self.lastLeft = self.left = tmpRight;
            
            self.touchBegin = CGPointMake([self positionInPixelRight] + diffBegin, self.touchBegin.y);
            self.selectedSide = RangeSliderSideRight;
 
        }
        
    }else if(self.selectedSide == RangeSliderSideRight){
        
        self.right = self.lastRight + updateValue;
        
        if(self.right < self.minValue) {
            self.right = self.minValue;
        }else if(self.right > self.maxValue) {
            self.right = self.maxValue;
        }
        
        if(self.right < self.left) {

            //define temp vars
            CGFloat tmpLeft = self.left;
            CGFloat tmpRight = self.right;
            
            //get current diference
            self.right = self.lastRight;
            CGFloat diffBegin = self.touchBegin.x - [self positionInPixelRight];
            
            //Change current value
            self.lastRight = self.right = tmpLeft;
            self.lastLeft = self.left = tmpRight;
            
            self.touchBegin = CGPointMake([self positionInPixelLeft] + diffBegin, self.touchBegin.y);
            self.selectedSide = RangeSliderSideLeft;
            
        }
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.lastSelectedSide = self.selectedSide;
    self.selectedSide = RangeSliderSideNone;
    
    [self setNeedsDisplay];
    
    if([self.delegate respondsToSelector:@selector(didChangeValueOnUp: left: right:)]) {
        [self.delegate didChangeValueOnUp:self left:self.left right:self.right];
    }
    
}

#pragma mark - Override

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height = kSlideHandleHeight;
    [super setFrame:frame];
}

- (void)setMinValue:(CGFloat)minValue {
    _minValue = minValue;
    if(_minValue > self.maxValue) {
        _minValue = self.maxValue;
    }
    if(_minValue < 0) {
        _minValue = 0;
    }
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    if(_maxValue < self.minValue) {
        _maxValue = self.minValue;
    }
}

- (void)setLeft:(CGFloat)left {
    _left = left;
    if(_left < self.minValue) {
        _left = self.minValue;
    }
}

- (void)setRight:(CGFloat)right {
    _right = right;
    if(_right > self.maxValue) {
        _right = self.maxValue;
    }
}

@end