//
//  Character.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 06.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Character: Codable {
    var name: String
    var gender: String
    var birthDate: String
    var homeWorld: String
    var species: [String]
    var relatedMovies: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case gender
        case birthDate = "birth_year"
        case homeWorld = "homeworld"
        case species
        case relatedMovies = "films"
    }
    
    static func empty() -> Character {
        return Character(name: "", gender: "", birthDate: "", homeWorld: "", species: [String](), relatedMovies: [String]())
    }
}

struct CharacterResult: Codable {
    var next: URL?
    var results: [Character]
}
