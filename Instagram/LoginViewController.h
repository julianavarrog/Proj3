//
//  ViewController.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/27/22.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *LoginLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)SignupButton:(id)sender;
- (IBAction)LoginButton:(id)sender;


@end

