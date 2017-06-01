//
//  PWNArticleCollectionViewCell.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNArticleCollectionViewCell.h"
#import "PWNArticle.h"
#import "UIImageView+DownloadFromURL.h"

@implementation PWNArticleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateWithArticle:(PWNArticle *)article {
    if (article) {
        self.articleAuthor.text = [article.author uppercaseString];
        self.articleTitle.text = [article.title uppercaseString];
        self.articleDescription.text = article.descriptionArticle;
        [self.articleImage downloadImageFromURL:article.urlToImage];
    }
}

@end
