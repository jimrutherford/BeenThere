//
//  SelectLocationViewController.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-15.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "SelectLocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FourSquareAPIClient.h"
#import "FourSquarePlace.h"
#import "MKMapView+ZoomLevel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


#define mapWindowHeight 300

@interface SelectLocationViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mapPin;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSArray *places;

@end

@implementation SelectLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout=UIRectEdgeNone;
    //self.automaticallyAdjustsScrollViewInsets=NO;
    
    _placesTableView.delegate = self;
    _placesTableView.dataSource = self;
    
    _mapView.delegate = self;
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beenThereNavTitle"]];
    self.navigationItem.titleView = titleView;
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandler:)];
    panGesture.delegate = self;
    [_mapView addGestureRecognizer:panGesture];

    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandler:)];
    pinchGesture.delegate = self;
    [_mapView addGestureRecognizer:pinchGesture];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _blurView.height = _mapView.height - mapWindowHeight;
    
    
    _blurView.x = 0;
    [_blurView resizeToScreenWidth];
    [_blurView pinToBottomOfView:self.view];
    
    [_mapPin moveToHorizontalCenterOfView:_mapView];
    _mapPin.y = mapWindowHeight / 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void) gestureHandler:(UIGestureRecognizer*) gesture
{
    NSLog(@"Zoom Level: %lu", (unsigned long)[_mapView getZoomLevel]);
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _mapPin.alpha = 0.4;
        }];
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _mapPin.alpha = 1.0;
        }];
    }
}

#pragma mark - MKMapViewDelegate methods

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CGPoint point = CGPointMake(_mapPin.x + (_mapPin.width / 2), _mapPin.y + _mapPin.height);
    CLLocationCoordinate2D mapPoint = [_mapView convertPoint:point toCoordinateFromView:self.view];
    
    NSLog(@"Center %f : %f", mapPoint.latitude, mapPoint.longitude);
    
    
    if ([_mapView getZoomLevel] > 12)
    {
        // search for venues
        CGPoint nePoint = CGPointMake(_mapView.width, 0);
        CLLocationCoordinate2D neMapPoint = [_mapView convertPoint:nePoint toCoordinateFromView:self.view];

        CGPoint swPoint = CGPointMake(0, mapWindowHeight);
        CLLocationCoordinate2D swMapPoint = [_mapView convertPoint:swPoint toCoordinateFromView:self.view];
        
        NSLog(@"NE %f : %f \nSW %f : %f", neMapPoint.latitude, neMapPoint.longitude, swMapPoint.latitude, swMapPoint.longitude);
        
        [[FourSquareAPIClient sharedClient] searchVenuesWithSouthWest:swMapPoint northEast:neMapPoint success:^(NSArray *results) {
            
            _places = results;
            
            [_placesTableView reloadData];
            
        } failure:^(NSError *error) {
            NSLog(@"Error %@", error);
        }];
        
    } else {
        // search for cities
        CGPoint point = CGPointMake(_mapPin.x + (_mapPin.width / 2), _mapPin.y + _mapPin.height);
        CLLocationCoordinate2D mapPoint = [_mapView convertPoint:point toCoordinateFromView:self.view];
        
        NSLog(@"Center %f : %f", mapPoint.latitude, mapPoint.longitude);
        
        [[FourSquareAPIClient sharedClient] searchWithCurrentLocation:mapPoint success:^(NSArray *results) {
            
            _places = results;
            
            [_placesTableView reloadData];
            
        } failure:^(NSError *error) {
            NSLog(@"Error %@", error);
        }];
    }
    

    
}

#pragma mark - Tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];

        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:23.0f];
        cell.textLabel.textColor = [UIColor btLightGrayColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    FourSquarePlace *place = _places[indexPath.row];
    
    cell.textLabel.text = place.placeName;
    
    if (place.iconURL)
    {
        [cell.imageView setImageWithURL:place.iconURL];
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_places count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
