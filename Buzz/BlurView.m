//
//  BlurView.m
//  Buzz
//
//  Created by Conner Bender on 12/27/13.
//  Copyright (c) 2013 Conner Bender. All rights reserved.
//

#import "BlurView.h"

#import <QuartzCore/QuartzCore.h>

@interface BlurView ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation BlurView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // YES or else it will clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    
    if (![self toolbar]) {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
        [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
    }
}

- (void) setBlurTintColor:(UIColor *)blurTintColor {
    if ([self runningiOS7]) {
        [self.toolbar setBarTintColor:blurTintColor];
    }
    else {
        [self.toolbar setBackgroundColor:blurTintColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}

-(BOOL)runningiOS7{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if (currSysVer.floatValue >= 7.0) {
        return YES;
    }
    
    return NO;
}

@end
