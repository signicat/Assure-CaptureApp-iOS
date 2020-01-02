#
# Be sure to run `pod lib lint CaptureApp-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CaptureApp-iOS'
  s.version          = '0.1.0'
  s.summary          = 'Library to help capture photos of documents'
  s.description      = <<-DESC
This library aims to help iOS developers to integrate the ability to capture photo of documents and selfie more easily
                       DESC
  s.homepage         = 'https://github.com/signicat/Assure-CaptureApp-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tiago Mendes' => 'tiamen@signicat.com' }
  s.source           = { :git => 'https://github.com/signicat/Assure-CaptureApp-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'
  s.source_files = 'CaptureApp-iOS/Classes/**/*'
  s.resource_bundles = {
    'CaptureApp-iOS' => ['CaptureApp-iOS/Assets/*.png']
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'SnapKit', '~> 5.0.1'
end
