Pod::Spec.new do |spec|

    spec.platform     = :ios
    spec.ios.deployment_target = '11.0'
    spec.name         = "TYContinuousPagingView"
    spec.summary      = "Preparing.."
    spec.version      = "0.0.7"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.authors      = "Emre Ergün"
    spec.homepage     = "https://www.trendyol.com"
    spec.requires_arc = true

    spec.source          = {
      :git => 'https://github.com/Trendyol/ios-components.git',
      :tag => 'ContinuousPagingView-' + spec.version.to_s
    }

    spec.source_files  = "UILibraries/ContinuousPagingView/ContinuousPagingView/Classes/**/*.swift"
    spec.swift_version = ['4.2', '5.0', '5.1']
  
  end
  