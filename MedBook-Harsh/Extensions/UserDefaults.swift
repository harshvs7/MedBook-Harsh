//
//  UserDefaults.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 19/10/24.
//

import Foundation

struct DefaultValues {
    static let email = "email"
    static let password = "password"
    static let countryName = "countryName"
    static let loggedIn = "loggedIn"
    static let bookmarkedBooks = "bookmarkedBooks"
}

//A  class to access the userDefaults with modularity and at one place
class AppDefaults {
    static let shared = AppDefaults()
    private var userDefaults = UserDefaults.standard
    
    var email: String? {
        get {
            return userDefaults.string(forKey: DefaultValues.email)
        }
        set {
            userDefaults.setValue(newValue, forKey: DefaultValues.email)
            userDefaults.synchronize()
        }
    }
    
    var password: String? {
        get {
            return userDefaults.string(forKey: DefaultValues.password)
        }
        set {
            userDefaults.setValue(newValue, forKey: DefaultValues.password)
            userDefaults.synchronize()
        }
    }
    
    var countryName: String? {
        get {
            return userDefaults.string(forKey: DefaultValues.countryName)
        }
        set {
            userDefaults.setValue(newValue, forKey: DefaultValues.countryName)
            userDefaults.synchronize()
        }
    }
    
    var loggedIn: Bool? {
        get {
            return userDefaults.bool(forKey: DefaultValues.loggedIn)
        }
        set {
            userDefaults.setValue(newValue, forKey: DefaultValues.loggedIn)
            userDefaults.synchronize()
        }
    }
    
    var bookmarkedBooks: [Book]? {
        get {
            guard let savedData = userDefaults.data(forKey: DefaultValues.bookmarkedBooks) else {
                return []
            }
            
            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([Book].self, from: savedData)
                return books
            } catch {
                print("Error decoding bookmarked books: \(error)")
                return []
            }
        }
        set {
            if let newBooks = newValue {
                do {
                    let encoder = JSONEncoder()
                    let encodedData = try encoder.encode(newBooks)
                    userDefaults.setValue(encodedData, forKey: DefaultValues.bookmarkedBooks)
                } catch {
                    print("Error encoding bookmarked books: \(error)")
                }
            } else {
                userDefaults.removeObject(forKey: DefaultValues.bookmarkedBooks)
            }
        }
    }

    
    func logout() {
        userDefaults.setValue(false, forKey: DefaultValues.loggedIn)
        userDefaults.setValue("", forKey: DefaultValues.email)
        userDefaults.setValue("", forKey: DefaultValues.countryName)
        userDefaults.setValue("", forKey: DefaultValues.password)
        userDefaults.synchronize()
    }
    
}
