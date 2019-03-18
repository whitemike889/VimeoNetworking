//
//  Request+PasswordProtected.swift
//  VimeoNetworking
//

extension Request {
    
    /// Returns a new request for a password-protected item, such as a video or an album.
    ///
    /// - Parameters:
    ///   - uri: The URI for the item.
    ///   - password: The password for the item that will be sent to the server.
    /// - Returns: Returns a `Request` for a password-protected item.
    public static func passwordProtectedRequest(for uri: String, password: String) -> Request {
        let parameters = ["password": password]
        return Request(path: uri, parameters: parameters)
    }
}
