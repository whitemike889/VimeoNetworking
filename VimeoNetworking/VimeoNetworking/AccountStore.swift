//
//  AccountStore.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/24/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

final internal class AccountStore
{
    enum AccountType: String
    {
        case ClientCredentials
        case User
    }
    
    // MARK: - 
    
    private static let ErrorDomain = "AccountStoreErrorDomain"
    
    // MARK: - 
    
    private let dataStore: SecureDataStore
    
    // MARK: -
    
    init(configuration: AppConfiguration)
    {
        self.dataStore = KeychainStore(service: configuration.keychainService, accessGroup: configuration.keychainAccessGroup)
    }
    
    // MARK: -
    
    func saveAccount(account: VIMAccount, type: AccountType) throws
    {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(account)
        archiver.finishEncoding()
        
        try self.dataStore.setData(data, forKey: type.rawValue)
    }
    
    func loadAccount(type: AccountType) throws -> VIMAccount?
    {
        do
        {
            guard let data = try self.dataStore.dataForKey(type.rawValue)
            else
            {
                return nil
            }
            
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            var decodedAccount: VIMAccount? = nil
            try ExceptionCatcher.doUnsafe
            {
                decodedAccount = unarchiver.decodeObject() as? VIMAccount
            }
            
            guard let account = decodedAccount
            else
            {
                let description = "Received corrupted VIMAccount data from keychain"
                let error = NSError(domain: self.dynamicType.ErrorDomain, code: LocalErrorCode.AccountCorrupted.rawValue, userInfo: [NSLocalizedDescriptionKey: description])
                
                throw error
            }
            
            if let userJSON = account.userJSON as? VimeoClient.ResponseDictionary
            {
                try account.user = VIMObjectMapper.mapObject(userJSON) as VIMUser
            }
            
            return account
        }
        catch let error
        {
            _ = try? self.removeAccount(type)
            
            throw error
        }
    }
    
    func removeAccount(type: AccountType) throws
    {
        try self.dataStore.deleteDataForKey(type.rawValue)
    }
}