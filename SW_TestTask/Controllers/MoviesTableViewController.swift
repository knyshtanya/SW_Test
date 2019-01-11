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
    private var loader = Loader()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    // MARK: - Fetch movies
    
    private func fetchMovies() {
        guard let url = URL(string: "https://swapi.co/api/films/") else { return }
        loader.fetchEntities(url: url, entity: [Movie].self) { [weak self] result in
            self?.movies = result ?? [Movie]()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
        guard let selectedIndex = self.tableView.indexPathForSelectedRow else { return }
        guard let segmentVC = segue.destination as? SegmentViewController else { return }
        segmentVC.movie = movies[selectedIndex.row]
    }
}
