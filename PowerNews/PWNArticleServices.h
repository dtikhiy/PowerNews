//
//  PWNArticleServices.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWNNewsServiceProtocol.h"
@class PWNAPIClient;

@interface PWNArticleServices : NSObject <PWNNewsServiceProtocol>

- (instancetype)initWithAPIClient:(PWNAPIClient *)client;
- (void)getArticlesForSource:(NSString *)source success:(void (^) (NSArray *))success failure:(void (^) (NSError *))failure;

@end
