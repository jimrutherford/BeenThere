//
//  GooglePlacesClient.m
//  Been There
//
//  Created by Jim Rutherford on 2014-08-24.
//  Copyright (c) 2014 Taptonics, Inc. All rights reserved.
//

#import "GooglePlacesClient.h"

#define kGooglePlacesAPIKey             @"AIzaSyCYzzYXxXSBtutjPRnjGH2cMyBwdcE6bPI" 
                                        //@"AIzaSyCNwyh9IuQYYmPUvKJk3W97C6DE47jggBA"

#define kGooglePlacesSearchType         @"(cities)"
#define kGooglePlacesAutoCompleteURL    @"https://maps.googleapis.com/maps/api/place/autocomplete/json"
#define kGooglePlacesNearbyURL          @"https://maps.googleapis.com/maps/api/place/radarsearch/json"
#define kGooglePlacesDetailsURL         @"https://maps.googleapis.com/maps/api/place/details/json"

// Search Radius
#define kRadius @"20"
#define kNearbyRadius @"200000" // in meters

@implementation GooglePlacesClient


+ (instancetype) sharedClient {
    static GooglePlacesClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSURL *baseURL = [NSURL URLWithString:kGooglePlacesAutoCompleteURL];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];

        [config setURLCache:cache];

        _sharedClient = [[GooglePlacesClient alloc] initWithBaseURL:baseURL
                                        sessionConfiguration:config];

        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    });

    return _sharedClient;
}


- (void) callNearbySearchAPIWithCoordinates:(CLLocationCoordinate2D) coordinate
                             success:( void (^)(NSArray *results) ) success
                             failure:( void (^)(NSError *error) ) failure
{
    __block NSMutableArray *results = [NSMutableArray array];
    
    // construct coordinate string of current location as a basis of search
    NSString *location;
    location = [NSString stringWithFormat:@"%f,%f",coordinate.latitude, coordinate.longitude];
    
    NSString *apiURL = [NSString stringWithFormat:@"%@?key=%@&location=%@&radius=%@&types=locality|neighborhood", kGooglePlacesNearbyURL, kGooglePlacesAPIKey, location, kNearbyRadius];
    
    NSString *escapedURL = [apiURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self GET:escapedURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"Response %@", responseObject);
        for (NSDictionary* dict in responseObject[@"results"])
        {
            [results addObject:dict[@"name"]];
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

- (void) callAutoCompleteAPIWithTerm:(NSString*)searchTerm
                             success:( void (^)(NSArray *predictions) ) success
                             failure:( void (^)(NSError *error) ) failure
{
    __block NSMutableArray *predictions = [NSMutableArray array];

    // let's not search unless we have 2 characters in the search term
    // as to not hammer the service too hard
    if (searchTerm.length > 1)
    {
        // get coordinate string of current location as a basis of search
        NSString *location;
        //location = [NSString stringWithFormat:@"%f,%f",locationManger.currentCoord.latitude, locationManger.currentCoord.longitude];

        NSString *apiURL = [NSString stringWithFormat:@"%@?input=%@&types=%@&sensor=true&key=%@&location=%@&radius=%@",kGooglePlacesAutoCompleteURL, searchTerm, kGooglePlacesSearchType, kGooglePlacesAPIKey, location, kRadius];

        NSString *escapedURL = [apiURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [self GET:escapedURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            for (NSDictionary* dict in responseObject[@"predictions"])
            {
                [predictions addObject:dict];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                success(predictions);
            });

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });

        }];

    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            success(predictions);
        });
    }
}

// gets Lat/Long from Google Places API
- (void) callDetailsAPIWithReference:(NSString*)reference
                             success:( void (^)(double latitude, double longitude ) ) success
                             failure:( void (^)(NSError *error) ) failure
{
    NSString *apiURL = [NSString stringWithFormat:@"%@?reference=%@&sensor=false&key=%@", kGooglePlacesDetailsURL, reference, kGooglePlacesAPIKey];

    [self GET:apiURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *location = responseObject[@"result"][@"geometry"][@"location"];

        double lat = [location[@"lat"] doubleValue];
        double lng = [location[@"lng"] doubleValue];

        dispatch_async(dispatch_get_main_queue(), ^{
            success(lat, lng);
        });


    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error);
        });

    }];

}

@end
