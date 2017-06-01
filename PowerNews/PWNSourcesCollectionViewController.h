//
//  PWNSourcesCollectionViewController.h
//  PowerNews
//
//  Created by Dmytro Tykhyi on 5/28/17.
//  Copyright © 2017 Dmytro Tykhyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWNSourcesCollectionViewController : UIViewController <UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
