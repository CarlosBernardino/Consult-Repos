//
//  ReposOutput.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 12/01/2022.
//

import Foundation

struct Repos{
    let name : String
    let defaultBranch : String
    let description : String?
    let numberIssuesOpened : Int
    let owner: Owner
    
    struct Owner{
        var repoImageURL: String
    }
    
}

extension Repos: Codable, Hashable{
    enum CodingKeys: String, CodingKey{
        case description
        case name
        case owner
        case defaultBranch = "default_branch"
        case numberIssuesOpened = "open_issues_count"
    }
}

extension Repos.Owner: Codable, Hashable{
    enum CodingKeys: String, CodingKey{
        case repoImageURL = "avatar_url"
    }
}
