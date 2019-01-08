//
//  CharacterInfoViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 06.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var homeWorldButton: UIButton!
    @IBOutlet weak var species: UILabel!
    
    private var fetchedSpecies: String?
    private var movies = [Movie]()
    private var homeWorld = Planet.empty()
    public var character: Character?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = character else { return }
        navigationItem.title = "\(character.name)"
        displayCharacterInfo()
    }
    
    // MARK: - Actions
    
    @IBAction func homeWorldTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let planetInfoVC = storyboard.instantiateViewController(withIdentifier: "planetInfoVC") as? PlanetInfoViewController else { return }
        planetInfoVC.planet = homeWorld
        navigationController?.pushViewController(planetInfoVC, animated: true)
    }
    
    private func displayCharacterInfo() {
        guard let character = character else { return }
        name.text = character.name
        gender.text = character.gender
        birth.text = character.birthDate
        fetchHomeWorld(url: character.homeWorld)
        fetchSpecies(url: character.species.first ?? "")
        fetchAllRelatedMovies()
    }
    
    // MARK: - Fetches
    
    private func fetchHomeWorld(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let name = json["name"] as? String {
                        self.homeWorld.name = name
                    }
                    if let population = json["population"] as? String {
                        self.homeWorld.population = population
                    }
                    if let climate = json["climate"] as? String {
                        self.homeWorld.climate = climate
                    }
                    if let diameter = json["diameter"] as? String {
                        self.homeWorld.diameter = diameter
                    }
                    if let terrain = json["terrain"] as? String {
                        self.homeWorld.terrain = terrain
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.homeWorldButton.setTitle(self.homeWorld.name, for: .normal)
            }
        }
        task.resume()
    }
    
    private func fetchSpecies(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let name = json["name"] as? String {
                        self.fetchedSpecies = name
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.species.text = self.fetchedSpecies
            }
        }
        task.resume()
    }
    
    private func fetchRelatedMovie(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    var movie = Movie.empty()
                    
                    if let title = json["title"] as? String {
                        movie.title = title
                    }
                    if let episodeId = json["episode_id"] as? Int {
                        movie.episodeId = episodeId
                    }
                    if let releaseDate = json["release_date"] as? Date {
                        movie.releaseDate = releaseDate
                    }
                    if let director = json["director"] as? String {
                        movie.director = director
                    }
                    if let crawl = json["opening_crawl"] as? String {
                        movie.crawl = crawl
                    }
                    if let characters = json["characters"] as? [String] {
                        movie.characters = characters
                    }
                    self.movies.append(movie)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
        task.resume()
    }
    
    private func fetchAllRelatedMovies() {
        guard let character = character else { return }
        for movie in character.relatedMovies {
            fetchRelatedMovie(url: movie)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let tabBarVC = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as? UITabBarController else { return }
        guard let infoVC = tabBarVC.viewControllers?[0] as? InfoViewController else { return }
        infoVC.movie = movies[indexPath.row]
        navigationController?.pushViewController(infoVC, animated: true)
    }
}
