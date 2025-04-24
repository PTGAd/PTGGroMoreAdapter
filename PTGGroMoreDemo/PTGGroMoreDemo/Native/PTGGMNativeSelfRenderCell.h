//
//  PTGGMNativeSelfRenderCell.h
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/22.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN
@class PTGGMNativeSelfRenderCell;


@protocol PTGGMNativeSelfRenderDislikeDelgate <NSObject>

- (void)feedCustomDislike:(PTGGMNativeSelfRenderCell *)cell withNativeAd:(BUNativeAd *)nativeAd;

@end

@interface PTGGMNativeSelfRenderCell : UITableViewCell

@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong, nullable) UIImageView *iv1;
@property (nonatomic, strong, nullable) UILabel *adTitleLabel;
@property (nonatomic, strong, nullable) UILabel *infoLabel;
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;
@property (nonatomic, strong) UIButton *customDislikeBtn;
@property (nonatomic, weak) id<PTGGMNativeSelfRenderDislikeDelgate> delegate;

- (void)buildupView;

- (void)refreshUIWithModel:(BUNativeAd *)model;
+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
