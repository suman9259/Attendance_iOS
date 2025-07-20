# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'Attendance' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Attendance
  pod 'GTMSessionFetcher', :modular_headers => true
  # arch -x86_64 pod update GTMSessionFetcher/Core

  pod 'SVProgressHUD'

  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'IQKeyboardManager'
  
  pod 'SwiftyJSON', '~> 4.0'
  pod 'ReachabilitySwift'
  pod 'AWSRekognition'
  pod 'AWSCognito'
#  pod 'InteriorAbsherCoreLibrary',
#       :git => 'https://github.com/InteriorAbsher/InteriorAbsherCoreLibrary.git',
#       :tag => '0.2.0'

pod 'InteriorAbsherCoreLibrary', :git => 'git@github.com:InteriorAbsher/InteriorAbsherCoreLibrary.git', :branch => '0.2.0'

  
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
end
