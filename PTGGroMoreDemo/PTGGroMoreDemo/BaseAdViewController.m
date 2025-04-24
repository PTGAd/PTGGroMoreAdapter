//
//  BaseAdViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "BaseAdViewController.h"
#import "YYCategories/YYCategories.h"

@interface BaseAdViewController ()


@end

@implementation BaseAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.statusLabel.frame = CGRectMake(100, UIScreen.mainScreen.bounds.size.height - 160, 175, 30);
    self.showAdButton.frame = CGRectMake(100, UIScreen.mainScreen.bounds.size.height - 120, 175, 30);
    self.loadAdButton.frame = CGRectMake(100, UIScreen.mainScreen.bounds.size.height - 80, 175, 30);
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.loadAdButton];
    [self.view addSubview:self.showAdButton];
}

- (void)showAd:(UIButton *)sender {
    
}

- (void)loadAd:(UIButton *)sender {
    
}


- (UIButton *)showAdButton {
    if (!_showAdButton) {
        _showAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showAdButton setTitle:@"展示广告" forState:UIControlStateNormal];
        [_showAdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showAdButton addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
        [_showAdButton setBackgroundImage:[UIImage imageWithColor:UIColor.grayColor size:CGSizeMake(175, 30)] forState:UIControlStateNormal];
    }
    return _showAdButton;
}

- (UIButton *)loadAdButton {
    if (!_loadAdButton) {
        _loadAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadAdButton setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadAdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loadAdButton addTarget:self action:@selector(loadAd:) forControlEvents:UIControlEventTouchUpInside];
        [_loadAdButton setBackgroundImage:[UIImage imageWithColor:UIColor.grayColor size:CGSizeMake(175, 30)] forState:UIControlStateNormal];
    }
    return _loadAdButton;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor blackColor];
    }
    return _statusLabel;
}
@end
