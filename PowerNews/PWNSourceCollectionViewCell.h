//
//  PWNSourceCollectionViewCell.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/28/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PWNSource;


@interface PWNSourceCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

- (void)updateWithSource:(PWNSource *)source;

@end
