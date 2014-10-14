//
//  UIButton+Styles.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "UIButton+Styles.h"

@implementation UIButton (Styles)


- (void) applyBeenThereStyle
{
    UIImage *buttonBackgroundImage = [UIImage imageNamed:@"buttonBackground"];
    
    [self setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor btMediumBlueColor] forState:UIControlStateNormal];
}

@end
