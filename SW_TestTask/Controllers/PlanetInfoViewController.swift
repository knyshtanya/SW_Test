//
//  PlanetInfoViewController.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 07.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class PlanetInfoViewController: UIViewController {
    
    public var planet: Planet?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var climate: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var terrain: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let planet = planet else { return }
        navigationItem.title = "\(planet.name)"
        displayPlanetInfo()
    }
    
    // MARK: - Actions
    
    private func displayPlanetInfo() {
        name.text = planet?.name
        population.text = planet?.population
        climate.text = planet?.climate
        diameter.text = planet?.diameter
        terrain.text = planet?.terrain
    }
}
