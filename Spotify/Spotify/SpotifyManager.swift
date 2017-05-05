//
//  SpotifyManager.swift
//  Spotify
//
//  Created by Brad Richardson on 1/29/16.
//  Copyright © 2016 USU. All rights reserved.
//

import Foundation

class SpotifyManager {
    
    static let spotifyBaseAPI = "https://api.spotify.com/v1/search?&type=track&limit=50&market=US&q="


    /// Perform a search for tracks through the Spotify API
    ///
    /// - Parameters:
    ///   - query: search query
    ///   - completion: called with parsed spotify track data on main queue
    static func search(query: String, completion: @escaping (_ tracks: [SpotifyTrack], _ queryUsed: String) -> Void) {
        guard let escapedQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: spotifyBaseAPI + escapedQuery)
            else {
                return
        }

        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data,
                error == nil else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }

            guard let raw = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers),
                let json = raw as? [String: AnyObject] else {
                return
            }

            let tracks = parseSpotifyTracks(json: json)
            DispatchQueue.main.async {
                completion(tracks, query)
            }
        }
        task.resume()
    }
    
    static func parseSpotifyTracks(json: [String: AnyObject]) -> [SpotifyTrack] {
        var tracks = [SpotifyTrack]()
        guard let jsonTracks = json["tracks"] as? [String: AnyObject],
            let jsonItems = jsonTracks["items"] as? [[String: AnyObject]]
            else {
                return tracks
        }
        
        for jsonItem in jsonItems {
            tracks.append(SpotifyTrack(json: jsonItem))
        }
        return tracks
    }
    
}
