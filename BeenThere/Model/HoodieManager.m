//
//  HoodieManager.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "HoodieManager.h"

@implementation HoodieManager

#pragma mark - Singleton
static HoodieManager *singleton;

+ (instancetype)instance {
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        singleton = [[self alloc] init];
    });
    
    return singleton;
}

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.hoodie = [[HOOHoodie alloc] initWithBaseURLString:kHoodieBaseURL];
    
    return self;
}

@end
