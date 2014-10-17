//
//  FourSquareAPIClient.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-10.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "FourSquareAPIClient.h"
#import "FourSquareJSONRequestSerializer.h"
#import "FourSquareJSONResponseSerializer.h"

#import "FourSquarePlace.h"

#define kFourSquareClientID @"CWXPD3OL3IAKOW4KJFPZT0QUZMHFVYYRE2U0UXAITPHE412W"
#define kFourSquareClientSecret @"RY4500B5J4DGLVGU4VG2PTISLFWXHHIMBTZG4KSDHKIZVWRN"

#define kStateAndCityCategoryId @"530e33ccbcbc57f1066bbfe4"

#define kCitySearchRadius   @"100000"   // 100km in meters
#define kVenueSearchRadius   @"10000"   // 10km in meters

@implementation FourSquareAPIClient

+ (FourSquareAPIClient *)sharedClient {
    static FourSquareAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *serverURL = @"https://api.foursquare.com/v2/";

        NSURL *baseURL = [NSURL URLWithString:serverURL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[FourSquareAPIClient alloc] initWithBaseURL:baseURL
                                        sessionConfiguration:config];
        
        _sharedClient.responseSerializer = [FourSquareJSONResponseSerializer serializer];
        _sharedClient.requestSerializer = [FourSquareJSONRequestSerializer serializer];
    });
    
    return _sharedClient;
}

- (void) searchWithCurrentLocation:(CLLocationCoordinate2D)coordinate
                           success:( void (^)(NSArray *results) ) success
                           failure:( void (^)(NSError *error) ) failure
{
    NSString * path = @"venues/search";
    
    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
    
    NSDictionary *params = @{@"client_id": kFourSquareClientID,
                             @"client_secret": kFourSquareClientSecret,
                             @"v": @"20141017",
                             @"ll": latLong,
                             @"intent": @"browse",
                             @"radius": kCitySearchRadius,
                             @"categoryId": kStateAndCityCategoryId};
    
    [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *results = [NSMutableArray array];
        
        NSArray *venues = responseObject[@"response"][@"venues"];
        
        for (NSDictionary *venue in venues)
        {
            FourSquarePlace *place = [FourSquarePlace initWithVenueDictionary:venue];
            [results addObject:place];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(results);
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });
        
    }];
}

- (void) searchVenuesWithSouthWest:(CLLocationCoordinate2D)swCoordinate
                         northEast:(CLLocationCoordinate2D)neCoordinate
                           success:( void (^)(NSArray *results) ) success
                           failure:( void (^)(NSError *error) ) failure
{
    NSString * path = @"venues/search";
    
    NSString *neLatLong = [NSString stringWithFormat:@"%f,%f", neCoordinate.latitude, neCoordinate.longitude];
    NSString *swLatLong = [NSString stringWithFormat:@"%f,%f", swCoordinate.latitude, swCoordinate.longitude];
    
    NSDictionary *params = @{@"client_id": kFourSquareClientID,
                             @"client_secret": kFourSquareClientSecret,
                             @"v": @"20141017",
                             @"ne": neLatLong,
                             @"sw": swLatLong,
                             @"intent": @"browse"};
    
    [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *results = [NSMutableArray array];
        
        
        NSArray *venues = responseObject[@"response"][@"venues"];
        
        for (NSDictionary *venue in venues)
        {
            FourSquarePlace *place = [FourSquarePlace initWithVenueDictionary:venue];
            [results addObject:place];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(results);
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });
        
    }];
}



@end
