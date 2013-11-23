//
//  MyController.m
//  SampleAnimateVelocity
//
//  Created by Peter Chen on 11/22/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "MyController.h"

#define kDragMeViewWidth    50

@interface MyController ()

@property (nonatomic, strong) UIView *dragMeView;
@property (nonatomic, assign) CGPoint dragMeOriginWhenDragStarted;

@end

@implementation MyController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Animate Velocity";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.dragMeView = [[UIView alloc] initWithFrame:CGRectMake([self dragMeX], 100, kDragMeViewWidth, kDragMeViewWidth)];
    self.dragMeView.backgroundColor = [UIColor blueColor];
    [self.dragMeView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragMeViewPanned:)]];
    [self.view addSubview:self.dragMeView];
}

- (int)dragMeX {
    return CGRectGetMidX(self.view.frame) - kDragMeViewWidth / 2;
}

- (void)dragMeViewPanned:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.dragMeOriginWhenDragStarted = self.dragMeView.frame.origin;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.view];
        CGPoint newOrigin = self.dragMeOriginWhenDragStarted;
        newOrigin.y += translation.y;
        self.dragMeView.frame = CGRectMake([self dragMeX], newOrigin.y, kDragMeViewWidth, kDragMeViewWidth);
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocityPointPerSecond = [gesture velocityInView:self.view];
        [self animateDragMeViewAtVelocityY:velocityPointPerSecond.y];
    }
}

// ***** This is relevant code that animates dragMeView at the correct velocity *****
- (void)animateDragMeViewAtVelocityY:(CGFloat)velocityYPointPerSecond {
    // Get the travel distance
    int startY = self.dragMeView.frame.origin.y;
    int endY = self.view.frame.size.height - kDragMeViewWidth;
    int travelDistance = endY - startY;
    
    // Normally, we would hardcode duration to something like 0.2f.
    // Instead of hardcoding 0.2, calculate the duration using the velocity and travel distance in order to have the view
    //    continue it's velocity after the finger is released
    CGFloat duration = travelDistance / velocityYPointPerSecond;
    
    // The UIViewAnimationOptionCurveEaseOut option is also necessary so the animation starts at the correct speed
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.dragMeView.frame = CGRectMake([self dragMeX], endY, kDragMeViewWidth, kDragMeViewWidth);
    } completion:NULL];
}

@end
