//
//  Item.swift
//  Spotify
//
//  Created by Brad Richardson on 1/29/16.
//  Copyright © 2016 USU. All rights reserved.
//

import Foundation

class SpotifyTrack {
    
    var title = ""
    var artist = ""
    var previewUrl = ""
    var arturl = "https://www01.wellsfargomedia.com/assets/images/global/wf-logo.gif"
    
    init(json: [String: AnyObject]) {
        guard let title = json["name"] as? String
            else {
                return
        }
        self.title = title
        
        guard let artists = json["artists"] as? [[String: AnyObject]],
            let firstArtist = artists.first,
            let artist = firstArtist["name"] as? String
            else {
                return
        }
        self.artist = artist

        guard let previewUrl = json["preview_url"] as? String
            else {
                return
        }
        self.previewUrl = previewUrl
        
        guard let album = json["album"] as? [String: AnyObject],
        let image = album["images"] as? [[String: AnyObject]],
        let firstimage = image.last,  //change from first to last made the who project work.  Took 3 hours to discover this
        let arturls = firstimage["url"] as? String
        else {
                print ("after url failed")
            return
        }
        
        self.arturl = arturls
        
        
    }
    
}
