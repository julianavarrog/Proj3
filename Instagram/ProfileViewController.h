//
//  ProfileViewController.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *profileUsername;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;

- (IBAction)didTapLogout:(id)sender;

@end

NS_ASSUME_NONNULL_END
