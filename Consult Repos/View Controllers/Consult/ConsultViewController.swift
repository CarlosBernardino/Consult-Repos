//
//  ConsultViewController.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 12/01/2022.
//

import UIKit

class ConsultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "ConsultCell"
    private var repos =  [Repos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.retriveRepos()

    }
    
    func retriveRepos(){
        NetworkCalls().getRepos { (result) in
            switch result{
                case .success(let repos):
                    DispatchQueue.main.async{
                        self.repos = repos
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
}

extension ConsultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ConsultCell else {
            fatalError("Issue with dequeuing \(cellIdentifier)")
        }
        cell.configure(with: self.repos[indexPath.row])
        return cell
    }
}


