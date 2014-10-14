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

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_backgroundImage resizeToFillScreen];
    _logoImage.origin = CGPointMake(31, 160);
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(revealLogin) withObject:nil afterDelay:3.0];
}

- (void) revealLogin
{
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
       
        _logoImage.size = CGSizeMake(100, 100);
        _logoImage.y = 30,
        [_logoImage moveToHorizontalCenterOfView:self.view];
        
    } completion:^(BOOL finished) {
        
    }];
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
