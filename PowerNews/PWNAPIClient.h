//
//  PWNAPIClient.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface PWNAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
