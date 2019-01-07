//
//  Character.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 06.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

//-- Character info screen provides the following information: Name, gender, birth date, birth, home world, species, related movies


struct Character {
    var name: String
    var gender: String
    var birthDate: Date
    var homeWorld: String
    var species: [String]
    var relatedMovies: [String]
}
