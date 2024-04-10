//
//  Album.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import Foundation

struct Album: Codable {
    var artistName: String?
    var id: String?
    var releaseDate: String?
    var name: String?
    var kind: String?
    var copyright: String?
    var artistId: String?
    var contentAdvisoryRating: String?
    var artistUrl: String?
    var artworkUrl100: String?
    var genres: [Genre]?
    var url: String?
}
