//
//  FourSquareJSONRequestSerializer.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-10.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "FourSquareJSONRequestSerializer.h"

@implementation FourSquareJSONRequestSerializer


- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *mutableRequest = [[super requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];
    
    [mutableRequest setValue:@"com.taptonics.beenthere" forHTTPHeaderField:@"x-application-id"];
    return mutableRequest;
}


@end
