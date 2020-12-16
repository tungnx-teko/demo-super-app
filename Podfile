# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs'
source 'https://github.com/teko-vn/Specs-ios'

$distribution_frameworks = [
  "Alamofire",
  "CryptoSwift",
  "FacebookCore",
  "FacebookLogin",
  "TekServiceInterfaces",
  "BSImagePicker",
  "DifferenceKit",
  "FittedSheets",
  "Kingfisher",
  "RealmSwift",
  "SkeletonView",
  "TekoMediaPreview",
  "TekoTracker",
  "Toast-Swift",
  "Moya",
  "RxRelay",
  "TripiCommon",
  "TripiFlightKit",
  "RxSwift",
  "RxCocoa"
]

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
#      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      if $distribution_frameworks.include?(target.name)
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
  end
end

target 'DemoSuperApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DemoSuperApp
  pod 'Alamofire'
  
  # Pods for integrating mini app
  pod 'Terra'
  pod 'TrackingBridge', '~> 0.0.1'
  
  # Mini apps
  pod 'TripiFlightConnector', '1.1.0-dev'
  pod 'VnshopSdk', '1.3.3-staging'
  
end
