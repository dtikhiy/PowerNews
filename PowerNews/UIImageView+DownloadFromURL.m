//
//  UIImage+DownloadFromURL.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "UIImageView+DownloadFromURL.h"
#import <AFNetworking/AFNetworking.h>

@implementation UIImageView (DownloadFromURL)

- (void)downloadImageFromURL:(NSURL *)url {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"dataTaskWithRequest error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            self.image = image;
        });
        
    }] resume];

}

@end
