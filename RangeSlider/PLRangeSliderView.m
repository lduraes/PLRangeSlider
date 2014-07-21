//
//  PLRangeSliderView.m
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import "PLRangeSliderView.h"

@interface PLRangeSliderView ()

@property(assign, nonatomic) CGPoint touchBegin;
@property(assign, nonatomic, getter = isHover) BOOL hover;
@property(assign, nonatomic) CGFloat lastLeft;

@end

@implementation PLRangeSliderView

#pragma mark - Private

- (CGFloat)pixelFromValue {
    
    CGFloat total = self.maxValue - self.minValue;
    CGFloat diff = total / self.maxPixel;
    
    return diff;
    
}

- (CGFloat)positionInPixelFromLeft {
    
    CGFloat unitToPixel = self.maxValue / self.maxPixel;
    CGFloat fromLeft = self.left - self.minValue;
    
    if(fromLeft == 0) return 0;
    
    return fromLeft * unitToPixel;
    
}

- (CGFloat)maxPixel {
    return self.frame.size.width - 23.0;
}

#pragma mark - Init

- (void)__config {
    self.left = self.minValue = 1;
    self.right = self.maxValue = 100000;
    self.lineHeight = 2;
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

#pragma mark - Override

- (void)drawRect:(CGRect)rect
{
    
    if(self.isHover) {
        
    }else{
        
    }
    
    UIImage *image = [UIImage imageNamed:@"slider-handle"];
    
    CGRect drawImageRect = {[self positionInPixelFromLeft], 0, 23.0, 23.0};
    NSLog(@"%@", NSStringFromCGRect(drawImageRect));
    
    CGFloat middleSelf = (self.frame.size.height / 2.0);
    CGFloat middleLine = (self.lineHeight / 2.0);
    CGRect off = {0, middleSelf - middleLine, CGRectGetWidth(self.frame), self.lineHeight};
    CGRect on = {0, middleSelf - middleLine, CGRectGetWidth(self.frame) / 2.0, self.lineHeight};
    
    [[UIColor redColor] setFill];
    UIRectFill(off);
    
    [[UIColor blackColor] setFill];
    UIRectFill(on);
    
    [image drawInRect:drawImageRect];
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height = 23.0;
    [super setFrame:frame];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = event.allTouches.anyObject;
    self.touchBegin = [touch locationInView:self];
    self.lastLeft = self.left;
    self.hover = YES;
    
    CGFloat lastPixel = [self positionInPixelFromLeft];
    
    //    NSLog(@"onde: %@ - %@", NSStringFromCGPoint(self.touchBegin), NSStringFromCGRect(CGRectMake(lastPixel - 11.5, 0, 23.0, 23.0)));
    
    if(!CGRectContainsPoint(CGRectMake(lastPixel, 0, 23.0, 23.0), self.touchBegin)) {
        self.hover = NO;
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!self.isHover) return;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!self.isHover) return;
    
    UITouch *touch = event.allTouches.anyObject;
    CGPoint moved  = [touch locationInView:self];
    CGFloat dif = moved.x - self.touchBegin.x;
    
    CGFloat unitToPixel = self.maxValue / self.maxPixel;
    CGFloat realValue = dif / unitToPixel;
    
    self.left = self.lastLeft + realValue;
    
    if(self.left < self.minValue) {
        self.left = self.minValue;
    }
    
    [self setNeedsDisplay];
    
    NSLog(@"%f - %f", dif, unitToPixel);
    
}

@end
