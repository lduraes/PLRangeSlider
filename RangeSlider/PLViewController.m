//
//  PLViewController.m
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import "PLViewController.h"
#import "PLRangeSliderView.h"
 
@interface PLViewController () <PLRangeSliderViewDelegate>

@property (weak, nonatomic) IBOutlet PLRangeSliderView *rangeSliderView;
@property (weak, nonatomic) IBOutlet UILabel *leftValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightValueLabel;

@end

@implementation PLViewController

#pragma mark - Private

-(void)updateLabel {
    [self.leftValueLabel setText:@(self.rangeSliderView.left).stringValue];
    [self.rightValueLabel setText:@(self.rangeSliderView.right).stringValue];
}

-(void)loadRangeSliderConfig {
    [self.rangeSliderView setLineHeight:1];
    [self.rangeSliderView setMinValue:10];
    [self.rangeSliderView setMaxValue:20];
    [self.rangeSliderView setLeft:11];
    [self.rangeSliderView setRight:18];

    [self updateLabel];
}

#pragma mark - Override

-(void)viewDidLoad {
    [super viewDidLoad];
    [self loadRangeSliderConfig];
}

#pragma mark - PLRangeSliderViewDelegate

-(void)didChangeValueOnMove:(id)sender left:(CGFloat)left right:(CGFloat)right {
    //NSLog(@"didChangeValueOnMove :: left >> %2f && right >> %2f", left, right);
    [self updateLabel];
}

-(void)didChangeValueOnUp:(id)sender left:(CGFloat)left right:(CGFloat)right {
    //NSLog(@"didChangeValueOnUp :: left >> %2f && right >> %2f", left, right);
    [self updateLabel];
}

@end
