//
//  BaseAdViewController.h
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAdViewController : UIViewController

@property(nonatomic,strong) UIButton *showAdButton;
@property(nonatomic,strong) UIButton *loadAdButton;
@property(nonatomic,strong) UILabel *statusLabel;


- (void)showAd:(UIButton *)sender;

- (void)loadAd:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
