//
//  GalleryImage.swift
//  ImgGurSwift
//
//  Created by Balaji on 21/06/16.
//  Copyright © 2016 Synchronoss. All rights reserved.
//

import Foundation

class GalleryImage {
    //TODO:: Create isAnimated getter method for this property
    var animated: Bool = false
    var imageDescription : String?
    var upVotes : Int?
    var downVotes: Int?
    var identifier: String?
    var points: Int?
    var link: String?
    var title: String?
    var type: String?
    var views: Int?
    var width: Int?
    var height: Int?
}

extension GalleryImage : CustomStringConvertible {
    var description: String {
        var tempString = "identifier: \(self.identifier ?? "")"
        tempString += "\ntitle: \(self.title ?? "")"
        tempString += "\nupVotes: \(self.upVotes ?? 0)"
        tempString += "\ndownVotes: \(self.downVotes ?? 0)"
        tempString += "\npoints: \(self.points ?? 0)"
        tempString += "\nlink: \(self.link ?? "")"
        tempString += "\ntype: \(self.type ?? "")"
        tempString += "\nviews: \(self.views ?? 0)"
        tempString += "\nwidth: \(self.width ?? 0)"
        tempString += "\nheight: \(self.height ?? 0)"
        tempString += "\nanimated: \(self.animated.stringValue)"
        return tempString
    }
}