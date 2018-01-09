#
# Be sure to run `pod lib lint LMDTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LMDTextField'
  s.version          = '0.2'
  s.summary          = 'Simple TextField with a floating placeholder.'

  s.description      = <<-DESC
LMDTextField is a simple, clean TextField with a floating placeholder.
                       DESC

  s.homepage         = 'https://github.com/lemonade-hq/LMDTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'talthent' => 'talthent@gmail.com' }
  s.source           = { :git => 'https://github.com/lemonade-hq/LMDTextField.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'LMDTextField/*'
  
end
