//
//  PTGGMNativeViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGGMNativeSelfRenderViewController.h"
#import <Masonry/Masonry.h>
#import "PTGGMNativeSelfRenderCell.h"

@interface PTGGMNativeSelfRenderViewController ()<BUNativeAdsManagerDelegate,PTGGMNativeSelfRenderDislikeDelgate,BUMNativeAdDelegate>

@property(nonatomic,strong)BUNativeAdsManager* adManager;
@property(nonatomic,strong)BUNativeAd *nativeAd;
@property(nonatomic,strong)UIView *nativeAdView;
@end

@implementation PTGGMNativeSelfRenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = @"103453320";
    slot1.mediation.bidNotify = YES;
    BUSize *imgSize1 = [[BUSize alloc] init];
    imgSize1.width = 1080;
    imgSize1.height = 1920; // 按照实际情况设置宽高
    slot1.imgSize = imgSize1;
    slot1.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 400);
    self.adManager = [[BUNativeAdsManager alloc] initWithSlot:slot1];
    self.adManager.mediation.rootViewController = self;
    self.adManager.delegate = self;
    [self.adManager loadAdDataWithCount:1];
}

- (void)showAd:(UIButton *)sender {
    if (self.nativeAd.mediation.isReady) {
        self.statusLabel.text = @"广告已展示";
        [self.nativeAdView removeFromSuperview];
        PTGGMNativeSelfRenderCell *cell = [[PTGGMNativeSelfRenderCell alloc] init];
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat h = [PTGGMNativeSelfRenderCell cellHeightWithModel:self.nativeAd width:UIScreen.mainScreen.bounds.size.width];
        cell.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, h);
        cell.delegate = self;
        [cell refreshUIWithModel:self.nativeAd];
        self.nativeAdView = cell;
        [self.view addSubview:cell];
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}

#pragma mark - PTGGMNativeSelfRenderDislikeDelgate -
- (void)feedCustomDislike:(PTGGMNativeSelfRenderCell *)cell withNativeAd:(BUNativeAd *)nativeAd {
    self.nativeAd = nil;
    [cell removeFromSuperview];
}

#pragma mark - BUNativeAdsManagerDelegate -
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    /// 穿山甲没有自渲染权限 但是如果其他消耗方价格低的情况下 ，穿山甲会竞胜，返回空数组，媒体需要判断
    if (nativeAdDataArray.count == 0) {
        return;
    }
    self.nativeAd = nativeAdDataArray.firstObject;
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"信息流加载成功");
    self.nativeAd.rootViewController = self;
    self.nativeAd.delegate = self;
    [self.nativeAd render];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    NSLog(@"信息流加载失败 error = %@",error);
    self.statusLabel.text = @"广告加载失败";
}

/**
 This method is called when native ad slot has been shown.
 */
- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    NSLog(@"信息流展示成功");
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"信息流详情页关闭");
}

/**
 This method is called when native ad is clicked.
 */
- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
    NSLog(@"信息流点击");
}

/**
 This method is called when the Ad view container is forced to be removed.
 @param nativeAd : Ad material
 @param adContainerView : Ad view container
 */
- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd adContainerViewDidRemoved:(UIView *)adContainerView {
    NSLog(@"信息流被移除");
}


- (void)nativeAdExpressViewRenderFail:(BUNativeAd * _Nonnull)nativeAd error:(NSError * _Nullable)error { 
    
}

- (void)nativeAdExpressViewRenderSuccess:(BUNativeAd * _Nonnull)nativeAd { 
    
}

- (void)nativeAdShakeViewDidDismiss:(BUNativeAd * _Nullable)nativeAd { 
    
}

- (void)nativeAdVideo:(BUNativeAd * _Nullable)nativeAdView rewardDidCountDown:(NSInteger)countDown { 
    
}

- (void)nativeAdVideo:(BUNativeAd * _Nullable)nativeAd stateDidChanged:(BUPlayerPlayState)playerState { 
    
}

- (void)nativeAdVideoDidClick:(BUNativeAd * _Nullable)nativeAd { 
    
}

- (void)nativeAdVideoDidPlayFinish:(BUNativeAd * _Nullable)nativeAd { 
    
}

- (void)nativeAdWillPresentFullScreenModal:(BUNativeAd * _Nonnull)nativeAd { 
    
}



@end
