//
//  Gallery.swift
//  ImgGurSwift
//
//  Created by Balaji on 27/09/16.
//  Copyright © 2016 Synchronoss. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum ImageFields : String {
    case Id = "id"
    case Title = "title"
    case Description = "description"
    case DateTime = "datetime"
    case TYPE = "type" // Coudn't use Type. Hence it is changed to TYPE
    case Animated = "animated"
    case Width = "width"
    case Height = "height"
    case Size = "size"
    case Views = "views"
    case BandWidth = "bandwidth"
    case DeleteHash = "deletehash"
    case Name = "name"
    case Section = "section"
    case Link = "link"
    case Gifv = "gifv"
    case Mp4 = "mp4"
    case Mp4Size = "mp4_size"
    case Looping = "looping"
    case Favorite = "favorite"
    case NSFW = "nsfw"
    case Vote = "vote"
    case InGallery = "in_gallery"
}

enum GalleryFields :String {
    case Id = "id"
    case Title = "title"
    case Description = "description"
    case DateTime = "datetime"
    case TYPE = "type" // Coudn't use Type. Hence it is changed to TYPE
    case Animated = "animated"
    case Width = "width"
    case Height = "height"
    case Size = "size"
    case Views = "views"
    case BandWidth = "bandwidth"
    case DeleteHash = "deletehash"
    case Name = "name"
    case Section = "section"
    case Link = "link"
    case Gifv = "gifv"
    case Mp4 = "mp4"
    case Mp4Size = "mp4_size"
    case Looping = "looping"
    case Favorite = "favorite"
    case NSFW = "nsfw"
    case Vote = "vote"
    case CommentCount = "comment_count"
    case Topic = "topic"
    case TopicId = "topic_id"
    case AccountUrl = "account_url"
    case AccountId = "account_id"
    case Ups = "ups"
    case Downs = "downs"
    case Points = "points"
    case Score = "score"
    case IsAlbum = "is_album"
}


/// The base model for an image.
class Image {
    
    /// The ID for the image
    var id              : String
    
    /// The title of the image.
    var title           : String?
    
    /// Description of the image.
    var description     : String?
    
    /// Time uploaded, epoch time
    var dateTime        : Int?
    
    /// Image MIME type.
    var type            : String?
    
    /// is the image animated
    var animated        : Bool?
    
    /// The width of the image in pixels
    var width           : Int?
    
    /// The height of the image in pixels
    var height          : Int?
    
    /// The size of the image in bytes
    var size            : Int?
    
    /// The number of image views
    var views           : Int?
    
    /// Bandwidth consumed by the image in bytes
    var bandwidth       : Int?
    
    /// OPTIONAL, the deletehash, if you're logged in as the image owner
    var deleteHash      : String?
    
    /// OPTIONAL, the original filename, if you're logged in as the image owner
    var name            : String?
    
    /// If the image has been categorized by our backend then this will contain 
    /// the section the image belongs in. (funny, cats, adviceanimals, wtf, etc)
    var section         : String?
    
    /// The direct link to the the image. (Note: if fetching an animated GIF that was 
    /// over 20MB in original size, a .gif thumbnail will be returned)
    var link            : String?
    
    /// OPTIONAL, The .gifv link. Only available if the image is animated and type is 'image/gif'.
    var gifv            : String?
    
    /// OPTIONAL, The direct link to the .mp4. Only available if the image is animated and type is 'image/gif'.
    var mp4             : String?
    
    /// OPTIONAL, The Content-Length of the .mp4. Only available if the image is animated and
    /// type is 'image/gif'. Note that a zero value (0) is possible if the video has not yet been generated
    var mp4_size        : Int?
    
    /// OPTIONAL, Whether the image has a looping animation. Only available
    /// if the image is animated and type is 'image/gif'.
    var looping         : Bool?
    
    /// Indicates if the current user favorited the image. Defaults to false if not signed in.
    var favorite        : Bool?
    
    /// Indicates if the image has been marked as nsfw or not. Defaults to null if information is not available.
    var nsfw            : Bool?
    
    /// The current user's vote on the album. null if not signed in, 
    /// if the user hasn't voted on it, or if not submitted to the gallery.
    var vote            : String?
    
    /// True if the image has been submitted to the gallery, false if otherwise.
    var inGallery       : Bool?
    
