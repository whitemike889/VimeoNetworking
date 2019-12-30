//
//  AccountStore.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/24/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// `AccountStore` handles saving and loading authenticated accounts securely using the keychain
final class AccountStore {
    /// `AccountType` categorizes an account based on its level of access
    enum AccountType {
        /// Client credentials accounts can access only public resources
        case clientCredentials
        
        /// User accounts have an authenticated user and can act on the user's behalf
        case user
        
        func keychainKey() -> String {
            switch self {
            case .clientCredentials:
                
                return "ClientCredentialsAccountKey"
                
            case .user:
                
                return "UserAccountKey"
            }
        }
    }
    
    // MARK: -
    
    private struct Constants {
        static let ErrorDomain = "AccountStoreErrorDomain"
    }
    
    // MARK: -
    
    private let keychainStore: KeychainStore
    
    // MARK: -
    
    /**
     Create a new account store
     
     - parameter configuration: your application's configuration
     
     - returns: an initialized `AccountStore`
     */
    init(configuration: AppConfiguration) {
        self.keychainStore = KeychainStore(service: configuration.keychainService, accessGroup: configuration.keychainAccessGroup)
    }
    
    // MARK: -
    
    /**
     Save an account
     
     - parameter account: the account to save
     - parameter type:    the type of the account
     
     - throws: an error if the data could not be saved
     */
    func save(_ account: Account, ofType type: AccountType) throws {
        let data = try JSONEncoder().encode(account) as NSData
        try self.keychainStore.set(data: data, forKey: type.keychainKey())
    }
    
    /**
     Load an account
     
     - parameter type: type of account requested
     
     - throws: an error if data could not be loaded
     
     - returns: an account of the specified type, if one was found
     */
    func loadAccount(ofType type: AccountType) throws -> Account? {
        do {
            guard let data = try self.keychainStore.data(for: type.keychainKey())
            else {
                return nil
            }
            return try JSONDecoder().decode(Account.self, from: data)
        }
        catch let error {
            _ = try? self.removeAccount(ofType: type)
            
            throw error
        }
    }
    
    /**
     Removes a saved account
     
     - parameter type: type of account to remove
     
     - throws: an error if the data exists but could not be removed
     */
    func removeAccount(ofType type: AccountType) throws {
        try self.keychainStore.deleteData(for: type.keychainKey())
    }
}
