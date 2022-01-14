//
//  DetailsViewController.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 13/01/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    //MARK: - Declarations
    
    @IBOutlet private var repoImageView: UIImageView!
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var repoDescriptionLabel: UILabel!
    
    var repos = [Repos]()
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repo Details"
        
        self.fillDetails()
    }
    
    //MARK: - Help Methods
    
    func fillDetails(){
        
        for objectRepo in self.repos {
            let url = URL(string: objectRepo.owner.repoImageURL)!
            repoImageView?.loadImage(url: url)
            repoNameLabel?.text = objectRepo.name
            repoDescriptionLabel?.text = objectRepo.description ?? "No Description available!"
        }
    }
}
