//
//  AppearanceManager.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "AppearanceManager.h"

@implementation AppearanceManager

+ (void) setupAppearance
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor btDarkRedColor]];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor btLightGrayColor]];
}


@end
