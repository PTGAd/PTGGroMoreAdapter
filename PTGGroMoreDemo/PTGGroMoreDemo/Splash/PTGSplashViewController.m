//
//  PTGSplashViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGSplashViewController.h"

@interface PTGSplashViewController()<BUSplashAdDelegate>

@property(nonatomic,strong)BUSplashAd *splashAd;
@property(nonatomic,assign)BOOL isLoading;

@end

@implementation PTGSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadAd:(UIButton *)sender {
    if (self.isLoading) {
        return;
    }
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 120)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
    logo.accessibilityIdentifier = @"splash_logo";
    logo.frame = CGRectMake(0, 0, 311, 47);
    logo.center = bottomView.center;
    [bottomView addSubview:logo];
    self.isLoading = YES;
    self.statusLabel.text = @"开始加载中";
    BUAdSlot *slot = [[BUAdSlot alloc]init];
    slot.mediation.bidNotify = YES;
    slot.ID = @"103451679";
    self.splashAd = [[BUSplashAd alloc] initWithSlot:slot adSize:CGSizeZero];
    self.splashAd.delegate = self;
    self.splashAd.mediation.customBottomView = bottomView;
    [self.splashAd loadAdData];
}

- (void)showAd:(UIButton *)sender {
    if (self.splashAd.mediation.isReady) {
        [self.splashAd showSplashViewInRootViewController:self.navigationController];
        self.statusLabel.text = @"广告已展示";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}


#pragma mark - BUSplashAdDelegate -
- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd {
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"开屏加载成功");
}

/// This method is called when material load failed
- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error {
    NSLog(@"开屏加载失败 error = %@",error);
    self.statusLabel.text = @"广告加载失败";
    self.isLoading = NO;
}

/// This method is called when splash view render successful
// Mediation:/// @Note :  (针对聚合维度广告)<6300版本不会回调该方法，>=6300开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)splashAdRenderSuccess:(BUSplashAd *)splashAd {
    self.statusLabel.text = @"广告渲染成功";
}

/// This method is called when splash view render failed
// Mediation:/// @Note :  (针对聚合维度广告)<6300版本不会回调该方法，>=6300开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)splashAdRenderFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error {
    
}

/// This method is called when splash view will show
- (void)splashAdWillShow:(BUSplashAd *)splashAd {
    NSLog(@"开屏展示 ecpm = %@",splashAd.mediation.getShowEcpmInfo.ecpm);
}

/// This method is called when splash view did show
// Mediation:/// @Note :  当加载聚合维度广告时，支持该回调的adn有：CSJ
- (void)splashAdDidShow:(BUSplashAd *)splashAd {
   
}

/// This method is called when splash view is clicked.
- (void)splashAdDidClick:(BUSplashAd *)splashAd {
    NSLog(@"开屏点击成功");
}

/// This method is called when splash view is closed.
- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    NSLog(@"开屏关闭");
    [self.splashAd.mediation.customBottomView removeFromSuperview];
}

/// This method is called when splash viewControllr is closed.
// Mediation:/// @Note : 当加载聚合维度广告，最终展示的广告关闭时，
// Mediation:///         如该adn未提供“控制器关闭”回调，为保持逻辑完整，聚合逻辑内部在DidClose后补齐该回调，
// Mediation:///         如该adn提供“控制器关闭”回调，则以对应adn为准。
- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {

}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashDidCloseOtherController:(BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"开屏详情页关闭");
}

/// This method is called when when video ad play completed or an error occurred.
- (void)splashVideoAdDidPlayFinish:(BUSplashAd *)splashAd didFailWithError:(NSError *_Nullable)error {
    
}

@end
