import UIKit
import VimeoNetworking

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

class Request {}

class Response {}

enum VimeoNetworking {
    
    static func request(_ urlRequest: URLRequestConvertible) -> URLSessionDataTask? {
        return Session.default.request(urlRequest)
    }
}

class SessionDelegate: NSObject {}

extension SessionDelegate: URLSessionDelegate {}

class Session {
    
    static let `default` = Session()
    
    private let urlSession: URLSession
    
    init(
        configuration: URLSessionConfiguration = .default,
        delegate: SessionDelegate = SessionDelegate(),
        delegateCallbackQueue: OperationQueue = OperationQueue.main
    ) {
        self.urlSession = URLSession(
            configuration: configuration,
            delegate: delegate,
            delegateQueue: delegateCallbackQueue
        )
    }
    
    func request(_ urlRequest: URLRequestConvertible) -> URLSessionDataTask? {
        guard let urlRequest = try? urlRequest.asURLRequest() else { return nil }
        let task = self.urlSession.dataTask(with: urlRequest)
        task.resume()
        return task
    }
    
}
