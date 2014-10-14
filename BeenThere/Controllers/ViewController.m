//
//  ViewController.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-10.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "ViewController.h"
#import "FourSquareAPIClient.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self searchForLocation];
}

- (void) searchForLocation
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(49.163522, -123.937283);
    
    [[FourSquareAPIClient sharedClient] searchWithCurrentLcoation:coord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end