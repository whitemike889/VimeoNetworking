use_frameworks!

xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

workspace 'VimeoNetworking'

def shared_pods
    pod 'VIMObjectMapper'
    pod 'AFNetworking'
end

target 'VimeoNetworkingExample-iOS' do
	shared_pods

	xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
end

target 'VimeoNetworkingExample-iOSTests' do
	shared_pods
end

target 'VimeoNetworkingExample-iOSUITests' do
	shared_pods
end

