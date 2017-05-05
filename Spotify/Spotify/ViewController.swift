//
//  ViewController.swift
//  Spotify
//
//  Created by Brad Richardson on 1/29/16.
//  Copyright © 2016 USU. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!

    var tableData = [SpotifyTrack](){didSet {
        tableView.reloadData()
        
        }
    }
    var player: AVPlayer?
    var mostRecentQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
               tableView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Make audio from the app play as music
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            return
        }
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mostRecentQuery = searchText
        SpotifyManager.search(query: searchText) {
            (tracks: [SpotifyTrack], queryUsed: String) in
            guard queryUsed == self.mostRecentQuery else {
                // Ignoring result because it isn't the most recent
                return
            }
            // Update data
            self.tableData = tracks
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackCell
        
        cell.spottrack = tableData[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Play song preview when cell is selected
        guard let url = URL(string: tableData[indexPath.row].previewUrl) else {
            return
        }
        player = AVPlayer(url: url)
        if let player = player {
            player.play()
        }
        //tableView.reloadData()
    }
}


