#
# Be sure to run `pod lib lint DSZKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DSZKit"
  s.version          = "0.1.0"
  s.summary          = "常用工具包"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                        核心代码库
                       DESC

  s.homepage         = "https://github.com/DSZ911226/DSZKit.git"
  s.license          = 'MIT'
  s.author           = { "邓深圳" => "344378745.com" }
  s.source           = { :git => "https://github.com/DSZ911226/DSZKit.git", :tag => s.version.to_s }

  s.platform         = :ios, '7.0'
  s.requires_arc     = true

  s.default_subspec = ['Core', 'Base', 'Tools']

  s.subspec 'Core' do |sp|
  sp.source_files     = "DSZKit/**/*"
  sp.public_header_files = 'DSZKit/**/*.h'
  sp.frameworks        = 'UIKit'
  end

  s.subspec 'Base' do |t|
  t.source_files = "DSZBase/*.{h,m}"
  t.resource = 'DSZBase/DSZBase.bundle'
  t.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.6'
  t.dependency 'MJRefresh'
  t.dependency 'MJExtension'
  t.dependency 'Masonry'
  t.dependency 'SVProgressHUD'
  t.dependency 'ReactiveObjC', '~> 3.0.0'
  t.dependency 'AFNetworking', '~> 3.0.4'
  t.dependency 'DSZKit/Core'
  end

  s.subspec 'Tools' do |t|
  t.source_files = "DSZTools/*.{h,m}"
  t.dependency 'SDWebImage'
  end

  s.subspec 'QRcode' do |t|
  t.resource = 'QRcode/QRcode.bundle'
  t.source_files = "QRcode/*.{h,m}"
  t.dependency 'ZXingObjC'
  end





end
