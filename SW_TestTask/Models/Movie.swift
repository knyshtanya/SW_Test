//
//  Movie.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 06.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

struct Movie: Codable {
    
    let title: String
    let episodeId: Int
    let releaseDate: String
    let director: String
    let crawl: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case releaseDate = "release_date"
        case director
        case crawl = "opening_crawl"
        case characters
    }
    
    static func empty() -> Movie {
        return Movie(title: "", episodeId: 0, releaseDate: "", director: "", crawl: "", characters: [String]())
    }
}
