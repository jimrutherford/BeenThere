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

#define kFourSquareClientID @"CWXPD3OL3IAKOW4KJFPZT0QUZMHFVYYRE2U0UXAITPHE412W"
#define kFourSquareClientSecret @"RY4500B5J4DGLVGU4VG2PTISLFWXHHIMBTZG4KSDHKIZVWRN"

@implementation FourSquareAPIClient

+ (FourSquareAPIClient *)sharedClient {
    static FourSquareAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *serverURL = @"https://api.foursquare.com/v2/venues/search";

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

@end
