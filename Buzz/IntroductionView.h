//
//  IntroductionView.h
//  Buzz
//
//  Created by Conner Bender on 12/27/13.
//  Copyright (c) 2013 Conner Bender. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "BlurView.h"
#import "IntroductionPanel.h"

static const CGFloat kPageControlWidth = 148;
static const CGFloat kLeftRightSkipPadding = 10;
static UIFont *kSkipButtonFont = nil;
//Enum to define types of introduction finishes
typedef enum {
    FinishTypeSwipeOut = 0,
    FinishTypeSkipButton
}FinishType;

//Enum to define language direction
typedef enum {
    LanguageDirectionLeftToRight = 0,
    LanguageDirectionRightToLeft
}LanguageDirection;

@class IntroductionView;

/******************************/
//Delegate Method Declarations
/******************************/
@protocol IntroductionDelegate
@optional
-(void)introduction:(IntroductionView *)introductionView didFinishWithType:(FinishType)finishType;
-(void)introduction:(IntroductionView *)introductionView didChangeToPanel:(IntroductionPanel *)panel withIndex:(NSInteger)panelIndex;
@end

/******************************/
//MYBlurIntroductionView
/******************************/
@interface IntroductionView : UIView <UIScrollViewDelegate>{
    NSArray *Panels;
    
    NSInteger LastPanelIndex;
}

/******************************/
//Properties
/******************************/

//Delegate
@property (weak) id <IntroductionDelegate> delegate;

@property (nonatomic, retain) BlurView *BlurView;
@property (nonatomic, retain) UIView *BackgroundColorView;
@property (retain, nonatomic) UIImageView *BackgroundImageView;
@property (retain, nonatomic) UIScrollView *MasterScrollView;
@property (retain, nonatomic) UIPageControl *PageControl;
@property (retain, nonatomic) UIButton *RightSkipButton;
@property (retain, nonatomic) UIButton *LeftSkipButton;
@property (nonatomic, assign) NSInteger CurrentPanelIndex;
@property (nonatomic, assign) LanguageDirection LanguageDirection;
@property (nonatomic, retain) UIColor *UserBackgroundColor;

//Construction Methods
-(void)buildIntroductionWithPanels:(NSArray *)panels;

//Interaction Methods
- (IBAction)didPressSkipButton;

// index is relative to the array of panels passed in.
-(void)changeToPanelAtIndex:(NSInteger)index;

//Enables or disables use of the introductionView. Use this if you want to hold someone on a panel until they have completed some task
-(void)setEnabled:(BOOL)enabled;

//Customization Methods
-(void)setBlurTintColor:(UIColor *)blurTintColor;
@end
