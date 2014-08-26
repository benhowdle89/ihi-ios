//
//  iHiStartViewController.m
//  iHi
//
//  Created by Ben Howdle on 24/08/2014.
//  Copyright (c) 2014 Ben Howdle. All rights reserved.
//

#import "iHiStartViewController.h"
#import "iHiShareLocationViewController.h"
#import "iHiViewLocationViewController.h"

#import "iHIButton.h"

#import <pop/POP.h>

@interface iHiStartViewController ()
@property(nonatomic, strong) iHIButton *shareLocationBtn;
@property(nonatomic, strong) UIImageView *logo;
@end

@implementation iHiStartViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.427 green:0.427 blue:0.427 alpha:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.427 green:0.427 blue:0.427 alpha:1]};
    
    [self addLogo];
    [self addBlurb];
    [self addNavBtn];
    [self addAnimations];
    
    if(self.coords){
        iHiViewLocationViewController *viewVC = [[iHiViewLocationViewController alloc] init];
        viewVC.coords = self.coords;
        [self.navigationController pushViewController:viewVC animated:YES];
    }
}

- (void)addAnimations {
    POPBasicAnimation *logoOpacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    logoOpacityAnim.fromValue = @(0.0);
    logoOpacityAnim.toValue = @(1.0);
    
    POPSpringAnimation *logoOffscreenAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    logoOffscreenAnim.fromValue = @(self.navigationController.navigationBar.frame.size.height + (self.view.bounds.size.height * 0.15) - 10);
    logoOffscreenAnim.toValue = @(self.navigationController.navigationBar.frame.size.height + (self.view.bounds.size.height * 0.15));
    logoOffscreenAnim.springBounciness = 10.0;
    logoOffscreenAnim.springSpeed = 9.0;
    
    [self.logo.layer pop_addAnimation:logoOpacityAnim forKey:@"logoOpacityAnim"];
    [self.logo.layer pop_addAnimation:logoOffscreenAnim forKey:@"logoOffscreenAnim"];
    
    POPBasicAnimation *shareBtnOpacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    shareBtnOpacityAnim.fromValue = @(0.0);
    shareBtnOpacityAnim.toValue = @(1.0);
    
    POPSpringAnimation *shareBtnOffscreenAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    shareBtnOffscreenAnim.fromValue = @(self.view.bounds.size.height * 0.75);
    shareBtnOffscreenAnim.toValue = @(self.view.center.y + 44);
    shareBtnOffscreenAnim.springBounciness = 4.0;
    
    [self.shareLocationBtn.layer pop_addAnimation:shareBtnOpacityAnim forKey:@"shareBtnOpacityAnim"];
    [self.shareLocationBtn.layer pop_addAnimation:shareBtnOffscreenAnim forKey:@"shareBtnOffscreenAnim"];
}

- (void)addLogo {
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    self.logo.frame = CGRectMake((self.view.bounds.size.width / 2) - 16, self.navigationController.navigationBar.frame.size.height + (self.view.bounds.size.height * 0.15), 32, 32);
    [self.view addSubview:self.logo];
}

- (void)addBlurb {
    UILabel *blurbLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.navigationController.navigationBar.frame.size.height + self.view.bounds.size.height * 0.25), self.view.bounds.size.width, 44)];
    blurbLabel.text = @"Easy location sharing";
    blurbLabel.textAlignment = NSTextAlignmentCenter;
    [blurbLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:24]];
    blurbLabel.textColor = [UIColor colorWithRed:0.427 green:0.427 blue:0.427 alpha:1];
    [self.view addSubview:blurbLabel];
}

- (void)addNavBtn {
    self.shareLocationBtn = [[iHIButton alloc] initWithFrame:CGRectMake(10, self.view.center.y - 22, self.view.bounds.size.width - 20, 88)];
    [self.shareLocationBtn setTitle:@"Share location" forState:UIControlStateNormal];
    [self.shareLocationBtn addTarget:self action:@selector(showShareLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareLocationBtn];
}

- (void)showShareLocation:(id)sender {
    UIViewController *shareLocationVC = [[iHiShareLocationViewController alloc] init];
    [self.navigationController pushViewController:shareLocationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
