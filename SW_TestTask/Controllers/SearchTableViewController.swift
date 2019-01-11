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
    private var сharacters = [Character]()
    private let loader = Loader()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    // MARK: - Search
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search character"
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        guard let url = URL(string: "https://swapi.co/api/people/?search=\(searchText.lowercased())") else { return }
        loader.fullFetchEntities(url: url, entity: [Character].self) { [weak self] result in
            self?.сharacters = result ?? [Character]()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return сharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) 
        cell.textLabel?.text = сharacters[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let characterInfoVC = storyboard.instantiateViewController(withIdentifier: "CharacterVC") as? CharacterInfoViewController else { return }
        characterInfoVC.character = сharacters[indexPath.row]
        parent?.navigationController?.pushViewController(characterInfoVC, animated: true)
    }
}
