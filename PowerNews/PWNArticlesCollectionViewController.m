//
//  PWNArticlesCollectionViewController.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/29/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNArticlesCollectionViewController.h"
#import "PWNArticleCollectionViewCell.h"
#import "PWNArticle.h"
#import <EasyMapping/EKMapper.h>
#import <AFNetworking/AFNetworking.h>
#import "PWNArticleServices.h"
#import "PWNAPIClient.h"
#import "PWNWebArticleViewController.h"

@interface PWNArticlesCollectionViewController ()

@property (nonatomic, strong) NSArray *articles;

@end

@implementation PWNArticlesCollectionViewController

static NSString * const reuseIdentifier = @"ArticleCell";
static NSString * const ksegueToWebArticle = @"segueToWebArticle";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    if (!self.sourceID) {
        NSLog(@"SourceID is set to nil");
    }
    
    [self getArticlesForSource:self.sourceID];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PWNArticleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:ksegueToWebArticle]) {
        PWNWebArticleViewController *webArticlesViewController = segue.destinationViewController;
        
        NSArray *paths = self.collectionView.indexPathsForSelectedItems;
        NSIndexPath *selectedCell = paths[0];
        PWNArticle *article = self.articles[selectedCell.row];
        NSURLRequest *request = [NSURLRequest requestWithURL:article.url];
        webArticlesViewController.request = request;
    }
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.articles.count;
}

- (PWNArticleCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PWNArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PWNArticle *article = [self.articles objectAtIndex:indexPath.row];
    
    [cell updateWithArticle:article];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:ksegueToWebArticle sender:self];
}


#pragma mark - APIArticles

- (void)getArticlesForSource:(NSString *)sourceID {
    PWNArticleServices *articleService = [[PWNArticleServices alloc] initWithAPIClient:[PWNAPIClient sharedClient]];
    [articleService getArticlesForSource:sourceID success:^(NSArray *articles) {
        self.articles = articles;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height / 2);
}

@end
