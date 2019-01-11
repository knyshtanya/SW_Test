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
    @IBOutlet weak var crawlView: UIView!
    
    private let openingCrawl = UILabel()
    public var movie: Movie?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMovieInfo()
        navigationItem.title = movie?.title
        crawlView.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        animateCrawl()
    }
    
    // MARK: - Actions
    
    private func displayMovieInfo() {
        if let movie = movie {
            movieTitle.text = movie.title
            episodeId.text = "\(movie.episodeId)"
            releaseDate.text = "\(movie.releaseDate)"
            director.text = movie.director
        }
    }
    
    // MARK: - Crawl animation
    
    private func setupCrawlText() {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center
        
        let textParagraphStyle = NSMutableParagraphStyle()
        textParagraphStyle.alignment = .center
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.paragraphStyle: titleParagraphStyle]
        let textAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.paragraphStyle: textParagraphStyle]
        let mainText = movie?.crawl
        
        let  title = NSMutableAttributedString(string: "\(movie?.title ?? "")\n", attributes: titleAttributes)
        let text = NSAttributedString(string: mainText ?? "", attributes: textAttributes)
        title.append(text)
        
        crawlView.addSubview(openingCrawl)
        openingCrawl.translatesAutoresizingMaskIntoConstraints = false
        openingCrawl.attributedText = title
        openingCrawl.textColor = UIColor(red: 250/255.0, green: 226/255.0, blue: 83/255.0, alpha: 1)
        openingCrawl.numberOfLines = 0
    }
    
    private func setupLable() {
        let labelSize = openingCrawl.sizeThatFits(CGSize(width: crawlView.bounds.width - 20, height: CGFloat.greatestFiniteMagnitude))
        openingCrawl.frame = CGRect(x: 32 - (crawlView.bounds.width / 2), y: 0, width: labelSize.width, height: labelSize.height)
    }
    
    private func setupLayer() {
        let layer = CATransformLayer()
        layer.position = CGPoint(x: crawlView.bounds.midX, y: crawlView.bounds.midY)
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1/500
        layer.transform = perspective
        
        layer.addSublayer(openingCrawl.layer)
        crawlView.layer.addSublayer(layer)
    }
    
    private func animateCrawl() {
        setupCrawlText()
        setupLable()
        setupLayer()
        
        let crawlTransformStart = CATransform3DMakeRotation(0.5, 1, 0, 0)
        openingCrawl.layer.transform = CATransform3DTranslate(crawlTransformStart, 0, 280, 0)

        let anim = CABasicAnimation(keyPath: "transform")
        anim.repeatCount = Float.Magnitude.greatestFiniteMagnitude
        anim.fromValue = openingCrawl.transform
        
        let crawlTransformEnd = CATransform3DMakeRotation(0.5, 1, 0, 0)
        anim.toValue = CATransform3DTranslate(crawlTransformEnd, 0, -500, 0)
        
        anim.duration = 90
        openingCrawl.layer.add(anim, forKey: "transform")
    }
}
