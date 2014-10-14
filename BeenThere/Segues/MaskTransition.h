//
//  MaskTransition.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-08-22.
//  Copyright (c) 2014 Braxio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UIViewController * fromVC;
@property (nonatomic, assign) UIViewController * toVC;

@property (nonatomic, assign) id transitionContext;

@end
