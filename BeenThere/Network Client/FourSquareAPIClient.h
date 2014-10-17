//
//  FourSquareAPIClient.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-10.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

#import <CoreLocation/CoreLocation.h>

@interface FourSquareAPIClient : AFHTTPSessionManager

+ (FourSquareAPIClient *)sharedClient;

- (void) searchWithCurrentLocation:(CLLocationCoordinate2D)coordinate
                           success:( void (^)(NSArray *results) ) success
                           failure:( void (^)(NSError *error) ) failure;


- (void) searchVenuesWithSouthWest:(CLLocationCoordinate2D)swCoordinate
                         northEast:(CLLocationCoordinate2D)neCoordinate
                           success:( void (^)(NSArray *results) ) success
                           failure:( void (^)(NSError *error) ) failure;

@end
