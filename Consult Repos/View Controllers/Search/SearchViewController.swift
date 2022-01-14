//
//  SearchViewController.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 13/01/2022.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "SearchCell"
    private var repos = [Repos]()
    private var filteredRepos = [Repos]()
    private let singleton = Singleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Search repo by name"
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.repos = self.singleton.repos
        self.filteredRepos = self.repos
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchCell else {
            fatalError("Issue with dequeuing \(cellIdentifier)")
        }
        cell.configure(with: self.filteredRepos[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText will contain user input
        // in allData I have kept all data of the table
        // filteredData used to get the filtered result
        if (searchText == ""){
            self.filteredRepos = self.repos
        }
        else{
            self.filteredRepos = []
            // you can do any kind of filtering here based on user input
            self.filteredRepos = self.repos.filter{
                $0.name.lowercased().contains(searchText.lowercased())
            }
            if self.filteredRepos.count == 0 {
                let alert = UIAlertController(title: "Warning", message: "There isn't any repo by that name!", preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        // lastly you need to update tableView using filteredData so that the filtered rows are only shown
        //As you use SVGdata for tableView, after filtering you have to put all filtered data into SVGdata before reloading the table.
        self.tableView.reloadData()
    }
}
