//
//  Loader.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 08.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

private struct Result<T: Codable>: Codable {
    var next: URL?
    var results: [T]
}

struct Loader {
    
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
    
    func fetchEntities<T: Codable>(url: URL, entity: [T].Type, completion: @escaping ([T]?) -> Void) {
        fetchEntity(url: url, entity: Result<T>.self) { fetchResult in
            completion(fetchResult?.results)
        }
    }
    
    func fullFetchEntities<T: Codable>(url: URL, entity: [T].Type, completion: @escaping ([T]?) -> Void) {
        var result = [T]()
        
        func helper(_ url: URL) {
            fetchEntity(url: url, entity: Result<T>.self) { fetchResult in
                guard let fetchResult = fetchResult else {
                    completion(result.isEmpty ? nil : result)
                    return
                }
                result.append(contentsOf: fetchResult.results)
                guard let nextUrl = fetchResult.next else {
                    completion(result)
                    return
                }
                helper(nextUrl)
            }
        }
        
        helper(url)
    }
}
