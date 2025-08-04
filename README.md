#GroMore平台，Fancy广告适配器

## 导入 SDK
使用CocoaPods导入SDK

```shell
pod 'PTGAdFramework', '2.2.80'
pod 'PTGGroMoreAdapter','2.2.80.0'            
pod 'Ads-CN', '~> 6.9.1.2', :subspecs => ['CSJMediation']
```

## 适配器相关
需要在GroMore后台添加自定义广告平台

### 初始化适配器
PTGGMConfig
需要在网络配置中填写AppId AppKey
   
### 开屏
PTGGMSplashAdapter               开屏

### 信息流
PTGGMNativeAdapter               信息流
信息流 支持自渲染和模板渲染，在GroMore后台添加广告位下的代码位时，选择渲染类型
自渲染广告选择 开发者自渲染 
模板广告 默认

### 插屏
PTGGMInterstitialAdapter         插屏

### 横幅
PTGGMBannerAdapter               banner
