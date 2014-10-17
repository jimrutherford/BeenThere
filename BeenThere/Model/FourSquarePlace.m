//
//  FourSquarePlace.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-16.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "FourSquarePlace.h"

@implementation FourSquarePlace

+(instancetype) initWithVenueDictionary:(NSDictionary*)venue
{
    FourSquarePlace *place = [[FourSquarePlace alloc] init];
    
    place.placeId = venue[@"id"];
    place.placeName = venue[@"name"];
    
    return place;
}


@end
