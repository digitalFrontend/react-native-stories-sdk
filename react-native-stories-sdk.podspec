require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-stories-sdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "11.0" }
  s.source       = { :git => "https://github.com/digitalFrontend/react-native-stories-sdk.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.resources = ["ios/Resources/CustomStoryCell.xib"]
  s.resource_bundles = {
  'react-native-stories-sdk' => ['react-native-stories-sdk/ios/Resources/*.xib']
  }
  s.dependency "React-Core"
  s.ios.vendored_frameworks = [
    'Frameworks/InAppStorySDK.xcframework'
  ]

end
