//
//  TrackCell.swift
//  Spotify
//
//  Created by Brandon on 5/4/17.
//  Copyright © 2017 USU. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var AlbumArt: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Artist: UILabel!
    var spottrack: SpotifyTrack?{
        didSet {
            Artist.text = spottrack?.artist
            Artist.font = UIFont.boldSystemFont(ofSize: 13.0)
            Title.text = spottrack?.title
            let url = NSURL(string: (spottrack?.arturl)!)//this approach was taken from example on stackoverflow
            let data = NSData(contentsOf: url! as URL)
            if (data != nil){
                AlbumArt.image = UIImage(data: data! as Data)
            }
            else {
                AlbumArt.image = #imageLiteral(resourceName: "USU")
            }
            
           // AlbumArt.image = #imageLiteral(resourceName: "USU")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
