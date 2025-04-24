//
//  PTGGMNativeSelfRenderCell.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/22.
//

#import "PTGGMNativeSelfRenderCell.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import "BUDFeedStyleHelper.h"
#import "BUDMacros.h"

static CGFloat const margin = 15;
static CGSize const logoSize = {15, 15};
static UIEdgeInsets const padding = {10, 15, 10, 15};

@interface PTGGMNativeSelfRenderCell()


@end

@implementation PTGGMNativeSelfRenderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }
    return self;
}


- (void)closeButtonDidClicked:(UIButton *)sender {
    [self.nativeAd.mediation.canvasView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(feedCustomDislike:withNativeAd:)]) {
        [self.delegate feedCustomDislike:self withNativeAd:self.nativeAd];
    }
}

- (void)buildupView {
    
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.separatorLine = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, swidth-margin*2, 0.5)];
    self.separatorLine.backgroundColor = BUD_RGB(0xd9, 0xd9, 0xd9);
    [self.contentView addSubview:self.separatorLine];
    
    self.iv1 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iv1];
    
    self.adTitleLabel = [UILabel new];
    self.adTitleLabel.numberOfLines = 0;
    self.adTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.adTitleLabel];
    
    self.infoLabel = [UILabel new];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.textColor = BUD_RGB(0x55, 0x55, 0x55);
    self.infoLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.infoLabel];
    
    // Add custom button
    [self.contentView addSubview:self.customBtn];
    
    [self.contentView addSubview:self.customDislikeBtn];
    
    self.nativeAdRelatedView = [[BUNativeAdRelatedView alloc] init];
    
    
    [self addAccessibilityIdentifier];
}

- (void)addAccessibilityIdentifier {
    self.adTitleLabel.accessibilityIdentifier = @"feed_title";
    self.infoLabel.accessibilityIdentifier = @"feed_des";
    self.nativeAdRelatedView.dislikeButton.accessibilityIdentifier = @"dislike";
    self.customBtn.accessibilityIdentifier = @"feed_button";
    self.iv1.accessibilityIdentifier = @"feed_view";
}

- (void)refreshUIWithModel:(BUNativeAd *)model {
    if (model.data.imageAry.count == 0 || model.isNativeExpress) { return; }
    self.nativeAd = model;
    BUMCanvasView *canvasView = model.mediation.canvasView;
    [self.contentView insertSubview:canvasView atIndex:0];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    canvasView.titleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    canvasView.titleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    BUImage *image = model.data.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    canvasView.imageView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    [canvasView.imageView sd_setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
    y += imageHeight;
    y += 10;
    
    /// logo宽高比 3 ： 1
    CGFloat originInfoX = padding.left;
    canvasView.adLogoView.frame = CGRectMake(originInfoX,
                                             y + 3,
                                             42,
                                             14);
    
    /// 自定义视图，添加到canvasView 上
    CGFloat dislikeX = width - 20 - padding.right;
    [canvasView addSubview:self.customDislikeBtn];
    self.customDislikeBtn.frame = CGRectMake(dislikeX, y, 20, 20);
    [model registerContainer:self withClickableViews:@[self]];
}

- (void)layoutSubviews {
    self.nativeAd.mediation.canvasView.frame = self.bounds;
}

+ (CGFloat)cellHeightWithModel:(BUNativeAd *_Nonnull)model width:(CGFloat)width {
    if (!model || width <= 0) {
        return 0;
    }
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.data.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    BUImage *image = model.data.imageAry.firstObject;
    if (image.width <= 0) {
        return 0;
    }
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + titleSize.height + 5+ imageHeight + 10 + 20 + padding.bottom;
}

- (UIButton *)customDislikeBtn {
    if (!_customDislikeBtn) {
        _customDislikeBtn = [[UIButton alloc] init];
        [_customDislikeBtn setImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
        [_customDislikeBtn addTarget:self action:@selector(closeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customDislikeBtn;
}


@end
