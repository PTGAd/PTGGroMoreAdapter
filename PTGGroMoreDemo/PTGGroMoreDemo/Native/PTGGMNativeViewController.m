//
//  PTGGMNativeViewController.m
//  PTGGroMoreDemo
//
//  Created by yongjiu on 2025/4/21.
//

#import "PTGGMNativeViewController.h"
#import <Masonry/Masonry.h>

@interface PTGGMNativeViewController ()<BUNativeExpressAdViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)BUNativeExpressAdManager *adManager;
@property(nonatomic,strong)NSMutableArray<BUNativeExpressAdView *> *ads;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PTGGMNativeViewController

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

- (void)showAd:(UIButton *)sender { }

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(UITableViewCell.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[cell.contentView viewWithTag:100002] removeFromSuperview];
    BUNativeExpressAdView *ad = self.ads[indexPath.row];
    ad.tag = 100002;
    [cell.contentView addSubview:ad];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.ads[indexPath.row].bounds.size.height;
}

/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
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
}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"信息流渲染成功");
    [self.ads addObject:nativeExpressAdView];
    [self.tableView reloadData];
}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    NSLog(@"信息流渲染失败 error =%@",error);
    
}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"信息流展示成功");
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
    [self.ads removeObject:nativeExpressAdView];
    [self.tableView reloadData];
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


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}
@end
