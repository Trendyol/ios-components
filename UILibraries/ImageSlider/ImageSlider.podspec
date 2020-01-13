Pod::Spec.new do |spec|

    spec.platform     = :ios
    spec.ios.deployment_target = '11.0'
    spec.name         = "ImageSlider"
    spec.summary      = "ImageSlider is a custom view to show array of images in carousel form"
    spec.version      = "0.0.4"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author       = { "Emre Ergün" => "emre.ergun@trendyol.com" }
    spec.homepage     = "https://www.trendyol.com"
    spec.source       = { :git => "https://github.com/Trendyol/ios-components.git", :tag => "#{spec.version}" }
    spec.source_files  = "ImageSlider/**/*.swift"
    spec.swift_version = ['5.0', '5.1']
  
  end
  