//
//  PWNArticleCollectionViewCell.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PWNArticle;

@interface PWNArticleCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *articleAuthor;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UITextView *articleDescription;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

- (void)updateWithArticle:(PWNArticle *)article;

@end
