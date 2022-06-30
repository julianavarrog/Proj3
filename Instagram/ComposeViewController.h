//
//  ComposeViewController.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

@end

@interface ComposeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet PFImageView *composeImage;
@property (weak, nonatomic) IBOutlet UITextView *composeCaption;

@end

NS_ASSUME_NONNULL_END
