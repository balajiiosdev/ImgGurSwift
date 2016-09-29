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
    
    func fetchGallery(section: Section = .Hot,
                      sort: Sort = .Viral,
                      page :Int = 1,
                      window: Window = .Day,
                      showViral: Bool = false, completionHandler: (gallery: [GalleryImage]?)-> Void) {
        var urlString = baseURLWithVersion+"/gallery";
        urlString += "/\(section.rawValue)"
        urlString += "/\(sort.rawValue)"
        urlString += "/\(window.rawValue)"
        urlString += "/\(page)"
        urlString += "?showViral=\(showViral.stringValue)"
        
        guard let accessToken = UserSession().userSession()?.accessToken else {
            return completionHandler(gallery: nil)
        }
        let headerFields = ["Authorization" : "Bearer \(accessToken)"]
        Alamofire.request(.GET, urlString.URLString, parameters: nil, encoding: .JSON, headers: headerFields).validate().responseJSON(completionHandler: { (response) in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data?.length)     // server data
            print(response.result)   // result of response serialization
            if response.response?.statusCode == 200 {
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No valid JSON")
                    return completionHandler(gallery: nil)
                }
                //print("JSON: \(JSON)")
                
                guard let data = JSON["data"] as? [[String: AnyObject]] else {
                    print("'data' not found")
                    return completionHandler(gallery: nil)
                }
                
                let galleryList = self.parseGallery(data)
                completionHandler(gallery: galleryList)
            }
        })
    }
    
    func parseGallery(results: [[String: AnyObject]]) -> [GalleryImage] {
        var galleryList = [GalleryImage]()
        let pureImages = results.filter { (galleryDict) -> Bool in
            return galleryDict["is_album"]?.boolValue == false
        }
        for gallery in pureImages {
            let galleryImage = GalleryImage()
            if let id = gallery["id"] as? String {
                galleryImage.identifier = id
            }
            
            if let title = gallery["title"] as? String {
                galleryImage.title = title
            }
            
            if let description = gallery["description"] as? String {
                galleryImage.imageDescription = description
            }
            
            if let ups = gallery["ups"] as? Int {
                galleryImage.upVotes = ups
            }
            
            if let downs = gallery["downs"] as? Int {
                galleryImage.downVotes = downs
            }
            
            if let points = gallery["points"] as? Int {
                galleryImage.points = points
            }
            
            if let link = gallery["link"] as? String {
                galleryImage.link = link
            }
            
            if let type = gallery["type"] as? String {
                galleryImage.type = type
            }
            
            if let width = gallery["width"] as? Int {
                galleryImage.width = width
            }
            
            if let height = gallery["height"] as? Int {
                galleryImage.height = height
            }
            
            if let animated = gallery["animated"] {
                galleryImage.animated = animated as! Bool
            }
            galleryList.append(galleryImage)
        }
        return galleryList
    }

}