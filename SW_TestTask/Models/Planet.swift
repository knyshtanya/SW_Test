//
//  Planet.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 07.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Planet: Codable {
    let name: String
    let population: String
    let climate: String
    let diameter: String
    let terrain: String
        
    static func empty() -> Planet {
        return Planet(name: "", population: "", climate: "", diameter: "", terrain: "")
    }
}
