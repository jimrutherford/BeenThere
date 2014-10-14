//
//  MaskTransition.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-08-22.
//  Copyright (c) 2014 Braxio. All rights reserved.
//

#import "MaskTransition.h"
#import <QuartzCore/QuartzCore.h>

#define ScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight        [[UIScreen mainScreen] bounds].size.height


const CGFloat PRESENT_DURATION = 1.3;

@interface MaskTransition()

@property CALayer * mask;

@end

@implementation MaskTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return PRESENT_DURATION;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    _transitionContext = transitionContext;

    _fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView * container = [transitionContext containerView];

    UIImage *maskImage = [UIImage imageNamed:@"garmentFemale"];

    _mask = [CALayer layer];
    _mask.contents = (__bridge id)([maskImage CGImage]);

    CGRect toVCFrame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);

    _toVC.view.frame = toVCFrame;
    _mask.frame = toVCFrame;

    [_toVC.view setAlpha:1.0];

    _fromVC.view.layer.mask = _mask;
    _fromVC.view.layer.masksToBounds = YES;

    CGRect oldBounds = _mask.bounds;
    CGRect newBounds = oldBounds;
    newBounds.size = CGSizeMake(ScreenWidth * 0.2f, ScreenHeight * 0.2f);

    [container addSubview:_toVC.view];
    [container sendSubviewToBack:_toVC.view];

    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.duration = 0.6;
            scaleAnimation.fillMode = kCAFillModeForwards;
            scaleAnimation.removedOnCompletion = NO;
            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
            scaleAnimation.toValue = [NSNumber numberWithFloat:0.3f];


            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(187.5, 265.5)];
            [bezierPath addCurveToPoint: CGPointMake(218.5, 94.5) controlPoint1: CGPointMake(78.93, 173) controlPoint2: CGPointMake(126.07, 36)];
            [bezierPath addCurveToPoint: CGPointMake(235.5, 559.5) controlPoint1: CGPointMake(310.93, 153) controlPoint2: CGPointMake(235.5, 559.5)];
            [[UIColor blackColor] setStroke];
            bezierPath.lineWidth = 1;
            [bezierPath stroke];


            CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            positionAnimation.duration = 2.0;
            positionAnimation.fillMode = kCAFillModeForwards;
            positionAnimation.removedOnCompletion = YES;
            positionAnimation.path = bezierPath.CGPath;

            positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

            [_fromVC.view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
            [_fromVC.view.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        }];

        CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

        maskAnimation.duration = 0.6;
        maskAnimation.fillMode = kCAFillModeForwards;
        maskAnimation.removedOnCompletion = NO;
        maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        maskAnimation.fromValue = [NSNumber numberWithFloat:4.0f];
        maskAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [_mask addAnimation:maskAnimation forKey:@"maskAnimation"];

    } [CATransaction commit];

    [self performSelector:@selector(completedTransition) withObject:nil afterDelay:2.6];
}


- (void)completedTransition
{
    _fromVC.view.layer.mask = nil;
    _fromVC.view.layer.masksToBounds = NO;
    [_fromVC.view.layer removeAllAnimations];
    [_transitionContext completeTransition:YES];
}



@end
