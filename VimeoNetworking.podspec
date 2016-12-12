Pod::Spec.new do |s|

  s.name         = "VimeoNetworking"
  s.version      = "0.0.1"
  s.summary      = "Library for interacting with the Vimeo API"
  s.description  = <<-DESC
                      An iOS/tvOS library for interacting with the Vimeo API.
                   DESC
  s.homepage     = "https://github.com/vimeo/VimeoNetworking"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "Alfie Hanssen" => "alfiehanssen@gmail.com",
                           "Rob Huebner" => "robh@vimeo.com",
                           "Gavin King" => "gavin@vimeo.com",
                           "Nicole Lehrer" => "nicole@vimeo.com",
                           "Mike Westendorf" => "mikew@vimeo.com",
                           "Jason Hawkins" => "jasonh@vimeo.com",
                           "Jennifer Lim" => "jennifer@vimeo.com"}
  s.social_media_url   = "http://twitter.com/vimeo"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.requires_arc = true
  s.source = { 
    :git => "https://github.com/vimeo/VimeoNetworking.git", 
    :tag => s.version.to_s 
  }
  s.source_files  = "VimeoNetworking/VimeoNetworking/*.{h,m,swift,cer}"
  s.frameworks = ["Foundation"]

  # We should consider dropping this as a subspec until we have the basics working.
  # s.subspec 'Model' do |ss|
  #   ss.source_files = 'VimeoNetworking/VimeoNetworking/Models'
  #   ss.frameworks = 'Foundation', 'CoreGraphics', 'AVFoundation'
  # end

  s.dependency 'AFNetworking', '3.1.0'
end
