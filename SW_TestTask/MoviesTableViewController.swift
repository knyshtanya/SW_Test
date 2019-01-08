//
//  MoviesTableViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 05.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    private var movies = [Movie]()
    private var task: URLSessionTask?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SW Movies"
        fetchMovies(url: "https://swapi.co/api/films/")
    }
    
    // MARK: - Fetch movies
    
    private func fetchMovies(url: String) {
        guard let url = URL(string: url) else { return }
        task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let results = json["results"] as! [Any]
                    
                    for index in 0..<results.count {
                        if let result = results[index] as? NSDictionary {
                            var movie = Movie.empty()
                            
                            if let title = result["title"] as? String {
                                movie.title = title
                            }
                            
                            if let episodeId = result["episode_id"] as? Int {
                                movie.episodeId = episodeId
                            }
                            
                            if let releaseDate = result["release_date"] as? Date {
                                movie.releaseDate = releaseDate
                            }
                            
                            if let director = result["director"] as? String {
                                movie.director = director
                            }
                            
                            if let crawl = result["opening_crawl"] as? String {
                                movie.crawl = crawl
                            }
                            
                            if let characters = result["characters"] as? [String] {
                                movie.characters = characters
                            }
                            self.movies.append(movie)
                        }
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        task?.resume()
    }

    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
        guard let tabBarVC = segue.destination as? UITabBarController else { return }
            if let infoVC = tabBarVC.viewControllers?[0] as? InfoViewController {
                infoVC.movie = self.movies[(selectedIndex?.row)!]
            }
            if let charactersVC = tabBarVC.viewControllers?[1] as? CharactersViewController {
                charactersVC.movie = self.movies[(selectedIndex?.row)!]
            }
    }
}
