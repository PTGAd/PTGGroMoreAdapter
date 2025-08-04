//
//  PTGInterstitialViewController 2.h
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/6/13.
//


//
//  PTGInterstitialViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGRewardVideoViewController.h"

@interface PTGRewardVideoViewController ()<BUNativeExpressRewardedVideoAdDelegate>

@property(nonatomic,strong)BUNativeExpressRewardedVideoAd *rewardVideoAd;
@property(nonatomic,assign)BOOL isLoading;
@end

@implementation PTGRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)loadAd:(UIButton *)sender {
    if (self.isLoading) {
        return;
    }
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.mediation.bidNotify = YES;
    slot.ID = @"103521390";
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.rewardName = @"123";
    model.rewardAmount = 400;
    model.userId = @"12";
    model.extra = @"fsfd";
    self.isLoading = YES;
    self.statusLabel.text = @"开始加载中";
    self.rewardVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlot:slot rewardedVideoModel:model];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAdData];
}

- (void)showAd:(UIButton *)sender {
    
    if (self.rewardVideoAd.mediation.isReady) {
        [self.rewardVideoAd showAdFromRootViewController:self];
        self.statusLabel.text = @"广告已展示";
    }  else {
        self.statusLabel.text = @"广告已过期";
    }
}


- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"激励广告加载成功");
}

/**
This method is called when video ad materia failed to load.
@param error : the reason of error
*/
- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"激励广告加载失败");
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载失败";
}

/**
This method is called when cached successfully.
For a better user experience, it is recommended to display video ads at this time.
And you can call [BUNativeExpressRewardedVideoAd showAdFromRootViewController:].
*/
- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"激励广告素材加载成功");
}

/**
This method is called when video ad slot has been shown.
*/
- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"激励广告展示成功 ecpm = %@",rewardedVideoAd.mediation.getShowEcpmInfo.ecpm);
}

/**
This method is called when video ad is closed.
*/
- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"激励广告展示关闭");
}

/**
This method is called when video ad is clicked.
*/
- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"激励广告展示点击");
}

/**
This method is called when the user clicked skip button.
*/
- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    
}

/**
This method is called when video ad play completed or an error occurred.
@param error : the reason of error
*/
- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"激励广告播放完成 error = %@",error);
}

/**
Server verification which is requested asynchronously is succeeded. now include two v erify methods:
     1. C2C need  server verify  2. S2S don't need server verify
@param verify :return YES when return value is 2000.
*/
- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    NSLog(@"获得激励奖励 verify = %d",verify);
}

@end
