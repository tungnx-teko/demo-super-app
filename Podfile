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
  pod 'Terra'
  pod 'TripiFlightConnector', '1.0.4-dev'
  pod 'TrackingBridge', '~> 0.0.1'
  
end
