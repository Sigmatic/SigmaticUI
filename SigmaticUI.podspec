Pod::Spec.new do |s|
  s.name     = 'SigmaticUI'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Coaoa UI Platform and Utilities.'
  s.homepage = 'https://github.com/Sigmatic/SigmaticUI'
  s.authors  = { 'Hisham Alabri' => 'hisham@alabri.co' }
  s.source   = { :git => 'https://github.com/Sigmatic/SigmaticUI.git', :tag => s.version, :submodules => true }
  s.requires_arc = true

  s.ios.deployment_target = '6.0'

  s.public_header_files = 'SigmaticUI/*.h'
  s.source_files = 'SigmaticUI/SigmaticUI.h'

  s.subspec 'Helper' do |ss|
    ss.source_files = 'SigmaticUI/Helper/*.{h,m}'
  end

  s.subspec 'UIView' do |ss|
 	ss.dependency 'SigmaticUI/Helper'
    ss.source_files = 'SigmaticUI/UIView/*.{h,m}'
  end

  s.subspec 'UIViewControllerEvents' do |ss|
    ss.dependency 'SigmaticUI/Helper'
    ss.source_files = 'SigmaticUI/UIViewControllerEvents/*.{h,m}'
  end

end