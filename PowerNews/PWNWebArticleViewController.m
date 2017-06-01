//
//  PWNWebArticleViewController.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/30/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNWebArticleViewController.h"

@interface PWNWebArticleViewController ()

@end

@implementation PWNWebArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:self.request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

@end
