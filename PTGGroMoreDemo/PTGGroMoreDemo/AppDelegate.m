//
//  AppDelegate.m
//  PTGGroMoreDemo
//
//  Created by taoyongjiu on 2025/4/20.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BUAdSDKConfiguration *config = [[BUAdSDKConfiguration alloc] init];
    config.appID = @"5688395";
    config.useMediation = YES;
    config.debugLog = @1;
    config.mediation.forbiddenIDFA = @(0);
    // 是否限制个性化广告
    config.mediation.limitPersonalAds = @(0);
    // 是否限制程序化广告
    config.mediation.limitProgrammaticAds = @(0);
    // 主题模式
    config.themeStatus = @(BUAdSDKThemeStatus_Normal);
    // 自定义IDFA
    config.customIdfa = @"3009D44C-A1B7-43E7-86DE-2B2F19B8673A";
    config.SDKDEBUG = true;
    [BUAdSDKManager startWithSyncCompletionHandler:^(BOOL success, NSError * _Nullable error) {
        
    }];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:ViewController.new];
    return YES;
}



@end
