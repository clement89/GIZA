//
//  AppDelegate.m
//  GIZA LAUNDRY
//
//  Created by Divox_RND on 06/06/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self isUserLoggedIn];
    
    
    UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeBadge |
                                                             UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    

    
    
    
    //added by cjc
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (notification) {
        [self application:application didReceiveRemoteNotification:(NSDictionary*)notification];
    }
    
    
    
    
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


#pragma mark push notification
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    MYLog(@"userInfo - %@",userInfo);
    
    MYLog(@"cjc ~ %@",userInfo);
    
    
//    NSDictionary *apsDict = [userInfo valueForKey:@"aps"];
//    
//    MYLog(@"aps - -- %@",apsDict);
    
    
//    [[[UIAlertView alloc] initWithTitle:@"Alert" message:[apsDict valueForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    MYLog(@"My token is: %@", deviceToken);
    
    
    //    NSString * tokenAsString = [[[deviceToken description]
    //                                 stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
    //                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    const char* data = [deviceToken bytes];
    NSMutableString* tokenAsString = [NSMutableString string];
    
    for (int i = 0; i < [deviceToken length]; i++) {
        [tokenAsString appendFormat:@"%02.2hhX", data[i]];
    }
    
    MYLog(@"tokenAsString - %@",tokenAsString);
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:tokenAsString forKey:@"kgcm_key"];
    [def synchronize];
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    MYLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    
    MYLog(@"cjc ~ %@",identifier);
    
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
    
    
    // Must be called when finished
    completionHandler();
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    
    MYLog(@"cjc ~ %@",userInfo);
    
    
    NSDictionary *apsDict = [userInfo valueForKey:@"aps"];
    
    MYLog(@"aps - -- %@",apsDict);
    
    
    [[[UIAlertView alloc] initWithTitle:@"Alert" message:[apsDict valueForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    
    
    
   
    
    
}






#pragma mark private methods

-(void)isUserLoggedIn{
    
    
    BOOL isLogedIn = [[NSUserDefaults standardUserDefaults]boolForKey:@"y2kLoggedIn"];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (isLogedIn) {
        // Show the dashboard
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    } else {
        // Login
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    }
    
    [self.window makeKeyAndVisible];
    
    
}





@end
