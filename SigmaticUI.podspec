Pod::Spec.new do |s|
  s.name     = 'SigmaticUI'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Take back control of your views and controllers'
  s.homepage = 'https://github.com/Sigmatic/SigmaticUI'
  s.authors  = { 'Hisham Alabri' => 'hisham@alabri.co' }
  s.source   = { :git => 'https://github.com/Sigmatic/SigmaticUI.git', :tag => s.version, :submodules => true }
  s.requires_arc = true

  s.ios.deployment_target = '6.0'

  s.dependency 'SigmaticOC', '~> 1.0'

  s.public_header_files = 'SigmaticUI/UIView/*.h', 'SigmaticUI/UIViewControllerEvents/*.h'
  s.source_files = 'SigmaticUI/SigmaticUI.h'

  s.subspec 'UIView' do |ss|
    ss.source_files = 'SigmaticUI/UIView/*.{h,m}'
  end

  s.subspec 'UIViewControllerEvents' do |ss|
    ss.source_files = 'SigmaticUI/UIViewControllerEvents/*.{h,m}'
  end

end