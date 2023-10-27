# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def install_pods
  use_frameworks!
  inhibit_all_warnings!

  pod 'Google-Mobile-Ads-SDK'
end

target 'CharalarmDevelop' do
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

# エラーを消すために IPHONEOS_DEPLOYMENT_TARGET を11.0に設定
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
