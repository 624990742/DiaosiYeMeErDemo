//
//  AppDelegate.m
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/21.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic,strong)NSMutableArray *testArr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application 
    
//    NSString *testStr = @"helloWorld123";
//    NSString *str1 = [testStr substringFromIndex:3];
//    NSLog(@"str1==>%@",str1);
//    NSString *str1 = [testStr substringToIndex:3];
//    NSString *str2 = [testStr substringWithRange:NSMakeRange(6,3)];
//    NSString *str3 = [str1 stringByAppendingString:str2];
//    NSLog(@"str1:%@,str2:%@,str3:%@,str:%@",str1,str2,str3,testStr);
    
    
    
    
    

    
    
    
//    NSLog(@"测试打印：%@",[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)]);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
