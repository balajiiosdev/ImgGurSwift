//
//  APIManager.swift
//  ImgGurSwift
//
//  Created by Balaji on 24/09/16.
//  Copyright © 2016 Synchronoss. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let clientId = "ffe85bfd11764a9"
let clientSecret = "a2ca776cedfff63392edb0eb1db11b874c6621f7"

// end points
let baseURL = "https://api.imgur.com"
let baseURLWithVersion = "https://api.imgur.com/3"
let kUserSessionKey = "user_session"

extension Bool {
    var stringValue :String {
        switch self {
        case true:
            return "true"
        case false:
            return "false"
        }
    }
}

class APIManager {
    static let sharedInstance = APIManager()
    private init() { }
    
    func authorizeApp() {
        let urlString = "\(baseURL)/oauth2/authorize?client_id=\(clientId)&response_type=code&state=app_active"
        let url = NSURL(string: urlString)
        UIApplication.sharedApplication().openURL(url!)
    }
}