#
# Be sure to run `pod lib lint BUKDynamicPopView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BUKDynamicPopView"
  s.version          = "0.1.0"
  s.summary          = "Dynamic Pop View using UIKit Dynamics"
  s.description      = <<-DESC
                       Dynamic Pop View using UIKit Dynamics.
                       DESC
  s.homepage         = "https://github.com/iException/BXUIKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "hyice" => "hy_ice719@163.com" }
  s.source           = { :git => "https://github.com/iException/BUKDynamicPopView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/**/*'
end
