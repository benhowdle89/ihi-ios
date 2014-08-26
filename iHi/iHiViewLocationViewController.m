//
//  iHiViewLocationViewController.m
//  iHi
//
//  Created by Ben Howdle on 25/08/2014.
//  Copyright (c) 2014 Ben Howdle. All rights reserved.
//

#import "iHiViewLocationViewController.h"

#import "iHIButton.h"

#import <MapKit/MapKit.h>

@interface iHiViewLocationViewController ()<MKMapViewDelegate>
@property(nonatomic, strong) MKMapView *map;
@end

@implementation iHiViewLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"View someone's location";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1];
    
    [self showMap];
    [self addDirectionsBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self updateLocationInMap:self.coords];
}

- (void)addDirectionsBtn {
    UIButton *directionsBtn = [[iHIButton alloc] initWithFrame:CGRectMake(10, (self.view.bounds.size.height * 0.75) + ((self.view.bounds.size.height * 0.25) / 2) - 3, self.view.bounds.size.width - 20, 44)];
    [directionsBtn setTitle:@"Get me there" forState:UIControlStateNormal];
    [directionsBtn addTarget:self action:@selector(openMapsApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:directionsBtn];
}

- (void)showMap {
    self.map = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height * 0.75)];
    self.map.showsUserLocation = YES;
    self.map.delegate = self;
    [self.view addSubview:self.map];
}

- (void)openMapsApp:(id)sender {
    NSString *mapsURL = [[NSString alloc] initWithFormat:@"http://maps.apple.com/?daddr=%@,%@&saddr=%f,%f", self.coords[@"lat"], self.coords[@"long"], self.map.userLocation.location.coordinate.latitude, self.map.userLocation.location.coordinate.longitude];
    NSURL *url = [[NSURL alloc] initWithString:mapsURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)updateLocationInMap:(NSDictionary *)coords {
    MKCoordinateRegion region;
    CLLocation *locObj = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([coords[@"lat"] doubleValue], [coords[@"long"] doubleValue])
                                                       altitude:0
                                             horizontalAccuracy:0
                                               verticalAccuracy:0
                                                      timestamp:[NSDate date]];
    
    region.center = locObj.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta  = 1; // values for zoom
    span.longitudeDelta = 1;
    region.span = span;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setTitle:@"Their location"];
    [annotation setCoordinate:locObj.coordinate];
    [annotation setSubtitle:@"iHi"];
    [self.map setRegion:region animated:YES];
    [self.map addAnnotation:annotation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
