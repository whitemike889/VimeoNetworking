# use_frameworks!

workspace 'VimeoNetworking'

xcodeproj 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
    pod 'VIMObjectMapper', '6.0.0'
    pod 'VIMNetworking/Model', '6.0.0'
    pod 'AFNetworking', '2.6.3'
end

target 'VimeoNetworkingExample-iOS' do
	shared_pods
end

target 'VimeoNetworkingExample-iOSTests' do
	shared_pods
end

target 'VimeoNetworkingExample-iOSUITests' do
	shared_pods
end

