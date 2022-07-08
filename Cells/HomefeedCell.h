//
//  HomefeedCell.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomefeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *feedImage;
@property (weak, nonatomic) IBOutlet UILabel *feedTitle;
@property (weak, nonatomic) IBOutlet UILabel *feedCaption;
@property (weak, nonatomic) IBOutlet PFImageView *feedProfilePicture;

@property(strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
