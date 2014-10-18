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
    
    if (venue[@"categories"][0])
    {
        NSDictionary *iconDict = venue[@"categories"][0][@"icon"];
        NSString *icon = [NSString stringWithFormat:@"%@64%@", iconDict[@"prefix"], iconDict[@"suffix"]];
        
        place.iconURL = [NSURL URLWithString:icon];
    }
    
    return place;
}


@end
