//
//  PTGGMNativeViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGGMNativeSelfRenderViewController.h"
#import <Masonry/Masonry.h>
#import "PTGGMNativeSelfRenderCell.h"

@interface PTGGMNativeSelfRenderViewController ()<BUNativeAdsManagerDelegate,UITableViewDataSource,UITableViewDelegate,PTGGMNativeSelfRenderDislikeDelgate,BUMNativeAdDelegate>

@property(nonatomic,strong)BUNativeAdsManager* adManager;
@property(nonatomic,strong)NSMutableArray<BUNativeAd *> *ads;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PTGGMNativeSelfRenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAdButton.hidden = YES;
    self.ads = [NSMutableArray new];
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    [self.view insertSubview:self.tableView atIndex:0];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadAd:(UIButton *)sender {
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

- (void)showAd:(UIButton *)sender { }

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(PTGGMNativeSelfRenderCell.class);
    PTGGMNativeSelfRenderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BUNativeAd *ad = self.ads[indexPath.row];
    cell.delegate = self;
    [cell refreshUIWithModel:ad];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PTGGMNativeSelfRenderCell cellHeightWithModel:self.ads[indexPath.row] width:UIScreen.mainScreen.bounds.size.width];
}

#pragma mark - PTGGMNativeSelfRenderDislikeDelgate -
- (void)feedCustomDislike:(PTGGMNativeSelfRenderCell *)cell withNativeAd:(BUNativeAd *)nativeAd {
    NSMutableArray *dataSources = [self.ads mutableCopy];
    [dataSources removeObject:nativeAd];
    self.ads = [[dataSources copy] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - BUNativeAdsManagerDelegate -
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    /// 穿山甲没有自渲染权限 但是如果其他消耗方价格低的情况下 ，穿山甲会竞胜，返回空数组，媒体需要判断
    if (nativeAdDataArray.count == 0) {
        return;
    }
    NSLog(@"信息流加载成功");
    [nativeAdDataArray enumerateObjectsUsingBlock:^(BUNativeAd * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.rootViewController = self;
        obj.delegate = self;
        [obj render];
    }];
    [self.ads addObjectsFromArray:nativeAdDataArray];
    [self.tableView reloadData];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    NSLog(@"信息流加载失败 error = %@",error);
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


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:PTGGMNativeSelfRenderCell.class forCellReuseIdentifier:NSStringFromClass(PTGGMNativeSelfRenderCell.class)];
    }
    return _tableView;
}

@end
