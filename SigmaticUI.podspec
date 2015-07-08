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

  s.public_header_files = 'SigmaticUI/Classes/**/*.h'
  s.source_files = 'SigmaticUI/Classes/**/*.{h,m}', 'SigmaticUI/Classes/SigmaticUI.h'

  s.dependency 'SigmaticOC', '~> 1.0'

end