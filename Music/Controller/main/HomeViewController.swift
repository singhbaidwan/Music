//
//  ViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Welcome"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done
                                                            , target: self, action: #selector(didTapSettingMethod))
        fetchData()
    }
    private func fetchData(){
        APICaller.shared.getRecommendationGenres { result in
            switch result{
            case .success(let model):
                let genres = model.genres
                var seed = Set<String>()
                while seed.count<5 {
                    if let random = genres.randomElement(){
                        seed.insert(random)
                    }
                }
                APICaller.shared.getRecommendations(genres: seed) { _ in
                    
                }
            break
            case .failure(let error):
            break
            }
        }
    }
    
    @objc func didTapSettingMethod(){
        let vc = SettingViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

