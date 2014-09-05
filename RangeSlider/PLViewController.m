//
//  PLViewController.m
//  RangeSlider
//
//  Created by Luiz Duraes on 7/21/14.
//  Copyright (c) 2014 Mob4U IT Solutions. All rights reserved.
//

#import "PLViewController.h"
#import "PLRangeSliderView.h"

@interface PLViewController ()

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
    
//    self.rangeSliderView.singleRange = YES;
    
    [self.rangeSliderView setLineHeight:1];
    [self.rangeSliderView setMinimumValue:10];
    [self.rangeSliderView setMaximumValue:99999999];
    [self.rangeSliderView setSelectedMinimumValue:19999999];
    [self.rangeSliderView setSelectedMaximumValue:79999999];
    
    self.rangeSliderView.circleColorActive =
    self.rangeSliderView.circleColorInactive =
    self.rangeSliderView.circleBorderColorActive =
    self.rangeSliderView.circleBorderColorInactive =
    self.rangeSliderView.lineColorActive =
    [UIColor colorWithRed:10./255. green:98./255. blue:195./255. alpha:1.0];
    
    self.rangeSliderView.lineHeight = 2.;
    
    [self updateLabel];
}

#pragma mark - Override

-(void)viewDidLoad {
    [super viewDidLoad];
    [self loadRangeSliderConfig];
}

#pragma mark - PLRangeSliderViewDelegate

- (IBAction)actionTouchDown:(PLRangeSliderView *)rangeSliderView {
    NSLog(@"action touch down");
}

- (IBAction)actionChanged:(PLRangeSliderView *)rangeSliderView {
    [self updateLabel];
}

- (IBAction)actionTouchUp:(PLRangeSliderView *)rangeSliderView {
    if(rangeSliderView.isMoved) {
        NSLog(@"was moved >> %ld", rangeSliderView.lastSelectedSide);
    }else{
        NSLog(@"was not moved >> %ld", rangeSliderView.lastSelectedSide);
    }
}

@end
