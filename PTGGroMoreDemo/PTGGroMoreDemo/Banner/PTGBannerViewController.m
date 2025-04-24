//
//  PTGBannerViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGBannerViewController.h"

@interface PTGBannerViewController ()<BUNativeExpressBannerViewDelegate>

@property(nonatomic,strong)BUNativeExpressBannerView *banner;

@end

@implementation PTGBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAdButton.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)loadAd:(UIButton *)sender {
    BUAdSlot *slot = [[BUAdSlot alloc]init];
    slot.ID = @"103451486";
    slot.mediation.bidNotify = YES;
    self.banner = [[BUNativeExpressBannerView alloc] initWithSlot:slot rootViewController:self adSize:CGSizeMake(300, 80)];
    self.banner.delegate = self;
    [self.banner loadAdData];
}

- (void)showAd:(UIButton *)sender {
    
}

#pragma mark - BUMNativeExpressBannerViewDelegate -
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self.view addSubview:bannerAdView];
    CGPoint origin = CGPointMake((UIScreen.mainScreen.bounds.size.width - bannerAdView.frame.size.width) / 2, 200);
    CGRect frame = bannerAdView.frame;
    frame.origin = origin;
    bannerAdView.frame = frame;
    NSLog(@"banner加载成功");
}

/**
This method is called when bannerAdView ad slot failed to load.
@param error : the reason of error
*/
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"banner加载失败 error = %@",error);
}

/**
This method is called when rendering a nativeExpressAdView successed.
*/
// Mediation:/// @Note :  (针对聚合维度广告)<6400版本不会回调该方法，>=6400开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    
}

/**
This method is called when a nativeExpressAdView failed to render.
@param error : the reason of error
*/
// Mediation:/// @Note :  (针对聚合维度广告)<6400版本不会回调该方法，>=6400开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error {
    
}

/**
This method is called when bannerAdView ad slot showed new ad.
// Mediation:@Note :  Mediation dimension does not support this callBack.
*/
- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {

}

/**
This method is called when bannerAdView is clicked.
*/
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"banner点击");
}

/**
This method is called when the user clicked dislike button and chose dislike reasons.
@param filterwords : the array of reasons for dislike.
*/
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords {
    NSLog(@"banner关闭");
}

/**
This method is called when another controller has been closed.
@param interactionType : open appstore in app or open the webpage or view video ad details page.
*/
- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSLog(@"banner详情页关闭");
}

/**
This method is called when the Ad view container is forced to be removed.
@param bannerAdView : Express Banner Ad view container
*/
- (void)nativeExpressBannerAdViewDidRemoved:(BUNativeExpressBannerView *)bannerAdView {
    
}

- (void)nativeExpressBannerAdViewDidBecomeVisible:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"banner展示");
}


@end
