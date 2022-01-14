//
//  DetailsViewController.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 13/01/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet private var repoImageView: UIImageView!
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var repoDescriptionLabel: UILabel!
    
    var repos = [Repos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Repo Details"
        
        self.fillDetails()
    }
    
    func fillDetails(){

        for objectRepo in self.repos {
            let url = URL(string: objectRepo.owner.repoImageURL)!
            repoImageView?.loadImage(url: url)
            repoNameLabel?.text = objectRepo.name
            repoDescriptionLabel?.text = objectRepo.description ?? "No Description available!"
        }
    }
}
