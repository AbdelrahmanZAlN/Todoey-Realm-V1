# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Todoey-Realm-V1' do

  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
              end
          end
      end
  end
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!



  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Todoey-Realm-V1
  
   pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  target 'Todoey-Realm-V1Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Todoey-Realm-V1UITests' do
    # Pods for testing
  end

end
