//
//  SegmentViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 09.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {
    
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    public var movie: Movie?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstContainerView.alpha = 1.0
        secondContainerView.alpha = 0.0
        setupConstraints()
    }
    
    // MARK: - Actions
    
    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            firstContainerView.alpha = 1.0
            secondContainerView.alpha = 0.0
        case 1:
            firstContainerView.alpha = 0.0
            secondContainerView.alpha = 1.0
        default:
            break
        }
    }
    
    // MARK: - Setup constraints
    
    private func setupConstraints() {
        [segmentControl, firstContainerView, secondContainerView].forEach { $0?.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 30),
            firstContainerView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            firstContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondContainerView.topAnchor.constraint(equalTo: firstContainerView.topAnchor)
            ])
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoVC" {
            guard let infoVC = segue.destination as? InfoViewController else { return }
            infoVC.movie = movie
        } else if segue.identifier == "charactersVC" {
            guard let charactersVC = segue.destination as? CharactersViewController else { return }
            charactersVC.movie = movie
        }
    }

}
