Pod::Spec.new do |s|

  s.name         = "VimeoNetworking"
  s.version      = "0.0.1"
  s.summary      = "Library for interacting with the Vimeo API"
  s.description  = <<-DESC
                      An iOS/tvOS library for interacting with the Vimeo API.
                   DESC
  s.homepage     = "https://github.com/vimeo/VimeoNetworking"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.authors            = { "Alfie Hanssen" => "alfiehanssen@gmail.com",
                            "Rob Huebner" => "robh@vimeo.com",
                            "Gavin King" => "gavin@vimeo.com",
                            "Nicole Lehrer" => "nicole@vimeo.com"}
  s.social_media_url   = "http://twitter.com/vimeo"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/vimeo/VimeoNetworking", :tag => s.version.to_s }

  s.source_files  = "VimeoNetworking/VimeoNetworking"

  # s.exclude_files = "Classes/Exclude"
  # s.resources = "Resources/*.png"

  s.frameworks = ["Foundation"]

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.dependency 'VIMObjectMapper'
  s.dependency 'AFNetworking'
end
