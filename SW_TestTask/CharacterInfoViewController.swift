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
    private let loader = Loader()
    
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
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Fetches
    
    private func fetchHomeWorld(url: String) {
        guard let url = URL(string: url) else { return }
        loader.fetchEntity(url: url, entity: Planet.self) { [weak self] result in
            self?.homeWorld = result ?? Planet.empty()
            DispatchQueue.main.async {
                self?.homeWorldButton.setTitle(self?.homeWorld.name, for: .normal)
            }
        }
    }
    
    private func fetchSpecies(url: String) {
        guard let url = URL(string: url) else { return }
        loader.fetchEntity(url: url, entity: Species.self) { [weak self] result in
            self?.fetchedSpecies = result?.name
            DispatchQueue.main.async {
                self?.species.text = self?.fetchedSpecies
            }
        }
    }
    
    private func fetchRelatedMovie(url: String) {
        guard let url = URL(string: url) else { return }
        loader.fetchEntity(url: url, entity: Movie.self) { [weak self] result in
            self?.movies.append(result ?? Movie.empty())
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let infoVC = storyboard.instantiateViewController(withIdentifier: "infoVC") as? InfoViewController else { return }
        infoVC.movie = movies[indexPath.row]
        navigationController?.pushViewController(infoVC, animated: true)
    }
}
