//
//  FadeSegue.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-07-17.
//  Copyright (c) 2014 Jim Rutherford. All rights reserved.
//

#import "FadeSegue.h"

@implementation FadeSegue


- (void)perform
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    
    [[[[[self sourceViewController] view] window] layer] addAnimation:transition
                                                               forKey:kCATransitionFade];
    
    [[self sourceViewController]
     presentViewController:[self destinationViewController]
     animated:NO completion:NULL];
}



@end
