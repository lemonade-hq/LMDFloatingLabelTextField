Pod::Spec.new do |s|
  s.name             = 'LMDFloatingLabelTextField'
  s.version          = '0.8'
  s.summary          = 'Simple TextField with a floating placeholder.'

  s.description      = <<-DESC
LMDFloatingLabelTextField is a simple, clean TextField with a floating placeholder.
                       DESC

  s.homepage         = 'https://github.com/lemonade-hq/LMDFloatingLabelTextField'
  # s.screenshots     = 'https://github.com/lemonade-hq/LMDTextField/Screenshots/screenshot1'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'talthent' => 'talthent@gmail.com' }
  s.source           = { :git => 'https://github.com/lemonade-hq/LMDFloatingLabelTextField.git', :branch => s.version, :tag => s.version.to_s }

  s.ios.deployment_target = '8.2'

  s.source_files = 'LMDFloatingLabelTextField/*'
  
end
