# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs'
$TekoSpecs = 'https://' + ENV['GITHUB_USER_TOKEN'] + '@github.com/teko-vn/Specs-ios.git'

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
  "RxCocoa",
  "ReachabilitySwift"
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

target 'SampleSDK' do
  use_frameworks!
  
  pod 'TerraInstancesManager'
end

target 'DemoSuperApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DemoSuperApp
  pod 'Alamofire', '5.3.0'
  pod 'TekCoreUploader', '1.0.1'
  
  # Pods for integrating mini app
  pod 'Firebase/Auth', '~> 7'
  pod 'FirebaseFirestore', '~> 7'
  pod 'Terra', :source => $TekoSpecs
  pod 'TrackingBridge', '~> 0.0.1'
  pod 'FirebasePlugin'
#  pod 'Minerva', '3.1.10', :source => $TekoSpecs
  
  pod 'Hestia', '~> 2.2.3'
  pod 'HestiaIOS', '~> 2.2.1'
  pod 'TekoSwiftGRPC'
  # Mini apps
#  pod 'TripiFlightConnector', '1.1.0-dev'
  pod 'VnshopSdk', '1.4.2-staging'
  
  pod 'FirebasePlugin', '~> 0.3.1'
  pod 'HestiaIOS'
  pod 'Terra', '~> 2.3.0'
  pod 'Minerva', '~> 2.5.0'
  pod 'Janus', '~> 2.3.4'
  pod 'TekUserService', '~> 2.2.0'
  pod 'TekTicketService', '~> 2.2.0'
  pod 'TekStnService', '~> 2.2.0'
  pod 'TekSearchService', '~> 2.2.0'
  pod 'TekPpmService', '~> 2.2.0'
  pod 'TekPolicyService', '~> 2.2.0'
  pod 'TekOrderService', '~> 2.2.0'
  pod 'TekLocationService', '~> 2.2.0'
  pod 'TekIdentityService', '~> 2.2.0'
  pod 'TekListingService', '~> 2.2.0'
  pod 'TekDiscoveryService', '~> 2.2.0'
  pod 'TekCrmService', '~> 2.2.0'
  pod 'TekCoreUploader', '~> 1.0.1'
  pod 'TekoMediaPreview', '~> 0.0.2'
  pod 'UIColor_Hex_Swift', '~> 4.0.2'
  pod 'Toast-Swift', '~> 5.0.0'
  pod 'FittedSheets', '~> 1.4.5'
  pod 'VPAttributedFormat', '~> 1.2.5'
  pod 'TTTAttributedLabel'
  pod 'DifferenceKit'
  pod 'SkeletonView', '~> 1.8.7'
  pod 'BSImagePicker', '~> 3.3.1'
  pod 'RealmSwift', '~> 10.5.0'
  pod 'RxCocoa', '~> 5.1.0'
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxRelay', '~> 5.1.0'
  pod 'RxRealm'
  pod 'GooglePlaces', '~> 3.4.0'
  pod 'GoogleMaps', '~> 3.4.0'
  pod 'JWTDecode', '~> 2.4'
  pod 'TekoTracker', '~> 0.4.1'
  
end
