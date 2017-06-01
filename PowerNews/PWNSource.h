//
//  PWNSource.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/28/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKMappingProtocol.h"

@interface PWNSource : NSObject <EKMappingProtocol>

@property (nonatomic, copy) NSString *idSource;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descriptionSource;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *category;

@end
