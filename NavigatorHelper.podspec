#
# Be sure to run `pod lib lint NavigatorHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NavigatorHelper'
  s.version          = '0.1.0'
  s.summary          = '路由辅助工具类.'
  s.platform         = :ios, "10.0"
  s.swift_versions = ['4', '5']

  s.description      = '用来作为路由中间件的，处理一些无法及时处理路由的场景比如应用在后台或者一个特殊的业务场景中，需要稍后处理路由'

  s.homepage         = 'https://github.com/hlltd/NavigatorHelper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hlltd' => 'hllfj922@gmail.com' }
  s.source           = { :git => 'https://github.com/hlltd/NavigatorHelper.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'NavigatorHelper/Classes/**/*'
  
end
