//
//  PWNSourceServices.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWNNewsServiceProtocol.h"
@class PWNAPIClient;

@interface PWNSourceServices : NSObject <PWNNewsServiceProtocol>

@property (nonatomic, strong, readonly) NSSet *categories;

- (instancetype)initWithAPIClient:(PWNAPIClient *)client;
- (void)getSourcesForCategory:(NSString *)category suceess:(void (^) (NSArray *))success failure:(void (^) (NSError *))failure;

@end
