//
//  PWNArticle.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping/EKMappingProtocol.h>

@interface PWNArticle : NSObject <EKMappingProtocol>

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descriptionArticle;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *urlToImage;
@property (nonatomic, strong) NSDate *publishedAt;

@end
