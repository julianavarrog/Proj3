//
//  ProfileCell.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/30/22.
//

#import "ProfileCell.h"
#import "ProfileViewController.h"
#import "Post.h"
#import "PFUser.h"

@implementation ProfileCell

- (void)setPost:(Post *)post{
    _post = post;
    self.profileImagePost.file = self.post.image;
    [self.profileImagePost loadInBackground];
    
}

@end
