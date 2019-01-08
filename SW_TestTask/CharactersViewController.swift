//
//  CharactersViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 06.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    private let tableView = UITableView()
    public var movie: Movie?
    private var characters = [Character]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacters = [Character]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchAllCharacters()
        setupSearchController()
    }
    
    // MARK: - Search
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredCharacters = searchText.isEmpty ? characters : characters.filter { return $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    // MARK: - Setup tableView
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    // MARK: - Fetch Characters
    
    private func fetchAllCharacters() {
        guard let movie = movie else { return }
        for url in movie.characters {
            fetchCharacter(url: url)
        }
    }
    
    private func fetchCharacter(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    var character = Character.empty()
                    if let name = json["name"] as? String {
                        character.name = name
                    }
                    if let gender = json["gender"] as? String {
                        character.gender = gender
                    }
                    if let birthDate = json["birth_year"] as? String {
                        character.birthDate = birthDate
                    }
                    if let homeWorld = json["homeworld"] as? String {
                        character.homeWorld = homeWorld
                    }
                    if let species = json["species"] as? [String] {
                        character.species = species
                    }
                    if let relatedMovies = json["films"] as? [String] {
                        character.relatedMovies = relatedMovies
                    }
                    self.characters.append(character)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredCharacters.count : characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier, for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = searchController.isActive ? filteredCharacters[indexPath.row].name: characters[indexPath.row].name
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let characterInfoVC = storyboard.instantiateViewController(withIdentifier: "CharacterVC") as? CharacterInfoViewController else { return }
        characterInfoVC.character = characters[indexPath.row]
        navigationController?.pushViewController(characterInfoVC, animated: true)
    }
}
