//
//  SearchCell.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 14/01/2022.
//

import UIKit

final class SearchCell: UITableViewCell {
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var defaultBranchLabel: UILabel!
    @IBOutlet weak var issuesOpenedLabel: UILabel!
    
    func configure(with repos: Repos) {
        repoNameLabel.text = repos.name
        defaultBranchLabel.text = repos.defaultBranch
        issuesOpenedLabel.text = String(repos.numberIssuesOpened)
    }
    
}
