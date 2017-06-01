//
//  PWNWebArticleViewController.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/30/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWNWebArticleViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
