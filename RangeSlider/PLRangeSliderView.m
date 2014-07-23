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

CGFloat const kSlideHandleWidth = 32;
CGFloat const kSlideHandleHeight = 38;

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
    return (self.maximumValue - self.mininumValue) / self.maxPixel;
}

- (CGFloat)positionInPixelLeft {
    CGFloat fromLeft = self.selectedMininumValue - self.mininumValue;
    return fromLeft / self.unitToOnePixel;
}

- (CGFloat)positionInPixelRight {
    CGFloat fromRight = self.selectedMaximumValue - self.mininumValue;
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
    
//    self.slideHandleImageHighlighted = [UIImage imageNamed:@"slider-handle-highlighted"];
//    self.slideHandleImageNormal = [UIImage imageNamed:@"slider-handle"];

    self.selectedMininumValue = self.mininumValue = 0;
    self.selectedMaximumValue = self.maximumValue = 10000000;
    self.lineHeight = 2;
    
    self.cancelGestureRecognizer = NO;
    self.opaque = NO;
    self.selectedSide = RangeSliderSideNone;
    
    self.lineColorActive = [UIColor colorWithRed:37.0/255.0 green:165.0/255.0 blue:225.0/255.0 alpha:1.0];
    self.lineColorInactive = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1.0];
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self __config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
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
    CGRect on = {leftPosition + kSlideHandleWidth - 1, middleSelf - middleLine, diffLeftRightSize - kSlideHandleWidth + 2, self.lineHeight};
    
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
    
    if(image) {
        [image drawInRect:drawImageRect];
    }else{
        [self drawCircleInRect:drawImageRect isHighlighted:highlighted];
    }
    
}

- (void)drawCircleInRect:(CGRect)rect isHighlighted:(BOOL)highlighted {
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    if(highlighted) {
        CGContextSetRGBFillColor(context, 154.0/255.0, 154.0/255.0, 154.0/255.0, 1.0);
        CGContextSetRGBStrokeColor(context, 27.0/255.0, 155.0/255.0, 215.0/255.0, 1.0);
    }else{
        CGContextSetRGBFillColor(context, 184.0/255.0, 184.0/255.0, 184.0/255.0, 1.0);
        CGContextSetRGBStrokeColor(context, 37.0/255.0, 165.0/255.0, 225.0/255.0, 1.0);
    }
    
    CGFloat centerX = rect.origin.x + (rect.size.width / 2.0);
    CGFloat centerY = rect.origin.y + (rect.size.height / 2.0);
    
    CGPoint center = CGPointMake(centerX, centerY);
    CGFloat radius = (rect.size.width - 1)  / 2.0;
    CGFloat startAngle = M_PI;
    CGFloat endAngle = (2.0 * M_PI) + startAngle;
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0.0);
    
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0.0);
    CGContextDrawPath(context, kCGPathStroke);
    
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.touchBegin = [self pointFromEvent:event];
    self.lastLeft = self.selectedMininumValue;
    self.lastRight = self.selectedMaximumValue;
    
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
        [self.delegate didChangeValueOnMove:self left:self.selectedMininumValue right:self.selectedMaximumValue];
    } 
    
}

