//
//  DetailViewController.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"
#import "Parse/PFImageView.h"

@protocol DetailViewControllerDelegate

@end
NS_ASSUME_NONNULL_BEGIN


@interface DetailViewController : UIViewController

@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet PFImageView *detailProfileImage;
@property (weak, nonatomic) IBOutlet PFImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailUsername;
@property (weak, nonatomic) IBOutlet UILabel *detailCaption;
@property (weak, nonatomic) IBOutlet UIButton *detailLikeButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLike;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;


@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
