//
//  PTGGMNativeViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGGMNativeViewController.h"
#import <Masonry/Masonry.h>

@interface PTGGMNativeViewController ()<BUNativeExpressAdViewDelegate>

@property(nonatomic,strong)BUNativeExpressAdManager *adManager;
@property(nonatomic,strong)BUNativeExpressAdView *expressAdView;
@end

@implementation PTGGMNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.mediation.bidNotify = YES;
    slot1.ID = @"103451853";
    BUSize *imgSize1 = [[BUSize alloc] init];
    imgSize1.width = 1080;
    imgSize1.height = 1920; // 按照实际情况设置宽高
    slot1.imgSize = imgSize1;
    slot1.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 400);
    self.adManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 0)];
    self.adManager.mediation.rootViewController = self;
    self.adManager.delegate = self;
    [self.adManager loadAdDataWithCount:1];
}

- (void)showAd:(UIButton *)sender {
    if (self.expressAdView.isReady) {
        [[self.view viewWithTag:10001] removeFromSuperview];
        self.statusLabel.text = @"广告展示成功";
        CGRect frame = self.expressAdView.frame;
        frame.origin.y = 100;
        self.expressAdView.frame = frame;
        self.expressAdView.tag = 10001;
        [self.view addSubview:self.expressAdView];
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}

/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"信息流加载成功");
    [views enumerateObjectsUsingBlock:^(__kindof BUNativeExpressAdView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj render];
        [obj setRootViewController:self];
    }];
}

/**
 * Sent when views fail to load ad
 */
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *_Nullable)error {
    NSLog(@"信息流加载失败 error = %@",error);
    self.statusLabel.text = @"广告加载失败";
}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"信息流渲染成功");
    self.statusLabel.text = @"广告渲染成功";
    self.expressAdView = nativeExpressAdView;
//    [self.ads addObject:nativeExpressAdView];
//    [self.tableView reloadData];
}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    NSLog(@"信息流渲染失败 error =%@",error);
    self.statusLabel.text = @"广告渲染失败";
}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"信息流展示成功 ecpm = %@",nativeExpressAdView.mediation.getShowEcpmInfo.ecpm);
}

/**
 * Sent when an ad view is clicked
 */
- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"信息流点击");
}

/**
Sent when a playerw playback status changed.
@param playerState : player state after changed
*/
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    
}

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    
}

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    NSLog(@"信息流关闭");
    self.expressAdView = nil;
    [nativeExpressAdView removeFromSuperview];
//    [self.ads removeObject:nativeExpressAdView];
//    [self.tableView reloadData];
}

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType; {
    NSLog(@"信息流详情页关闭");
}


/**
 This method is called when the Ad view container is forced to be removed.
 @param nativeExpressAdView : Ad view container
 */
- (void)nativeExpressAdViewDidRemoved:(BUNativeExpressAdView *)nativeExpressAdView {
    
}

@end