- (void)updatePosition:(CGFloat)updateValue {
    
    if(self.selectedSide == RangeSliderSideLeft) {
     
        _selectedMininumValue = self.lastLeft + updateValue;
        
        if(self.selectedMininumValue < self.mininumValue) {
            _selectedMininumValue = self.mininumValue;
        }else if(self.selectedMininumValue > self.maximumValue) {
            _selectedMininumValue = self.maximumValue;
        }
        
        if(self.selectedMininumValue > self.selectedMaximumValue) {
            
            //define temp vars
            CGFloat tmpLeft = self.selectedMininumValue;
            CGFloat tmpRight = self.selectedMaximumValue;
            
            //get current diference
            _selectedMininumValue = self.lastLeft;
            CGFloat diffBegin = self.touchBegin.x - [self positionInPixelLeft];
            
            //Change current value
            self.lastRight = self.selectedMaximumValue = tmpLeft;
            self.lastLeft = self.selectedMininumValue = tmpRight;
            
            self.touchBegin = CGPointMake([self positionInPixelRight] + diffBegin, self.touchBegin.y);
            self.selectedSide = RangeSliderSideRight;
 
        }
        
    }else if(self.selectedSide == RangeSliderSideRight){
        
        _selectedMaximumValue = self.lastRight + updateValue;
        
        if(self.selectedMaximumValue < self.mininumValue) {
            _selectedMaximumValue = self.mininumValue;
        }else if(self.selectedMaximumValue > self.maximumValue) {
            _selectedMaximumValue = self.maximumValue;
        }
        
        if(self.selectedMaximumValue < self.selectedMininumValue) {

            //define temp vars
            CGFloat tmpLeft = self.selectedMininumValue;
            CGFloat tmpRight = self.selectedMaximumValue;
            
            //get current diference
            _selectedMaximumValue = self.lastRight;
            CGFloat diffBegin = self.touchBegin.x - [self positionInPixelRight];
            
            //Change current value
            self.lastRight = self.selectedMaximumValue = tmpLeft;
            self.lastLeft = self.selectedMininumValue = tmpRight;
            
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
        [self.delegate didChangeValueOnUp:self left:self.selectedMininumValue right:self.selectedMaximumValue];
    }
    
}

#pragma mark - Override

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return !self.cancelGestureRecognizer;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, kSlideHandleHeight)];
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kSlideHandleHeight)];
    [self setNeedsDisplay];
}

- (void)setMininumValue:(CGFloat)mininumValue {
    
    _mininumValue = mininumValue;
    
    if(_mininumValue > self.maximumValue) {
        _mininumValue = self.maximumValue;
    }else if(_mininumValue < 0) {
        _mininumValue = 0;
    }
    
    [self setSelectedMininumValue:self.selectedMininumValue];
    
}

- (void)setMaximumValue:(CGFloat)maximumValue {
    
    _maximumValue = maximumValue;
    
    if(_maximumValue <= self.mininumValue) {
        _maximumValue = self.mininumValue + 1.0;
    }
    
    [self setSelectedMaximumValue:self.selectedMaximumValue];
    
}

- (void)setSelectedMininumValue:(CGFloat)selectedMininumValue {
    
    _selectedMininumValue = selectedMininumValue;
    
    if(_selectedMininumValue < self.mininumValue) {
        _selectedMininumValue = self.mininumValue;
    }else if(_selectedMininumValue > self.selectedMaximumValue) {
        _selectedMininumValue = self.selectedMaximumValue;
    }

    [self setNeedsDisplay];

}

- (void)setSelectedMaximumValue:(CGFloat)selectedMaximumValue {
    
    _selectedMaximumValue = selectedMaximumValue;
    
    if(_selectedMaximumValue > self.maximumValue) {
        _selectedMaximumValue = self.maximumValue;
    }else if(_selectedMaximumValue < self.selectedMininumValue) {
        _selectedMaximumValue = self.selectedMininumValue;
    }
    
    [self setNeedsDisplay];
    
}

- (void)setSlideHandleImageHighlighted:(UIImage *)slideHandleImageHighlighted {
    
    if(_slideHandleImageHighlighted != slideHandleImageHighlighted) {
        _slideHandleImageHighlighted = slideHandleImageHighlighted;
        [self setNeedsDisplay];
    }
    
}

- (void)setSlideHandleImageNormal:(UIImage *)slideHandleImageNormal {
    
    if(_slideHandleImageNormal != slideHandleImageNormal) {
        _slideHandleImageNormal = slideHandleImageNormal;
        [self setNeedsDisplay];
    }
    
}

- (void)setLineHeight:(CGFloat)lineHeight {
    
    if(_lineHeight != lineHeight) {
        _lineHeight = lineHeight < 0 ? 1 : lineHeight;
        [self setNeedsDisplay];
    }
    
}

- (void)setLineColorActive:(UIColor *)lineColorActive {
    
    if(_lineColorActive != lineColorActive) {
        _lineColorActive = lineColorActive;
        [self setNeedsDisplay];
    }
    
}

- (void)setLineColorInactive:(UIColor *)lineColorInactive {
    
    if(_lineColorInactive != lineColorInactive) {
        _lineColorInactive = lineColorInactive;
        [self setNeedsDisplay];
    }
    
}

@end