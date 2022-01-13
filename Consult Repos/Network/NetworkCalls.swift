//
//  NetworkCalls.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 12/01/2022.
//

import Foundation

class NetworkCalls {
    
    var repos: [Repos] = []
    
    func getRepos(completion: @escaping (Result<[Repos],Error>) -> Void){
        guard let url = URL(string: "https://api.github.com/users/google/repos") else {
            print("Error getting the repos!")
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let repos = try! JSONDecoder().decode([Repos].self, from: data!)
                completion(.success(repos))
                print(repos)
            }
        }.resume()
    }
}
