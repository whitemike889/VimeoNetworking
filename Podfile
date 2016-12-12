use_frameworks!

workspace 'VimeoNetworking'
project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
    pod 'AFNetworking', '3.1.0'
    pod 'VimeoNetworking', :path => '../VimeoNetworking'
end

target 'VimeoNetworkingExample-iOS' do
	project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOSTests' do
	project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

