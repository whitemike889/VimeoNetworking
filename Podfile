use_frameworks!

workspace 'VimeoNetworking'
project 'VimeoNetworkingExample-iOS/VimeoNetworkingExample-iOS.xcodeproj'

def shared_pods
	pod 'SwiftLint', '0.25.1'
	pod 'VimeoNetworking', :path => '../VimeoNetworking'
end

target 'VimeoNetworkingExample-iOS' do
    platform :ios, '10.3'
    shared_pods

    target 'VimeoNetworkingExample-iOSTests' do
    	inherit! :search_paths
        pod 'OHHTTPStubs/Swift', '6.0.0'
	end
end

target 'VimeoNetworkingExample-tvOS' do
    platform :tvos, '10.0'
    shared_pods

    target 'VimeoNetworkingExample-tvOSTests' do
    	inherit! :search_paths
        pod 'OHHTTPStubs/Swift', '6.0.0'
	end
end
