#
# Be sure to run `pod lib lint MoyaHandyJSON.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MoyaHandyJSON'
  s.version          = '0.1.1'
  s.summary          = 'Moya extensions that allow the response to be decoded into objects using the HandyJSON.'

  s.description      = <<-DESC
  允许使用HandyJSON将Response解码为对象的Moya扩展。
  Moya extensions that allow the response to be decoded into objects using the HandyJSON.
                       DESC

  s.homepage         = 'https://github.com/zys-developer/MoyaHandyJSON'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zys-developer' => 'zys_dev@163.com' }
  s.source           = { :git => 'https://github.com/zys-developer/MoyaHandyJSON.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.default_subspec = "Core"
  s.swift_version = '5.0'
  
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/Core/*.swift"
    ss.dependency "Moya"
    ss.dependency "HandyJSON"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Sources/RxSwift/*.swift"
    ss.dependency "MoyaHandyJSON/Core"
    ss.dependency "RxSwift"
    ss.dependency "Moya/RxSwift"
  end
  
end
