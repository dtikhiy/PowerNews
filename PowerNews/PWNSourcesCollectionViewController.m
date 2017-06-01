//
//  PWNSourcesCollectionViewController.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/28/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNSourcesCollectionViewController.h"
#import "EKMapper.h"
#import "PWNSource.h"
#import "PWNSourceCollectionViewCell.h"
#import "PWNArticlesCollectionViewController.h"
#import "PWNSourceServices.h"
#import "PWNAPIClient.h"

@interface PWNSourcesCollectionViewController ()

@property (nonatomic, strong) NSArray *sources;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation PWNSourcesCollectionViewController

static NSString * const reuseIdentifier = @"SourceCell";
static NSString * const kSegueToArticles = @"segueToArticles";
static NSString * const kDefaultCategory = @"technology";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSourcesFeed];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PWNSourceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:kSegueToArticles]) {
        PWNArticlesCollectionViewController *articlesViewController = segue.destinationViewController;
        
        NSArray *paths = self.collectionView.indexPathsForSelectedItems;
        NSIndexPath *selectedCell = paths[0];
        PWNSource *source = self.sources[selectedCell.row];
        articlesViewController.sourceID = source.idSource;
        articlesViewController.navigationItem.title = [source.name uppercaseString];
    }
}

#pragma mark - APISources

- (void)getSourcesFeed {
    PWNSourceServices *sourceService = [[PWNSourceServices alloc] initWithAPIClient:[PWNAPIClient sharedClient]];
    
    [sourceService getSourcesForCategory:kDefaultCategory suceess:^(NSArray *sources) {
        self.categories = [sourceService.categories allObjects];
        [self.picker reloadAllComponents];
        self.sources = sources;
        
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sources.count;
}

- (PWNSourceCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PWNSourceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PWNSource *source = self.sources[indexPath.row];
    [cell updateWithSource:source];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     [self performSegueWithIdentifier:kSegueToArticles sender:self];
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width / 2 - 5, self.view.frame.size.height / 3 - 10);
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.categories[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    PWNSourceServices *sourceService = [[PWNSourceServices alloc] initWithAPIClient:[PWNAPIClient sharedClient]];
    NSString *selectedCategory = self.categories[row];
    
    [sourceService getSourcesForCategory:selectedCategory suceess:^(NSArray *sources) {
        self.sources = sources;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
