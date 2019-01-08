//
//  Movie.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 06.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Movie {
    var title: String
    var episodeId: Int
    var releaseDate: Date
    var director: String
    var crawl: String
    var characters: [String]
    
    static func empty() -> Movie {
        return Movie(title: "", episodeId: 0, releaseDate: Date(), director: "", crawl: "", characters: [String]())
    }
}
