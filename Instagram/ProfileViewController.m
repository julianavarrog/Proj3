//
//  ProfileViewController.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/27/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "ProfileCell.h"
#import "DetailViewController.h"
#import "Post.h"
#import "Parse/PFImageView.h"
#import "DateTools.h"


@interface ProfileViewController ()<UIImagePickerControllerDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UITextViewDelegate >


@property (strong, nonatomic) NSMutableArray *postsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPosts];
    
    self.postsArray = [[NSMutableArray alloc] init];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //[self getInfo];
    
    // Do any additional setup after loading the view.
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    Post *post = self.postsArray[indexPath.row];
    [cell setPost:post];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int totalwidth = self.view.frame.size.width - 5;
    int numberOfCellPerRow = 3;
    int dimensions = (CGFloat)(totalwidth / numberOfCellPerRow);
    return CGSizeMake(dimensions, 120);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.postsArray.count;
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        if(error) {
            // Failure
        } else {
            // Success
            SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            sceneDelegate.window.rootViewController = loginViewController;
        }
   }];
}


-(void) getPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    [self refreshControl];
    //fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *post, NSError *error){
        [self.refreshControl endRefreshing];
        if(post != nil){
            // do something with the array of object returned by call
            self.postsArray = post;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    ProfileCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"profileDetailSegue" sender:cell];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"profileDetailSegue"]){
        NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:sender];
        Post *poster = (Post *)self.postsArray[cellIndexPath.section];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.post = poster;
    }
}

- (IBAction)didTapProfileImage:(id)sender {
    [self getPhotoLibrary];
    
}
- (void)getPhotoLibrary{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    CGSize resizeSize = CGSizeMake(500, 400);
    if (editedImage) {
        self.profileImage.image = [self resizeImage:editedImage withSize:resizeSize];
    } else {
        self.profileImage.image = [self resizeImage:originalImage withSize:resizeSize];
    }
    
    PFUser *user = [PFUser currentUser];
    
    PFFileObject *imageFile = [ProfileViewController getPFFileFromImage: self.profileImage.image];
    user[@"profileImage"] = imageFile;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
// Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller=
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
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
