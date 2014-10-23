//
//  FourSquarePlace.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-16.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquarePlace : NSObject

@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSURL *iconURL;
@property (nonatomic, strong) NSURL *iconDarkURL;
+(instancetype) initWithVenueDictionary:(NSDictionary*)venue;

@end
