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
    [self.leftValueLabel setText:@(self.rangeSliderView.selectedMinimumValue).stringValue];
    [self.rightValueLabel setText:@(self.rangeSliderView.selectedMaximumValue).stringValue];
}

-(void)loadRangeSliderConfig {
    
    [self.rangeSliderView setLineHeight:1];
    [self.rangeSliderView setMinimumValue:10];
    [self.rangeSliderView setMaximumValue:99999999];
    [self.rangeSliderView setSelectedMinimumValue:19999999];
    [self.rangeSliderView setSelectedMaximumValue:79999999];
    
    [self updateLabel];
}

#pragma mark - Override

-(void)viewDidLoad {
    [super viewDidLoad];
    [self loadRangeSliderConfig];
}

#pragma mark - PLRangeSliderViewDelegate

- (void)didChangeValueOnMove:(PLRangeSliderView *)rangeSliderView selectedMinimumValue:(CGFloat)selectedMinimumValue selectedMaximumValue:(CGFloat)selectedMaximumValue {
    [self updateLabel];
}

- (void)didChangeValueOnUp:(PLRangeSliderView *)rangeSliderView selectedMinimumValue:(CGFloat)selectedMinimumValue selectedMaximumValue:(CGFloat)selectedMaximumValue {
    [self updateLabel];
}

- (void)didTouchUp:(PLRangeSliderView *)rangeSliderView touchedSide:(RangeSliderSide)side {
    NSLog(@"didTouchUp >> %lu", side);
}

@end
