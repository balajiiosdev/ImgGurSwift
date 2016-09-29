//
//  UserSession.swift
//  ImgGurSwift
//
//  Created by Balaji on 24/09/16.
//  Copyright © 2016 Synchronoss. All rights reserved.
//

import Foundation
import Alamofire

let AuthenticationDidCompleteNotification : String = "AuthenticationDidCompleteNotification"
///TODO:: refactor all methods in this struct.

struct UserSession {
    var accessToken: String?
    var accountId: Int?
    var accountUserName: String?
    var expiryTime: Int?
    var refreshToken: String?
    var tokenType: String?
    
    mutating func fetchAccessToken() {
        let urlString = baseURL+"/oauth2/token"
        guard let token = UserSession().userSession()?.refreshToken! else {
            print("Dont find refresh token. you need to login manually")
            return
        }
        refreshToken = token
        let parameters = ["refresh_token":token, "client_id": clientId, "client_secret": clientSecret, "grant_type":"refresh_token"]
        Alamofire.request(.POST, urlString.URLString, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if response.response?.statusCode == 200 {
                guard let JSON = response.result.value as? [String:AnyObject] else {
                    return
                }
                print("JSON: \(JSON)")
                //if let userSession = self.parseUserSession(JSON) {
                self.archiveAndStoreUserSession(JSON)
                NSNotificationCenter.defaultCenter().postNotificationName(AuthenticationDidCompleteNotification, object: nil)
                // }
            }
        }
    }
    
    
    
    func authenticateUser(code code: String) {
        let urlString = baseURL+("/oauth2/token")
        let parameters = ["client_id":clientId, "client_secret":clientSecret,
                          "grant_type":"authorization_code", "code":code]
        Alamofire.request(.POST, urlString.URLString, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).validate().responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data?.length)     // server data
            print(response.result)   // result of response serialization
            if response.response?.statusCode == 200 {
                guard let JSON = response.result.value as? [String:AnyObject] else {
                    return
                }
                print("JSON: \(JSON)")
                //if let userSession = self.parseUserSession(JSON) {
                self.archiveAndStoreUserSession(JSON)
                NSNotificationCenter.defaultCenter().postNotificationName(AuthenticationDidCompleteNotification, object: nil)
                // }
            }
        }
    }
}


extension UserSession : CustomDebugStringConvertible {
    
    var debugDescription: String {
        var description = ""
        if let userName = self.accountUserName {
            description += "accountUserName: "+userName
        }
        if let accessToken = self.accessToken {
            description += "\naccessToken: "+accessToken
        }
        if let accountID = self.accountId {
            description += "\naccountId: \(accountID)"
        }
        if let refreshToken = self.refreshToken {
            description += "\nrefreshToken: "+refreshToken
        }
        if let expiryTime = self.expiryTime {
            description += "\nexpiryTime: \(expiryTime)"
        }
        if let tokenType = self.tokenType {
            description += "\ntokenType: "+tokenType
        }
        return description
    }
}

extension UserSession {
    func archiveAndStoreUserSession(JSON :[String: AnyObject]) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(JSON)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: kUserSessionKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func userSession() -> UserSession? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(kUserSessionKey) as? NSData {
            if let JSON = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String : AnyObject] {
                if let session = parseUserSession(JSON) {
                    return session
                }
            }
            return nil;
        }
        return nil
    }
}

func parseUserSession(json: Dictionary<String,AnyObject>) -> UserSession? {
    var session = UserSession()
    guard let accessToken = json["access_token"] as? String else {
        return nil
    }
    session.accessToken = accessToken
    guard let accountID = json["account_id"] as? Int else {
        return nil
    }
    session.accountId = accountID
    if let userName = json["account_username"] as? String {
        session.accountUserName = userName
    }
    guard let expiryTime = json["expires_in"] as? Int else {
        return nil
    }
    session.expiryTime = expiryTime
    guard let refreshToken = json["refresh_token"] as? String else {
        return nil
    }
    session.refreshToken = refreshToken
    guard let tokenType = json["token_type"] as? String else {
        return nil
    }
    session.tokenType = tokenType
    return session
}