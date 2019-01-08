//
//  InfoViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 05.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var episodeId: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var crawl: UITextView!
    
    public var movie: Movie?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMovieInfo()
    }
    
    private func displayMovieInfo() {
        if let movie = movie {
            movieTitle.text = movie.title
            episodeId.text = "\(movie.episodeId)"
            releaseDate.text = "\(Calendar.current.component(.day, from: movie.releaseDate))/\(Calendar.current.component(.month, from: movie.releaseDate))/\(Calendar.current.component(.year, from: movie.releaseDate))"
            director.text = movie.director
            crawl.text = movie.crawl
        }
    }
}
