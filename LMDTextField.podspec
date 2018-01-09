Pod::Spec.new do |s|
  s.name             = 'LMDTextField'
  s.version          = '0.3'
  s.summary          = 'Simple TextField with a floating placeholder.'

  s.description      = <<-DESC
LMDTextField is a simple, clean TextField with a floating placeholder.
                       DESC

  s.homepage         = 'https://github.com/lemonade-hq/LMDTextField'
  # s.screenshots     = 'https://github.com/lemonade-hq/LMDTextField/Screenshots/screenshot1'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'talthent' => 'talthent@gmail.com' }
  s.source           = { :git => 'https://github.com/lemonade-hq/LMDTextField.git', :branch => s.version, :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'LMDTextField/*'
  
end
