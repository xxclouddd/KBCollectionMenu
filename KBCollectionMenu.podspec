#
#  Be sure to run `pod spec lint KBFormSheetController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KBCollectionMenu"
  s.version      = "0.0.2"
  s.summary      = "KBCollectionMenu."
  s.author       = {"xiaoxiong" => "821859554@qq.com"}
  s.description  = <<-DESC
                    This is KBCollectionMenu.
                   DESC

  s.homepage     = "ssh://git@xxx/xxx:2020/iOS/KBCollectionMenu.git"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "ssh://git@xxx/xxx:2020/iOS/KBCollectionMenu.git", :tag => s.version.to_s }

  s.source_files  = "KBCollectionMenu/CollectionMenu/**/*.{h,m}"
  s.resource = "KBCollectionMenu/Assets.xcassets"

  #s.prefix_header_file = "KBNetworking/KBNetworking.pch"
  #s.frameworks = "CoreGraphics", "UIKit"
  s.requires_arc = true

  s.dependency "Masonry"

end
