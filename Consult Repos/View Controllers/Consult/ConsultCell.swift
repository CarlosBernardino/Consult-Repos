//
//  ConsultCell.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 13/01/2022.
//

import UIKit

final class ConsultCell: UITableViewCell {
    //MARK: - Declarations
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Cell Config
    
    func configure(with repos: Repos) {
        let url = URL(string: repos.owner.repoImageURL)!
        repoImageView.loadImage(url:url)
        nameLabel.text = repos.name
    }
}


