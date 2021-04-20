Pod::Spec.new do |spec|

  spec.platform     = :ios
  spec.ios.deployment_target = '11.0'
  spec.name         = "TYPropertyWrapper"
  spec.summary      = "TYPropertyWrapper for iOS"
  spec.version      = "0.0.2"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Anıl Taşkıran" => "anil.taskiran@trendyol.com" }
  spec.homepage     = "https://www.trendyol.com"
  spec.requires_arc = true

  spec.source          = {
    :git => 'https://github.com/Trendyol/ios-components.git',
    :tag => 'TYPropertyWrapper-' + spec.version.to_s
  }

  spec.source_files  = "Utils/PropertyWrapper/PropertyWrapper/Classes/**/*.swift"
  spec.swift_version = ['4.2', '5.0', '5.1']

end