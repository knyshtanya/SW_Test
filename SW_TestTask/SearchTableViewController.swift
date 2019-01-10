//
//  SearchTableViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 09.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacters = [Character]()
    private let loader = Loader()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Character"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        guard let url = URL(string: "https://swapi.co/api/people/?search=\(searchText.lowercased())") else { return }
        loader.fetchEntity(url: url, entity: CharacterResult.self) { [weak self] result in
            self?.filteredCharacters = searchText.isEmpty ? [Character]() : result?.results ?? [Character]()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) 
        cell.textLabel?.text = filteredCharacters[indexPath.row].name
        return cell
    }
}
