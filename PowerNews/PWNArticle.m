//
//  PWNArticle.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNArticle.h"

@implementation PWNArticle

#pragma mark - Class Methods

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return dateFormatter;
}

//"publishedAt": "2017-05-29T05:30:45Z"

+ (EKObjectMapping *)objectMapping {
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping * _Nonnull mapping) {
        [mapping mapPropertiesFromArray:@[@"author", @"title"]];
        [mapping mapKeyPath:@"description" toProperty:@"descriptionArticle"];
        [mapping mapKeyPath:@"url" toProperty:@"url" withValueBlock:^id _Nullable(NSString * _Nonnull key, id  _Nullable value) {
            NSString *urlString = value;
            NSURL *url;
            if (urlString) {
                url = [NSURL URLWithString:urlString];
            }
            
            return url;
        }];
        [mapping mapKeyPath:@"urlToImage" toProperty:@"urlToImage" withValueBlock:^id _Nullable(NSString * _Nonnull key, id  _Nullable value) {
            NSString *urlString = value;
            NSURL *urlToImage;
            if (urlString) {
                urlToImage = [NSURL URLWithString:urlString];
            }
        
            return urlToImage;
        }];
        [mapping mapKeyPath:@"publishedAt" toProperty:@"publishedAt" withDateFormatter:self.class.dateFormatter];
    }];
}

@end
