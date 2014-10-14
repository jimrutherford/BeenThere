//
//  LoginViewController.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-13.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIView *loginView;

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
    
    _loginView.alpha = 0.0;
    _loginView.y = 200;
    [_loginView moveToHorizontalCenterOfView:self.view];
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(revealLogin) withObject:nil afterDelay:1.0];
}

- (void) revealLogin
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

- (IBAction)loginButtonPressed:(id)sender {
    
    
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

- (IBAction)createButtonPressed:(id)sender {
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
