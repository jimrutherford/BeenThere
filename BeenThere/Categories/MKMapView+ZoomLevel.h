//
//  MKMapView+ZoomLevel.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-17.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

-(void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;
-(NSUInteger)getZoomLevel;

@end
