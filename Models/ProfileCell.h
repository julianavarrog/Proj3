//
//  ProfileCell.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UICollectionViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *profileImagePost;


@end

NS_ASSUME_NONNULL_END
