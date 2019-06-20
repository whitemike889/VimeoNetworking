use_frameworks!

workspace 'VimeoNetworking'
project 'VimeoNetworking.xcodeproj'

def shared_pods
    pod 'AFNetworking', '3.1.0'
    pod 'SwiftLint', '0.25.1'    
end

target 'VimeoNetworking-iOS' do
    platform :ios, '9.0'
    shared_pods

    target 'VimeoNetworking-iOSTests' do
        pod 'OHHTTPStubs/Swift', '6.0.0'
    end
end

target 'VimeoNetworking-tvOS' do
    platform :tvos, '9.0'
    shared_pods

    target 'VimeoNetworking-tvOSTests' do
        pod 'OHHTTPStubs/Swift', '6.0.0'
    end
end

target 'VimeoNetworking-macOS' do
    platform :macos, '10.11'
    shared_pods

    target 'VimeoNetworking-macOSTests' do
        pod 'OHHTTPStubs/Swift', '6.0.0'
    end
end
