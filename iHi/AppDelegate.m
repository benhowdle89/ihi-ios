//
//  AppDelegate.m
//  iHi
//
//  Created by Ben Howdle on 24/08/2014.
//  Copyright (c) 2014 Ben Howdle. All rights reserved.
//

#import "AppDelegate.h"

#import "iHiStartViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    iHiStartViewController *startVC = [self getVC:url];
    [self startApp:startVC];
    return YES;
}

- (iHiStartViewController *)getVC:(NSURL *)url {
    iHiStartViewController *startVC = [[iHiStartViewController alloc] init];
    
    if(url){
        NSString * q = [url query];
        NSArray * pairs = [q componentsSeparatedByString:@"&"];
        NSMutableDictionary * kvPairs = [NSMutableDictionary dictionary];
        for (NSString * pair in pairs) {
            NSArray * bits = [pair componentsSeparatedByString:@"="];
            NSString * key = [[bits objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString * value = [[bits objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [kvPairs setObject:value forKey:key];
        }
        
        NSDictionary *coords = @{
                                 @"lat": [kvPairs objectForKey:@"lat"],
                                 @"long": [kvPairs objectForKey:@"long"]
                                 };
        
        startVC.coords = coords;
        
    }
    return startVC;
}

- (void)startApp:(iHiStartViewController *)startVC {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:startVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen 									                       mainScreen] bounds]];
    
    NSURL *urlToParse = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    iHiStartViewController *startVC = [self getVC:urlToParse];
    [self startApp:startVC];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
