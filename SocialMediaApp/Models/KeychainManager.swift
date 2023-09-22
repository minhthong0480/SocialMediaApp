/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Ngo Chi Binh
  ID: s3938145
  Created  date: 15/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
 https://www.kodeco.com/11496196-how-to-secure-ios-user-data-keychain-services-and-biometrics-with-swiftui?fbclid=IwAR35T3MZxtLZNS-_hh_f2CWbzYxq18HanB_fTc9KZ35y2zkKvQaj1y-h44U
*/

//
//  KeychainServices.swift
//  SocialMediaApp
//
//  Created by Binh Ngo on 15/09/2023.
//

import Foundation
import SwiftUI

struct KeychainWrapperError: Error {
  var message: String?
  var type: KeychainErrorType

  enum KeychainErrorType {
    case badData
    case servicesError
    case itemNotFound
    case unableToConvertToString
  }

  init(status: OSStatus, type: KeychainErrorType) {
    self.type = type
    if let errorMessage = SecCopyErrorMessageString(status, nil) {
      self.message = String(errorMessage)
    } else {
      self.message = "Status Code: \(status)"
    }
  }

  init(type: KeychainErrorType) {
    self.type = type
  }

  init(message: String, type: KeychainErrorType) {
    self.message = message
    self.type = type
  }
}


class KeychainWrapper {

    
//    MARK: Store password in Keychain
    func storeRecentPassword(
        account: String,
        service: String,
        password: String
    ) throws {
        
//        MARK: Delete stored password if input password is empty
        if password.isEmpty {
            try deleteRecentPassword(account: account, service: service)
            return
        }
        
        // Convert password String to Data type
        guard let passwordData = password.data(using: .utf8) else {
            print("Error converting value to data. ")
            throw KeychainWrapperError(type: .badData)
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: passwordData
        ]
        
        // 1
        let status = SecItemAdd(query as CFDictionary, nil)
        // 2
        switch status {
        // 3
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try updateRecentPassword(
                account: account,
                service: service,
                password: password)
        // 4
        default:
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
//    MARK: Get password stored in Keychain
    func getRecentPassword(
        account: String,
        service: String
    ) throws -> String {
        let query: [String: Any] = [
            // 1
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            // 2
            kSecMatchLimit as String: kSecMatchLimitOne,
            // 3
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
        
        guard
            let existingItem = item as? [String: Any],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: .utf8)
            else {
                throw KeychainWrapperError(type: .unableToConvertToString)
            }
        return value
    }
    
//    MARK: Update password stored in keychain
    func updateRecentPassword(
        account: String,
        service: String,
        password: String
    ) throws {
        guard let passwordData = password.data(using: .utf8) else {
            print("Error converting value to data")
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(
                message: "Matching Item Not Found",
                type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
//    MARK: Delete recent password stored in keychain
    func deleteRecentPassword(
        account: String,
        service: String
    ) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
}
