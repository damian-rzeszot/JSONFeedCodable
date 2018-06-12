
Pod::Spec.new do |s|
  s.name             = 'JSONFeed'
  s.version          = '1.0.0'

  s.summary          = 'This is short description of JSONFeed.'

  s.homepage         = 'https://github.com/damian-rzeszot/JSONFeed'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Damian Rzeszot' => 'damian.rzeszot@gmail.com' }
  s.source           = { :git => 'https://github.com/damian-rzeszot/JSONFeed.git', :tag => s.version.to_s }

  s.swift_version = '4.0'
  s.ios.deployment_target = '10.0'
  s.source_files = 'JSONFeed/*.swift'
  s.frameworks = 'Foundation'
end
