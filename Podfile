# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def install_pods
  use_frameworks!
  inhibit_all_warnings!

  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/RemoteConfig'
  pod 'Google-Mobile-Ads-SDK'
  pod 'SwiftLint'
  pod 'SDWebImageSwiftUI'
  pod 'KeychainAccess'
end

target 'CharalarmLocal' do
  install_pods
  
  target 'CharacterAlarmTests' do
    inherit! :search_paths
  end

  target 'CharacterAlarmUITests' do
    inherit! :search_paths
  end
end

target 'CharalarmStaging' do
  install_pods
end

target 'CharalarmProduction' do
  install_pods
end
