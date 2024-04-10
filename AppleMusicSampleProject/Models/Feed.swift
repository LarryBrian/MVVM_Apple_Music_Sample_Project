//
//  Feed.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import Foundation

struct Feed: Codable {
    var title: String?
    var id: String?
    var author: Author?
    var copyright: String?
    var country: String?
    var icon: String?
    var results: [Album]?
}
