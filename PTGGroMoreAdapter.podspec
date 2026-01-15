Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "PTGGroMoreAdapter"
  spec.version      = "2.3.0.0"
  spec.summary      = "GroMore 平台 Fancy 广告适配器"


  spec.description  = <<-DESC
    PTGAdFramework provides Union ADs which include native、banner、feed、splash、RewardVideo etc.
  DESC

  spec.homepage     = "https://github.com/PTGAd/PTGGroMoreAdapter"

  spec.license      = { :type => "MIT" }


  spec.author             = { "fancy" => "ptg_all@fancydigital.com.cn" }

  spec.source       = { :git => "https://github.com/PTGAd/PTGGroMoreAdapter.git", :tag => "#{spec.version }" }


  spec.platform     = :ios, "15.0"
  spec.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate', 'CoreGraphics', 'Security'
  spec.libraries = 'c++', 'resolv', 'z', 'sqlite3'
  spec.vendored_frameworks =  'Framework/PTGGroMoreAdapter.framework'
  spec.static_framework = true

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
  }

  spec.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
  }

  spec.dependency 'PTGAdFramework'
  spec.dependency 'Ads-CN-Beta/BUAdSDK'
  spec.dependency 'Ads-CN-Beta/CSJMediation'

end
