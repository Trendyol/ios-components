Pod::Spec.new do |spec|

  spec.platform     = :ios
  spec.ios.deployment_target = '11.0'
  spec.name         = "TrendyolAPI"
  spec.summary      = "TrendyolAPI is a internal subframework of Trendyol iOS Projects."
  spec.version      = "1.0.1"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ahmet Keskin" => "ahmet.keskin@trendyol.com" }
  spec.homepage     = "https://www.trendyol.com"
  spec.dependency   'Alamofire', '5.0.0-rc.3'
  spec.source       = { :git => "https://github.com/Trendyol/ios-components.git", :tag => "#{spec.version}" }
  spec.source_files  = "API/API/*.swift"
  spec.swift_version = ['5.0', '5.1']
  spec.public_header_files = 'API/API/Resource/*.h'

end
