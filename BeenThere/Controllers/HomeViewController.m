//
//  ViewController.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-10.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "HomeViewController.h"
#import "FourSquareAPIClient.h"


@interface HomeViewController ()

@property (nonatomic, strong) NSArray *beenTheres;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarTitle"]];
    self.navigationItem.titleView = titleView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *beenDone = @{@"placeName": @"SquareOne"};
    
    [hoodieManager.hoodie.store saveObject:beenDone
                                  withType:@"been"
                                    onSave:^(NSDictionary *object, NSError *error) {
                                        if (!error)
                                        {
                                            [self.navigationController popToRootViewControllerAnimated:YES];
                                        }
                                    }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _beenTheres = [hoodieManager.hoodie.store findAllObjectsWithType:@"been"];
    [self.tableView reloadData];
}

#pragma mark - Tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *beenThere = [_beenTheres objectAtIndex:indexPath.row];
    
    cell.textLabel.text = beenThere[@"placeName"];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_beenTheres count];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
