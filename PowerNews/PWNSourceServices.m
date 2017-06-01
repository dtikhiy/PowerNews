//
//  PWNSourceServices.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNSourceServices.h"
#import "PWNAPIClient.h"
#import "PWNConstants.h"
#import "EKMapper.h"
#import "PWNSource.h"

@interface PWNSourceServices ()

@property (nonatomic, strong, readonly) PWNAPIClient *client;

@end

@implementation PWNSourceServices

- (instancetype)initWithAPIClient:(PWNAPIClient *)client {
    if (self = [super init]) {
        _client = client;
        _categories = [self getAllCategories];
    }
    
    return self;
}

// TODO: It could be optimized in a way to do one call to get all sources and filtered dictionary by current set in a picker.
// It allows us to do only one call to get the sources.

#pragma mark - API Methods

- (NSSet *)getAllCategories {
    NSDictionary * const requestParameters = @{ @"language" : @"en" };
    NSMutableSet *set = [NSMutableSet set];
    
    [self.client GET:kSourcesServiceURI parameters:requestParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictSources = responseObject;
        NSArray *arraySources = [dictSources objectForKey:kJSONSourcesObject];
        
        for (NSDictionary *dict in arraySources) {
            [set addObject:dict[@"category"]];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    return set;
}

- (void)getSourcesForCategory:(NSString *)category suceess:(void (^) (NSArray *))success failure:(void (^) (NSError *))failure {
    NSDictionary * const requestParameters = @{ @"language" : @"en",
                                                @"category" : category };
    
    [self.client GET:kSourcesServiceURI parameters:requestParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictSources = responseObject;
        
        NSArray *arraySources = [dictSources objectForKey:kJSONSourcesObject];
        NSArray *sources = [EKMapper arrayOfObjectsFromExternalRepresentation:arraySources withMapping:[PWNSource objectMapping]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(sources);
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
