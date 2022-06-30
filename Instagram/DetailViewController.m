//
//  DetailViewController.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/29/22.
//

#import "DetailViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "Parse/PFImageView.h"
#import "DateTools.h"

@interface DetailViewController () <UINavigationControllerDelegate, UITextViewDelegate>


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getInfo];
    
}

- (void) getInfo{
    self.detailLike.text = [NSString stringWithFormat:@"%@ Likes", self.post.likeCount];
    
    NSString *atName = @"@";
    NSString *screenName = [atName stringByAppendingString:self.post.author.username];
    self.detailUsername.text = screenName;
    
    //self.detailUsername.text = self.post.author.username;
    
    self.detailCaption.text = self.post.caption;
    self.detailImage.file = self.post.image;
    
    self.detailProfileImage.file = self.post.author[@"profilePic"];
    self.detailProfileImage.layer.cornerRadius = self.detailProfileImage.frame.size.height/2;
    
    self.detailDate.text = self.post.updatedAt.description;
    
    // Format createdAt date string
    
    
    NSString *createdAtOriginalString = self.post.updatedAt.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String

    
    NSString *dateSince = date.shortTimeAgoSinceNow;
    if ([dateSince containsString:@"d"] || [dateSince containsString:@"w"] || [dateSince containsString:@"M"] || [dateSince containsString:@"y"]){
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        self.detailDate.text = [formatter stringFromDate: date];
    } else {
       self.detailDate.text  = dateSince;
    }
    
    /*
    if ([self.post likedByCurrent]){
        [self.detailLikeButton [setImage[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    }else{
        [self.detailLikeButton [setImage[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
    }
     */
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
