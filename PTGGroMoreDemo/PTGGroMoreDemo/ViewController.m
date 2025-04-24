//
//  ViewController.m
//  PTGGroMoreDemo
//
//  Created by taoyongjiu on 2025/4/20.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "PTGSplashViewController.h"
#import "PTGBannerViewController.h"
#import "PTGInterstitialViewController.h"
#import "PTGGMNativeViewController.h"
#import "PTGGMNativeSelfRenderViewController.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray<NSString *> *items;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = @[
        @"开屏",
        @"信息流",
        @"自渲染信息流",
        @"banner",
        @"插屏",
    ];
    [self addChildViewsAndLayout];
}

- (void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                {
                    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                    NSLog(@"idfa = %@",idfa);
                }
                    break;
                default:
            }
        }];
    } else {
    }
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSourc -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    if (indexPath.row == 0) {
        viewController = [[PTGSplashViewController alloc] init];
    } else if(indexPath.row == 1) {
        viewController = [[PTGGMNativeViewController alloc] init];
    } else if(indexPath.row == 2) {
        viewController = [[PTGGMNativeSelfRenderViewController alloc] init];
    } else if(indexPath.row == 3) {
        viewController = [[PTGBannerViewController alloc] init];
    } else if(indexPath.row == 4) {
        viewController = [[PTGInterstitialViewController alloc] init];
    }
    viewController ? [self.navigationController pushViewController:viewController animated:YES] : nil;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

@end
