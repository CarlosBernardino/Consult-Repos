//
//  ConsultCell.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 13/01/2022.
//

import UIKit

final class ConsultCell: UITableViewCell {
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with repos: Repos) {
        let fileUrl = URL(string: repos.owner.repoImageURL)!
        repoImageView.loadImage(url:fileUrl)
        nameLabel.text = repos.name
    }
}

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