    required init(json: JSON) {
        self.id = json[ImageFields.Id.rawValue].stringValue
        self.title = json[ImageFields.Title.rawValue].stringValue
        self.description = json[ImageFields.Description.rawValue].stringValue
        self.dateTime = json[ImageFields.DateTime.rawValue].intValue
        self.type = json[ImageFields.TYPE.rawValue].stringValue
        self.animated = json[ImageFields.Animated.rawValue].boolValue
        self.width = json[ImageFields.Width.rawValue].intValue
        self.height = json[ImageFields.Height.rawValue].intValue
        self.size = json[ImageFields.Size.rawValue].intValue
        self.views = json[ImageFields.Views.rawValue].intValue
        self.bandwidth = json[ImageFields.BandWidth.rawValue].intValue
        self.deleteHash = json[ImageFields.DeleteHash.rawValue].stringValue
        self.name = json[ImageFields.Name.rawValue].stringValue
        self.section = json[ImageFields.Section.rawValue].stringValue
        self.link = json[ImageFields.Link.rawValue].stringValue
        self.gifv = json[ImageFields.Gifv.rawValue].stringValue
        self.mp4 = json[ImageFields.Mp4.rawValue].stringValue
        self.mp4_size = json[ImageFields.Mp4Size.rawValue].intValue
        self.looping = json[ImageFields.Looping.rawValue].boolValue
        self.favorite = json[ImageFields.Favorite.rawValue].boolValue
        self.nsfw = json[ImageFields.NSFW.rawValue].boolValue
        self.vote = json[ImageFields.Vote.rawValue].stringValue
        self.inGallery = json[ImageFields.InGallery.rawValue].boolValue
    }
    
}

/// The Data model Class formatted for gallery images.
class Gallery: Image {
    
    /// Number of comments on the gallery image.
    var commentCount : Int?
    
    /// Topic of the gallery image.
    var topic           : String?
    
    /// Topic ID of the gallery image.
    var topicId        : Int?
    
    /// The username of the account that uploaded it, or null.
    var accountURL 	: String?
    
    /// The account ID of the account that uploaded it, or null.
    var accountId      : Int?
    
    /// Upvotes for the image
    var ups             : Int?
    
    /// Number of downvotes for the image
    var downs           : Int?
    
    /// Upvotes minus downvotes
    var points          : Int?
    
    /// Imgur popularity score
    var score           : Int?
    
    /// If it's an album or not
    var isAlbum        : Bool?
    
    required init(json: JSON ) {
        self.commentCount = json[GalleryFields.CommentCount.rawValue].intValue
        self.topic = json[GalleryFields.Topic.rawValue].stringValue
        self.topicId = json[GalleryFields.TopicId.rawValue].intValue
        self.accountURL = json[GalleryFields.AccountUrl.rawValue].stringValue
        self.accountId = json[GalleryFields.AccountId.rawValue].intValue
        self.ups = json[GalleryFields.Ups.rawValue].intValue
        self.downs = json[GalleryFields.Downs.rawValue].intValue
        self.points = json[GalleryFields.Points.rawValue].intValue
        self.score = json[GalleryFields.Score.rawValue].intValue
        self.isAlbum = json[GalleryFields.IsAlbum.rawValue].boolValue
        
        super.init(json: json)
    }
    
    // MARK: Endpoints
    private class func endPoint() -> String {
        return baseURLWithVersion + "/gallery/"
    }
    
    class func fetchGallery(section: Section = .Hot,
                      sort: Sort = .Viral,
                      page :Int = 1,
                      window: Window = .Day,
                      showViral: Bool = false, completionHandler: (gallery: [Gallery]?)-> Void) {
        var urlString = endPoint()
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
                guard let data = response.data  else {
                    print("No valid JSON")
                    return completionHandler(gallery: nil)
                }
                
                let jsonResult = JSON(data: data)
                
                let galleryArray =  jsonResult["data"]
                
                var galleryObjects = [Gallery]()
                for i in 0..<galleryArray.count {
                    let galleryObject = Gallery(json: galleryArray[i])
                    galleryObjects.append(galleryObject)
                }
                
                completionHandler(gallery: galleryObjects)                
            }
        })
    }
}

extension Gallery : CustomDebugStringConvertible {
     var debugDescription: String {
        var tempString = "identifier: \(self.id ?? "")"
        tempString += "\ntitle: \(self.title ?? "")"
        tempString += "\nupVotes: \(self.ups ?? 0)"
        tempString += "\ndownVotes: \(self.downs ?? 0)"
        tempString += "\npoints: \(self.points ?? 0)"
        tempString += "\nlink: \(self.link ?? "")"
        tempString += "\ntype: \(self.type ?? "")"
        tempString += "\nviews: \(self.views ?? 0)"
        tempString += "\nwidth: \(self.width ?? 0)"
        tempString += "\nheight: \(self.height ?? 0)"
        tempString += "\nanimated: \(self.animated!.stringValue)"
        return tempString
    }
}

