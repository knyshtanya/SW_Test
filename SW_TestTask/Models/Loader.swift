//
//  Loader.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 08.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Loader{
    
    func fetchEntity<T: Codable>(url: URL, entity: T.Type, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(entity, from: data)
                completion(result)
            }
            catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
