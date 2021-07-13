//
//  SearchViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit

class SearchViewController: UIViewController,UISearchResultsUpdating {

    private let searchController:UISearchController = {
        let searchViewController = UISearchController(searchResultsController: SearchResultViewController())
        searchViewController.searchBar.placeholder = "Artist,Songs,Albums"
        searchViewController.searchBar.searchBarStyle = .minimal
        searchViewController.definesPresentationContext = true
        return searchViewController
    }()
    
    private let collectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitem: item,count: 2)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        return NSCollectionLayoutSection(group: group)
    }))
    private var categories = [Category]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        // to get the query text
        searchController.searchResultsUpdater = self
        view.addSubview(collectionView)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier:CategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        APICaller.shared.getAllCategories { [weak self]result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.categories = model
                    self?.collectionView.reloadData()
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
    }
    // to get the query text and update accordingly
    func updateSearchResults(for searchController: UISearchController) {
        guard let displayController = searchController.searchResultsController as? SearchResultViewController,let query = searchController.searchBar.text,!query.trimmingCharacters(in: .whitespaces).isEmpty
        else { return }
        print(query)
        // do searching for given query
    }
}

extension SearchViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else{
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.configure(with: CategoryCollectionViewCellModel(title: category.name,
                                                             artWorkUrl: URL(string: category.icons.first?.url ?? "")))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let vc = CategoryViewController(category: category)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
