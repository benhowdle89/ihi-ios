//
//  iHiShareLocationViewController.m
//  iHi
//
//  Created by Ben Howdle on 24/08/2014.
//  Copyright (c) 2014 Ben Howdle. All rights reserved.
//

#import "iHiShareLocationViewController.h"

#import "iHIButton.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MapKit/MapKit.h>
#import <pop/POP.h>

@interface iHiShareLocationViewController ()<MKMapViewDelegate, MFMessageComposeViewControllerDelegate>
@property(nonatomic, strong) MKMapView *map;
@property(nonatomic, strong) MFMessageComposeViewController *messageView;
@end

@implementation iHiShareLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Share your location";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1];
    
    [self addShareBtn];
    [self showMapWithUserLocation];
}

+(NSString *)urlEncodedStringUsingString:(NSString *)string {
    
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)string, NULL, CFSTR("!*'();:@&=+$,/?%#[]\" "), kCFStringEncodingUTF8));
    
    return escapedString;
}

- (void)addShareBtn {
    
    UIButton *shareBtn = [[iHIButton alloc] initWithFrame:CGRectMake(10, (self.view.bounds.size.height * 0.75) + ((self.view.bounds.size.height * 0.25) / 2) - 3, self.view.bounds.size.width - 20, 44)];
    [shareBtn setTitle:@"Share" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(openSharing:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

- (NSString *)getShareLink {
    NSString *siteLink = [[NSString alloc] initWithFormat:@"http://ihi.im/#location,data={\"latitude\":%f,\"longitude\":%f}", self.map.userLocation.location.coordinate.latitude, self.map.userLocation.location.coordinate.longitude];
    siteLink = [siteLink stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    siteLink = [siteLink stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
    return siteLink;
}

- (NSString *)getAppSchemaLink {
    return [[NSString alloc] initWithFormat:@"ihi://?lat=%f&long=%f", self.map.userLocation.location.coordinate.latitude, self.map.userLocation.location.coordinate.longitude];
}

- (void)openSharing:(id)sender {
    NSString *shareMessage = [[NSString alloc] initWithFormat:@"Find me, on the web: %@ or in-app: %@", [self getShareLink], [self getAppSchemaLink]];
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[shareMessage]
                                      applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController
                                       animated:YES
                                     completion:^{
                                         [[self messageView] dismissViewControllerAnimated:YES completion:nil];
                                     }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [[self messageView] dismissViewControllerAnimated:YES completion:nil];
}

- (void)showMapWithUserLocation {
    self.map = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height * 0.75)];
    self.map.showsUserLocation = YES;
    self.map.delegate = self;
    [self.view addSubview:self.map];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [self.map setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
