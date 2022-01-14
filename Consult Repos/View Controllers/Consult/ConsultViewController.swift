//
//  ConsultViewController.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 12/01/2022.
//

import UIKit

class ConsultViewController: UIViewController {
    //MARK: - Declarations
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellIdentifier = "ConsultCell"
    private let gridCellIdentifier = "ConsultGridCell"
    private var isGridView = false
    private var repos =  [Repos]()
    let singleton = Singleton.sharedInstance
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: gridCellIdentifier, bundle: nil), forCellWithReuseIdentifier: gridCellIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Grid", style: .plain, target: self, action: #selector(changeView(sender:)))
        
        self.retriveRepos()
        
    }
    
    //MARK: - API Calls
    
    func retriveRepos(){
        NetworkCalls().getRepos { (result) in
            switch result{
                case .success(let repos):
                    DispatchQueue.main.async{
                        self.repos = repos
                        self.singleton.repos = repos
                        self.tableView.reloadData()
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
    
    //MARK: - Actions
    
    @objc func changeView(sender: UIBarButtonItem){
        if isGridView {
            self.tableView.isHidden = false
            self.collectionView.isHidden = true
            self.isGridView = false
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(changeView(sender:)))
        }else{
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
            self.isGridView = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Grid", style: .plain, target: self, action: #selector(changeView(sender:)))
        }
    }
}

//MARK: - TableView DataSources & Delegates

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

extension ConsultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        destination.repos = [self.repos[indexPath.row]]
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
}

//MARK: - CollectionView DataSources & Delegates

extension ConsultViewController: UICollectionViewDataSource{
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return repos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellIdentifier, for: indexPath as IndexPath) as? ConsultGridCell else {
            fatalError("Issue with dequeuing \(gridCellIdentifier)")
        }
        cell.configure(with: self.repos[indexPath.row])
    
        return cell
    }
}

extension ConsultViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:150)
    }
}




