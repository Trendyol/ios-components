Pod::Spec.new do |spec|

  spec.platform     = :ios
  spec.ios.deployment_target = '11.0'
  spec.name         = "TYLinkLabel"
  spec.summary      = "TYLinkLabel for iOS"
  spec.version      = "0.0.1"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Selin Ersev" => "selin.ersev@trendyol.com" }
  spec.homepage     = "https://www.trendyol.com"
  spec.requires_arc = true

  spec.source          = {
    :git => 'https://github.com/Trendyol/ios-components.git',
    :tag => 'TYLinkLabel-' + spec.version.to_s
  }

  spec.source_files  = "UILibraries/LinkLabel/LinkLabel/Classes/**/*.swift"
  spec.swift_version = ['4.2', '5.0', '5.1']

end