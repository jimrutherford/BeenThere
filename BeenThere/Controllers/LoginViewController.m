//
//  LoginViewController.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-13.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    BOOL isCreatingAccount;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *usernameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginActionButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_backgroundImage resizeToFillScreen];
    _logoImage.origin = CGPointMake(31, 160);
    
    _buttonContainer.alpha = 0.0;
    _buttonContainer.y = 600;
    [_buttonContainer moveToHorizontalCenterOfView:self.view];
    
    [_signInButton applyBeenThereStyle];
    [_createAccountButton applyBeenThereStyle];
    [_loginActionButton applyBeenThereStyle];
    
    
    _loginView.alpha = 0.0;
    _loginView.y = 200;
    [_loginView moveToHorizontalCenterOfView:self.view];
    
    [_usernameTextField darkStyledAttributedPlaceholder:@"Email Address"];
    [_usernameTextField applyBeenThereDarkStyle];
    
    [_passwordTextField darkStyledAttributedPlaceholder:@"Password"];
    [_passwordTextField applyBeenThereDarkStyle];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];;
    
    
    [hoodieManager.hoodie.account automaticallySignInExistingUser:^(BOOL existingUser, NSError *error) {
        
        if (existingUser) {
            [self performSegueWithIdentifier:@"authSegue" sender:self];
        } else {
            
            [self performSelector:@selector(revealLoginButtons) withObject:nil afterDelay:1.0];
        }

        
    }];
    
}

- (void) revealLoginButtons
{
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
       
        _logoImage.size = CGSizeMake(120, 120);
        _logoImage.y = 30,
        [_logoImage moveToHorizontalCenterOfView:self.view];
        
    } completion:nil];
    
    
    [UIView animateWithDuration:0.7 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _buttonContainer.alpha = 1.0;
        _buttonContainer.y = 200;
        
    } completion:nil];
}

- (void) showLoginView
{
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _buttonContainer.alpha = 0.0;
        _buttonContainer.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
    } completion:nil];
    
    _loginView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.7 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _loginView.alpha = 1.0;
        _loginView.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}

- (IBAction)loginButtonPressed:(id)sender {
    
    [_loginActionButton setTitle:@"Sign In" forState:UIControlStateNormal];
    isCreatingAccount = NO;
    [self showLoginView];
    
}

- (IBAction)createButtonPressed:(id)sender {
    [_loginActionButton setTitle:@"Create Account" forState:UIControlStateNormal];
    isCreatingAccount = YES;
    [self showLoginView];
}

- (IBAction)loginActionButtonPressed:(id)sender {
    
    if (isCreatingAccount)
    {
        [self createAccount];
    } else {
        [self signIn];
    }
    
}

- (void) createAccount
{
    [hoodieManager.hoodie.account signUpUserWithName:_usernameTextField.text
                                            password:_passwordTextField.text
                                            onSignUp:^(BOOL signUpSuccessful, NSError *error) {
                                                if (!error)
                                                {
                                                    [self performSegueWithIdentifier:@"authSegue" sender:self];
                                                    
                                                } else {
                                                    NSLog(@"Error %@", error);
                                                }
                                                
                                            }];
}



- (void) signIn
{
    [hoodieManager.hoodie.account signInUserWithName:_usernameTextField.text
                                            password:_passwordTextField.text
                                            onSignIn:^(BOOL signInSuccessful, NSError *error) {
                                                
                                                if (!error)
                                                {
                                                    [self performSegueWithIdentifier:@"authSegue" sender:self];
                                                    
                                                } else {
                                                    NSLog(@"Error %@", error);
                                                }
                                            }];
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
