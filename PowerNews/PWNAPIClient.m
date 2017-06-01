//
//  PWNAPIClient.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNAPIClient.h"
#import "PWNConstants.h"

typedef enum : NSUInteger {
    
    HTTPResponseCodeOperationSuccessful = 200,
    HTTPResponseCodeBadRequest = 400,
    HTTPResponseCodeUnauthorized = 401,
    HTTPResponseCodeAuthorizationFailed = 403,
    HTTPResponseCodeNotFound = 404,
    HTTPResponseCodeMethodNotAllowed = 405,
    HTTPResponseCodeDataValidationFailed = 422,
    HTTPResponseCodeInternalServerError = 500
    
} HTTPResponseCode;

@implementation PWNAPIClient

- (instancetype)init {
    if (self = [super initWithBaseURL:self.class.baseURL]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    return self;
}

#pragma mark - Class Methods

+ (NSURL *)baseURL {
    return [NSURL URLWithString:kNewsBaseURL];
}

+ (instancetype)sharedClient {
    static PWNAPIClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[PWNAPIClient alloc] init];
    });
    
    return sharedClient;
}

// TODO: Implement the error handling

@end
