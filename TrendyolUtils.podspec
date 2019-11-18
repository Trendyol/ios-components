Pod::Spec.new do |spec|

  spec.platform     = :ios
  spec.ios.deployment_target = '11.0'
  spec.name         = "TrendyolUtils"
  spec.summary      = "TrendyolUtils is a internal subframework of Trendyol iOS Projects."
  spec.version      = "1.0.0"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ahmet Keskin" => "ahmet.keskin@trendyol.com" }
  spec.homepage     = "https://www.trendyol.com"
  spec.dependency   'SDWebImage', '~> 5.0'
  spec.source       = { :git => "https://github.com/Trendyol/ios-components.git", :tag => "#{spec.version}" }
  spec.source_files  = "Utils/Utils/**/*.swift"
  spec.swift_version = ['5.0', '5.1']

end
