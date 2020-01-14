Pod::Spec.new do |spec|

    spec.platform     = :ios
    spec.ios.deployment_target = '11.0'
    spec.name         = "TYImageSlider"
    spec.summary      = "ImageSlider is a custom view to show array of images in carousel form"
    spec.version      = "0.0.7"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.authors      = "DSM Group Trendyol"
    spec.homepage     = "https://www.trendyol.com"
    spec.requires_arc = true
    spec.dependency   'SDWebImage'

    spec.source          = {
      :git => 'https://github.com/Trendyol/ios-components.git',
      :tag => 'ImageSlider-' + spec.version.to_s
    }

    spec.source_files  = "UILibraries/ImageSlider/ImageSlider/Classes/**/*.swift"
    spec.swift_version = ['4.2', '5.0', '5.1']
  
  end
  