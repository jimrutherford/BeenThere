//
//  HoodieManager.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "HoodieManager.h"

@implementation HoodieManager

static HoodieManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[HoodieManager alloc] init];
}

- (id)mutableCopy
{
    return [[HoodieManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
        self.hoodie = [[HOOHoodie alloc] initWithBaseURLString:kHoodieBaseURL];
    }
    
    self = [super init];
    return self;
}


@end
