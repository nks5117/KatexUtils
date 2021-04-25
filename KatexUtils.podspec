#
# Be sure to run `pod lib lint KatexUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KatexUtils'
  s.version          = '0.2.2'
  s.summary          = 'KaTeX solution for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/nks5117/KatexUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nikesu' => '1026001096@qq.com' }
  s.source           = { :git => 'https://github.com/nks5117/KatexUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = "5.3"
  s.ios.deployment_target = '13.0'

  s.frameworks = 'UIKit', 'JavaScriptCore', 'WebKit'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files  = "KatexUtils/Classes/**/*.{h,m,swift}"
    ss.dependency 'KatexUtils/Resources'
  end

  s.subspec 'Resources' do |ss|
    ss.resource_bundle = {
      'KatexUtils' => [
        'KatexUtils/Assets/Resources/**/*',
        'KatexUtils/Assets/Assets.xcassets',
      ]
    }
  end

end
