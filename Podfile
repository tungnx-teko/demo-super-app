# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/teko-vn/Specs-ios'

$distribution_frameworks = [
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
  "Toast-Swift"
]

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if $distribution_frameworks.include?(target.name)
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
  end
end
      
#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#
#      # delete CODE_SIGNING_ALLOWED && CODE_SIGNING_REQUIRED
#      config.build_settings.delete('CODE_SIGNING_ALLOWED')
#      config.build_settings.delete('CODE_SIGNING_REQUIRED')
#
#      # set valid architecture
#      config.build_settings['VALID_ARCHS'] = 'arm64 armv7 armv7s x86_64'
#
#      # build active architecture only (Debug build all)
#      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
#
#      config.build_settings['ENABLE_BITCODE'] = 'YES'
#
##      if $distribution_frameworks.include?(target.name)
#        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
##      end
#
#      # Uncomment this line on Xcode 12
#      # config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#
#      if config.name == 'Release' || config.name == 'Pro' || config.name == 'Staging'
#        config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
#        else # Debug
#        config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
#      end
#
#      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
#      if config.name == 'Release' || config.name == 'Pro' || config.name == 'Staging'
#        cflags << '-fembed-bitcode'
#        else # Debug
#        cflags << '-fembed-bitcode-marker'
#      end
#      config.build_settings['OTHER_CFLAGS'] = cflags
#    end
#  end
#end

target 'DemoSuperApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DemoSuperApp
#  pod 'Hestia', '~> 2.2.2'
  pod 'Terra', '~> 2.3.0'
#  pod 'HestiaIOS', '2.2.0'
#  pod 'Janus', '2.3.2'
#  pod 'TripiFlightConnector', '1.0.4-dev'
  pod 'Kingfisher'
  pod 'TekCoreNetwork', '1.2.21'
  pod 'TripiFlightKit', '2.0.0-dev'
  pod 'TerraInstancesManager'
  pod 'TekCoreService', '~> 1.2.2'
  
  pod 'FacebookCore', '~> 0.9.0'
  pod 'FacebookLogin', '~> 0.9.0'
  pod 'FacebookShare', '~> 0.9.0'
  
  pod 'GoogleSignIn', '~> 5.0.2'
  pod 'SwiftyJSON', '~> 4.0'
  
  # VNSHOP
  pod 'Firebase/Performance'
  pod 'FirebasePlugin', :git => 'https://github.com/teko-vn/firebase-plugin-ios.git'
  
  pod 'Terra', '~> 2.3.0', :source => "https://github.com/teko-vn/Specs-ios.git"
  pod 'Minerva', '~> 2.4.1', :source => "https://github.com/teko-vn/Specs-ios.git"
  
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
  
  #  pod 'TekCoreUploader', '1.0.0', :source => "https://github.com/teko-vn/Specs-ios.git"
  
  pod 'TekoMediaPreview', :git => 'https://github.com/teko-vn/ios-media-preview.git'
  
  #ui
  pod 'UIColor_Hex_Swift', '~> 4.0.2'
  pod 'Toast-Swift', '~> 5.0.0'
  pod 'FittedSheets', '~> 1.4.5'
  pod "VPAttributedFormat", '~> 1.2.5'
  pod 'TTTAttributedLabel'
  pod 'DifferenceKit'
  pod 'SkeletonView', '~> 1.8.7'
  pod "BSImagePicker", '~> 3.3.1'
  
  #realm
  pod 'RealmSwift', '~> 3.18.0'
  
  #rx
  pod 'RxCocoa', '~> 5.1.0'
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxRelay', '~> 5.1.0'
  pod 'RxRealm', '~> 1.0.0'
  
  #google
  pod 'GooglePlaces', '~> 3.4.0'
  pod 'GoogleMaps', '~> 3.4.0'
  
  #decode
  pod 'JWTDecode', '~> 2.4'
  
  # tracker
  pod 'TekoTracker', :git => 'https://github.com/teko-vn/tracker-ios.git'
  pod 'TekoTracker/Ecommerce', :git => 'https://github.com/teko-vn/tracker-ios.git'

  
end
