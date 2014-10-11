//
//  FourSquareJSONResponseSerializer.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-10.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "FourSquareJSONResponseSerializer.h"


#define kErrorReasonKey @"keyErrorReason"

@implementation FourSquareJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil) {
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        if (data == nil) {
            userInfo[kErrorReasonKey] = @"Unknown";
        } else {
            userInfo[kErrorReasonKey] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        (*error) = newError;
    }
    
    return (JSONObject);
}

@end
