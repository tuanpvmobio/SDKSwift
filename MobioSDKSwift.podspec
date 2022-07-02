
Pod::Spec.new do |spec|


  spec.name         = "MobioSDKSwift"
  spec.version      = "0.0.1"
  spec.summary      = "This is my CocoaPod of MobioSDKSwift."

  spec.description  = <<-DESC
                        This Cocoa pod help you tracking your app
                   DESC

  spec.homepage     = "https://github.com/tuanpvmobio/SDKSwift.git"


  spec.license      = "MIT"


  spec.author             = { "tuanpv" => "tuanpv@mobio.io" }

  spec.ios.deployment_target = "13.0"

  spec.swift_version = "5.0"


  spec.source       = { :git => "https://github.com/tuanpvmobio/SDKSwift.git", :tag => "#{spec.version}" }


  spec.source_files = "Source/**/**/*.{swift,xib,xcdatamodeld}"
  spec.resources = ['*.{xib}']
  spec.resources = 'Source/CoreData/DataBase/*.xcdatamodeld'

end
