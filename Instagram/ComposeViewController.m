//
//  ComposeViewController.m
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/28/22.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeCaption.delegate =self;
}

- (IBAction)ImageTapped:(id)sender {
    [self getCamera];
}

- (void) getCamera{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        NSLog(@"Camara not available will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void)getPhotoLibrary{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didSelectCameraRoll:(id)sender {
}

- (IBAction)didTapCameraRoll:(id)sender {
    [self getPhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    CGSize resizeSize = CGSizeMake(500, 400);
    if (editedImage) {
        self.composeImage.image = [self resizeImage:editedImage withSize:resizeSize];
    } else {
        self.composeImage.image = [self resizeImage:originalImage withSize:resizeSize];
    }
    
    // Do something with the images (based on your use case)
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapShare:(id)sender {
    UIImage *myImage = self.composeImage.image;
    NSString *myCaption = self.composeCaption.text;
    
    [Post postUserImage:myImage withCaption:myCaption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil){
            NSLog(@"Erorr posting image: %@", error.localizedDescription);
        }else{
            NSLog(@"Posted image!");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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

@end
