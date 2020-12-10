# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/teko-vn/Specs-ios'

$distribution_frameworks = [
  "CryptoSwift",
  "FacebookCore",
  "FacebookLogin"
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
  
end
