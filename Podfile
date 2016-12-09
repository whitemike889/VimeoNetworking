use_frameworks!

workspace 'VimeoNetworking'
project 'VimeoNetworking/VimeoNetworking.xcodeproj'
project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
    pod 'AFNetworking', '3.1.0'
end

target 'VimeoNetworking' do
	project 'VimeoNetworking/VimeoNetworking.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOS' do
	project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOSTests' do
	project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOSUITests' do
	project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

