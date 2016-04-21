use_frameworks!

workspace 'VimeoNetworking'
xcodeproj 'VimeoNetworking/VimeoNetworking.xcodeproj'
xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
    pod 'VIMObjectMapper'
    pod 'AFNetworking'
end

target 'VimeoNetworking' do
	xcodeproj 'VimeoNetworking/VimeoNetworking.xcodeproj'
	shared_pods
end

target 'VimeoNetworkingExample-iOS' do
	xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'
	shared_pods
end

# target 'VimeoNetworkingExample-iOSTests' do
# 	shared_pods
# end

# target 'VimeoNetworkingExample-iOSUITests' do
# 	shared_pods
# end

