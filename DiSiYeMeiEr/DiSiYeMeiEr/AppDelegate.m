//
//  AppDelegate.m
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/21.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+JCMethond.h"
#import "UINavigationBar+JCNavigationBarHandle.h"
#import "JCTool.h"
#import "JCAlgorithmTool.h"
#import "JCPhone.h"
#import "JCNSPredicateTool.h"
//#import <StoreKit.h>
@interface AppDelegate ()
@property(nonatomic,strong)NSMutableArray *testArr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    JCNSPredicateTool *tool = [[JCNSPredicateTool alloc] init];
////    [tool test1];
//    [tool test2];
//    NSMutableString *testStr = [[NSMutableString alloc] initWithString:@""];
//    [testStr appendString:@"["];
//    [testStr appendString:@"1"];
//    [testStr appendString:@"]"];
//    NSLog(@"%@",testStr);
//    NSDate *currentDate = [NSDate date];
    
    
    NSMutableString *word = [[NSMutableString alloc] initWithString:@"hello--"];
    NSString *subStr = @"";
    NSRange range = [word rangeOfString:@"-"];
    if(range.location == 0){///头有"-"
         subStr = [word substringWithRange:NSMakeRange(1, word.length - range.length)];
    }else if (range.location == word.length - 1){
        subStr = [word substringWithRange:NSMakeRange(0, word.length - range.length)];
    }
        
        
    
    
    NSLog(@"--subStr:%@",subStr);
    
    
    return YES;
}



//计算两个日期之间的天数

+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
//创建日期格式化对象
NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//取两个日期对象的时间间隔：
//这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
NSTimeInterval time = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = ((NSInteger)time)/(3600*24);
//int hours=((int)time)%(3600*24)/3600;
//NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
return days;
}


//计算日期间隔天数
- (NSInteger)computeDaysWithDataFromString:(NSString *)string
{
   NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   [gregorian setFirstWeekday:2];
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   NSDate *fromDate;
   NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:string]];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
   
   return dayComponents.day;
}




- (BOOL)JudgeString:(NSString *)string{
    NSString *regex =@"[A-Za-z]+";
    NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return[predicate evaluateWithObject:string];
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
