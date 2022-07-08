//
//  HomefeedCell.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/27/22.
//

#import "HomefeedCell.h"
#import "AppDelegate.h"
#import "Parse/PFImageView.h"

@implementation HomefeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
     // Configure the view for the selected state
    [super setSelected:selected animated:animated];
}

- (void) refreshData{
  // no-op
}

- (void)setPost:(Post *)post {
    _post = post;
    self.feedImage.file = post[@"image"];
    
    NSString *atName = @"@";
    NSString *screenName = [atName stringByAppendingString:post.author.username];
    self.feedTitle.text = screenName;
    
    self.feedProfilePicture.file = self.post.author[@"profileImage"];
    self.feedProfilePicture.layer.cornerRadius  = self.feedProfilePicture.frame.size.width/2;
    self.feedCaption.text = post.caption;
    [self.feedImage loadInBackground];
    [self.feedProfilePicture loadInBackground];
}

@end
