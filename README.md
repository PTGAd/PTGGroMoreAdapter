#GroMore平台，Fancy广告适配器

## 导入 SDK
使用CocoaPods导入SDK

```shell
pod 'PTGAdFramework', '>= 2.3.0'   # 2.2.94及以上版本
pod 'PTGGroMoreAdapter','2.3.0.0'            
pod 'Ads-CN-Beta', '7.4.0.0', :subspecs => ['BUAdSDK', 'CSJMediation']
```

## 使用适配器的媒体请注意：
在广告展示前，需调用穿山甲广告是否有效，只有当mediation.isReady为YES时，才展示广告。否则会造成广告展示失败，可能会造成线上展示数据存在差异从而引起媒体收益数据差异。

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

### 激励
PTGGMRewardedVideoAdapter
