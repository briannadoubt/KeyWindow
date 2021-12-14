#
# Be sure to run `pod lib lint KeyWindow.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'KeyWindow'
  s.version          = '1.0.1'
  s.summary          = 'A universal way to get the window size in SwiftUI'

  s.description      = <<-DESC
Simply import KeyWindow and call `Text("Meow").keyWindowSafeAreaFrame`
                       DESC

  s.homepage         = 'https://github.com/briannadoubt/KeyWindow'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Brianna Doubt' => 'bri@briannadoubt.com' }
  s.source           = { :git => 'https://github.com/briannadoubt/KeyWindow.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/briannadoubt'

  s.swift_versions = '5.5'
  s.ios.deployment_target = '14.0'

  s.source_files = 'Sources/**/*'
  
  s.frameworks = 'SwiftUI'
  
end
