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
    [self.leftValueLabel setText:@(self.rangeSliderView.selectedMininumValue).stringValue];
    [self.rightValueLabel setText:@(self.rangeSliderView.selectedMaximumValue).stringValue];
}

-(void)loadRangeSliderConfig {
    
    [self.rangeSliderView setLineHeight:1];
    [self.rangeSliderView setMininumValue:10];
    [self.rangeSliderView setMaximumValue:99999999];
    [self.rangeSliderView setSelectedMininumValue:19999999];
    [self.rangeSliderView setSelectedMaximumValue:79999999];

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
