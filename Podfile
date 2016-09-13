use_frameworks!

workspace 'VimeoNetworking'
xcodeproj 'VimeoNetworking/VimeoNetworking.xcodeproj'
xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
    pod 'AFNetworking', '2.6.3'
end

target 'VimeoNetworking' do
	xcodeproj 'VimeoNetworking/VimeoNetworking.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOS' do
	xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOSTests' do
	xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOSUITests' do
	xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

