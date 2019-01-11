//
//  Result.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 10.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Result<T: Codable>: Codable {
    var next: URL?
    var results: [T]
}
