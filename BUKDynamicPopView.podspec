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
  s.version          = "1.0.0"
  s.summary          = "UIView's Category, simply making any view into a pop view."
  s.description      = <<-DESC
                       UIView's Category, simply making any view into a pop view. You also
                       can custom the animation behavior(style and path) very easily.
                       DESC
  s.homepage         = "https://github.com/iException/BUKDynamicPopView"
  s.license          = 'MIT'
  s.author           = { "hyice" => "hy_ice719@163.com" }
  s.source           = { :git => "https://github.com/iException/BUKDynamicPopView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/**/*'
end
