//
//  PWNSourceCollectionViewCell.m
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/28/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import "PWNSourceCollectionViewCell.h"
#import "PWNSource.h"

@implementation PWNSourceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [self randomColor];
}

// TODO: Implement image cacheing

#pragma mark - View Updates

- (void)updateWithSource:(PWNSource *)source {
    if (source) {
        self.nameLabel.text = [source.name uppercaseString];
        self.categoryLabel.text = [source.category uppercaseString];
    }
}

#pragma mark - Helpers

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.4;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.4;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.7f];
}

@end
