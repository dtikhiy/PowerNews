//
//  PWNSource.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/28/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNSource.h"

@implementation PWNSource

#pragma mark - Class Methods

+ (EKObjectMapping *)objectMapping {
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping * _Nonnull mapping) {
        [mapping mapKeyPath:@"id" toProperty:@"idSource"];
        [mapping mapKeyPath:@"description" toProperty:@"descriptionSource"];
        [mapping mapKeyPath:@"url" toProperty:@"url" withValueBlock:^id _Nullable(NSString * _Nonnull key, id  _Nullable value) {
            NSString *stringURL;
            NSURL *url;
            
            if ((stringURL = value)) {
                url = [NSURL URLWithString:stringURL];
            }
            
            return url;
        }];
        [mapping mapPropertiesFromArray:@[@"name", @"category"]];
    }];
}

@end
