//
//  PWNArticleServices.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNArticleServices.h"
#import "PWNAPIClient.h"
#import "PWNConstants.h"
#import <EasyMapping/EKMapper.h>
#import "PWNArticle.h"

@interface PWNArticleServices ()

@property (nonatomic, strong, readonly) PWNAPIClient *client;

@end

@implementation PWNArticleServices

- (instancetype)initWithAPIClient:(PWNAPIClient *)client {
    if (self = [super init]) {
        _client = client;
    }
    
    return self;
}

#pragma mark - API Methods

- (void)getArticlesForSource:(NSString *)source success:(void (^) (NSArray *))success failure:(void (^) (NSError *))failure {
    NSDictionary * requestParameters = @{ @"source" : [source stringByRemovingPercentEncoding] ,
                                          @"apiKey" : kAPI_key
                                        };
    
    [self.client GET:kArticlesServiceURI parameters:requestParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *articlesDict = responseObject;
        NSArray *rawArticles = articlesDict[kJSONArticlesObject];
        NSMutableArray *nonnullValueArray = [[NSMutableArray alloc]  init];
        
        // Get rid of the <null> values in the responseJSON
        for (NSDictionary *di in rawArticles) {
            NSMutableDictionary *dict = [di mutableCopy];
            NSArray *keysForNullValues = [dict allKeysForObject:[NSNull null]];
            [dict removeObjectsForKeys:keysForNullValues];
            [nonnullValueArray addObject:dict];
        }
        
        NSArray *articles = [EKMapper arrayOfObjectsFromExternalRepresentation:nonnullValueArray withMapping:[PWNArticle objectMapping]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(articles);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
