use_frameworks!

workspace 'VimeoNetworking'
project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
	pod 'AFNetworking', '3.1.0'
    pod 'VimeoNetworking', :path => '../VimeoNetworking'
end

target 'VimeoNetworkingExample-iOS' do
    shared_pods

    target 'VimeoNetworkingExample-iOSTests' do
    	inherit! :search_paths
	end
end

target 'VimeoNetworkingtvOS' do
	shared_pods
end
