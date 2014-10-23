//
//  AddDetailsViewController.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-17.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "AddDetailsViewController.h"

@interface AddDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UIImageView *placeIcon;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *whenTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *detailsTextView;

@end

@implementation AddDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doneThatNavTitle"]];
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor btLightGrayColor];
    
    [_whenTextField lightStyledAttributedPlaceholder:@"When"];
    [_whenTextField applyBeenThereLightStyle];
    
    [_detailsTextView lightStyledAttributedPlaceholder:@"Details"];
    [_detailsTextView applyBeenThereLightStyle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updatePlace];
}



- (void) updatePlace
{
    _placeName.text = _place.placeName;
    
    if (_place.iconDarkURL)
    {
        [_placeIcon setImageWithURL:_place.iconDarkURL placeholderImage:[UIImage imageNamed:@"pinPlaceholder"]];
    }
}


- (IBAction)saveButtonTapped:(id)sender {
    
    NSDictionary *beenDone = @{@"placeName": _place.placeName};
    
    [hoodieManager.hoodie.store saveObject:beenDone
                         withType:@"been"
                           onSave:^(NSDictionary *object, NSError *error) {
                               if (!error)
                               {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }
                           }];
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
