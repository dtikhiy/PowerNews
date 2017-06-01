//
//  PWNNewsServiceProtocol.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/30/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PWNAPIClient;

@protocol PWNNewsServiceProtocol <NSObject>

- (instancetype)initWithAPIClient:(PWNAPIClient *)client;

@end
