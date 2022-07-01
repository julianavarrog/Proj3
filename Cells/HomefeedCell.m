//
//  HomefeedCell.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/27/22.
//

#import "HomefeedCell.h"//
#import "AppDelegate.h"
#import "Parse/PFImageView.h"

@implementation HomefeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) refreshData{
  // some code to refresh data
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
    
    /*
    PFUser *user = [PFUser currentUser];
    user[@"profilePic"] = self.feedProfilePicture.file;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
    }];
     */
}


/*
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
}
*/
@end
