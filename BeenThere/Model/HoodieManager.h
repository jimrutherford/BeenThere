//
//  HoodieManager.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#define hoodieManager   [HoodieManager instance]

@interface HoodieManager : NSObject

@property (strong, nonatomic) HOOHoodie *hoodie;

/**
 * gets singleton object.
 * @return singleton
 */
+ (instancetype)instance;

@end
