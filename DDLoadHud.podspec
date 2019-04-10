Pod::Spec.new do |s|
s.name        = 'DDLoadHud'
s.version     = '0.1.1'
s.authors     = { 'davis' => 'cuirhong@126.com' }
s.homepage    = 'https://github.com/cuirhong/DDLoadHud'
s.summary     = 'a load hud for wechat video.'
s.source      = { :git => 'https://github.com/cuirhong/DDLoadHud.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '9.0'
s.requires_arc = true
s.source_files = 'Source/**/*.swift'

s.ios.deployment_target = '7.0'
end
