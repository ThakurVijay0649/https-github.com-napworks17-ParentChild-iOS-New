//
//  Auth.swift
//  Parent App
//
//  Created by Nap Works on 26/01/23.
//

import Foundation

class Auth {
    static let shared = Auth()
    
    let userDefaults = UserDefaults.standard
    
    ///Method to save user in UserDefaults
    func saveUser(user: UserData){
        userDefaults.set(try? PropertyListEncoder().encode(user), forKey: Constants.USER_KEY)
    }
    
    func saveChild(child: ChildLoginData){
        userDefaults.set(try? PropertyListEncoder().encode(child), forKey: Constants.CHILD_KEY)
    }
    
    ///Method to save user auth token in UserDefaults
    func saveAccountType(accountType: String){
        userDefaults.setValue(accountType, forKey: Constants.ACCOUNT_TYPE_KEY)
    }
    
    ///Method to fetch user auth token from UserDefaults
    func getAccountType() -> String{
        if let accountType = userDefaults.object(forKey: Constants.ACCOUNT_TYPE_KEY) as? String {
            return accountType
        }
        else {
            return ""
        }
    }
    
    ///Method to remove user auth token from UserDefaults
    func removeAccountType() {
        userDefaults.removeObject(forKey: Constants.ACCOUNT_TYPE_KEY)
    }
    ///Method to remove user from UserDefaults
    func removeUser(){
        userDefaults.removeObject(forKey: Constants.USER_KEY)
    }
    func removeChild(){
        userDefaults.removeObject(forKey: Constants.CHILD_KEY)
    }
    
    ///Method to check whether the user is logged in or not
  
}
