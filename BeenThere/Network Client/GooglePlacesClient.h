//
//  GooglePlacesClient.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-08-24.
//  Copyright (c) 2014 Taptonics, Inc. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

@interface GooglePlacesClient : AFHTTPSessionManager

+ (instancetype) sharedClient;

- (void) callAutoCompleteAPIWithTerm:(NSString*)searchTerm
                             success:( void (^)(NSArray *predictions) ) success
                             failure:( void (^)(NSError *error) ) failure;

- (void) callNearbySearchAPIWithCoordinates:(CLLocationCoordinate2D) coordinate
                                    success:( void (^)(NSArray *results) ) success
                                    failure:( void (^)(NSError *error) ) failure;

- (void) callDetailsAPIWithReference:(NSString*)reference
                             success:( void (^)(double latitude, double longitude ) ) success
                             failure:( void (^)(NSError *error) ) failure;

@end
