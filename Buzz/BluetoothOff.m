//
//  BluetoothOff.m
//  Buzz
//
//  Created by Conner Bender on 12/28/13.
//  Copyright (c) 2013 Conner Bender. All rights reserved.
//

#import "BluetoothOff.h"
#import "BluetoothOff.m"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BluetoothOff () {

}
@end

@implementation BluetoothOff

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    CALayer *backgroundLayer = CALayer.layer;
	backgroundLayer.backgroundColor = [UIColor colorWithRed:0.774 green:0.765 blue:0.760 alpha:1.000].CGColor;
	backgroundLayer.frame = (CGRect){ 75, 450, 150, 300 };
	CAGradientLayer *gradient = CAGradientLayer.layer;
	gradient.colors = @[ (id)[UIColor colorWithRed:0.498 green:0.716 blue:0.788 alpha:1.000].CGColor, (id)[UIColor colorWithRed:0.508 green:0.767 blue:0.687 alpha:1.000].CGColor ];
	gradient.frame = (CGRect){ 0, 120, 150, 100 };
	CAShapeLayer *arrowLayer = CAShapeLayer.layer;
	arrowLayer.fillColor = UIColor.grayColor.CGColor;
	CGMutablePathRef maskPath = CGPathCreateMutable();
	CGPathAddRect(maskPath, NULL, (CGRect){ 85, 4, 8, 120 });
	CGAffineTransform t = CGAffineTransformMakeRotation(M_PI * 3 / 4);
	t = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-44, -40), t);
	CGPathAddRoundedRect(maskPath, &t, (CGRect){ -20, -30, 50, 8 }, 3, 3);
	CGAffineTransform t2 = CGAffineTransformMakeRotation(-M_PI * 3 / 4);
	t2 = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-40, 30), t2);
	CGPathAddRoundedRect(maskPath, &t2, (CGRect){ -72, 26, 50, 8 }, 3, 3);
	arrowLayer.path = maskPath;
	arrowLayer.fillRule = kCAFillRuleNonZero;
	arrowLayer.fillColor = [UIColor colorWithRed:0.774 green:0.765 blue:0.760 alpha:1.000].CGColor;;
	backgroundLayer.mask = arrowLayer;
	[backgroundLayer addSublayer:gradient];
	CGPathRelease(maskPath);
	
	CABasicAnimation *animation = [CABasicAnimation animation];
	[animation setFromValue:[NSValue valueWithCGPoint:gradient.position]];
	[animation setToValue:[NSValue valueWithCGPoint:CGPointApplyAffineTransform(gradient.position, CGAffineTransformMakeTranslation(0, -300))]];
	[animation setDuration:2.0f];
	animation.repeatCount = HUGE_VALF;
	animation.autoreverses = NO;
	[gradient addAnimation:animation forKey:@"position"];
	
	[self.view.layer addSublayer:backgroundLayer];
    
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral {
    
if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
}


@end

