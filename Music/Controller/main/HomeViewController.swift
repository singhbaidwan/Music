//
//  ViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit
enum BrowseSectionType{
    case newReleases(viewModel:[NewReleasesCellViewModel])
    case featuredPlaylist(viewModel:[FeaturedPlaylistCellViewModel])
    case recommendedTracks(viewModel:[RecommendedTrackCollectionViewModel])
}
class HomeViewController: UIViewController {
    
    private var newAlbums:[Album] = []
    private var playlist:[Playlist] = []
    private var tracks:[AudioTrack] = []
    
    //creating collection view compositional layout
    
    private var collectionView:UICollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ in
        return HomeViewController .createSectionLayout(section: sectionIndex)
    })
    
    private let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var sections = [BrowseSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done
                                                            , target: self, action: #selector(didTapSettingMethod))
        configureCollectionView()
        view.addSubview(spinner)
         fetchData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifer)
        collectionView.register(HeaderTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTitleCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    
    private func fetchData(){
        // to fetch the data of api calls collectivily and then notify on main thread when group.leave()==group.enter()
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        print("Fetching Data")
        var newReleases:NewReleasesResponse?
        var featuredPlaylist:FeaturedPlaylistResponse?
        var recommendations:RecommendationReponse?
        //new releases
        APICaller.shared.getNewAllReleases { result in
            defer{
                group.leave()
            }
            switch result{
            case .success( let model):
                newReleases = model
                break
            case .failure(let error):
                print("Error occured in getNewAllReleases \(error.localizedDescription)")
                break
            }
        }
        
        
        // Feautred Playlist
        APICaller.shared.getFeaturedPlaylist { result in
            defer{
                group.leave()
            }
            switch result{
            case .success(let model):
                featuredPlaylist = model
                break
            case .failure(let error):
                print("Error occured in getFeaturedResponse \(error.localizedDescription)")
                break
            }
        }
        
        //Recommendation Tracks
        
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
                APICaller.shared.getRecommendations(genres: seed) { recommendedResult in
                    defer{
                        group.leave()
                    }
                    switch recommendedResult{
                    case .success(let model):
                        recommendations = model
                        break
                    case .failure(let error):
                        print("Error occured in getRecommendations \(error.localizedDescription)")
                        break
                    }
                }
                break
            case .failure(let error):
                print("Error occured in getRecommendationGenres \(error.localizedDescription)")
                break
            }
        }
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,let playlist = featuredPlaylist?.playlists.items,let tracks = recommendations?.tracks else
            {
                fatalError("Models are nil")
                return
            }

            self.configureModel(newAlbums: newAlbums, playlist: playlist, tracks: tracks)
        }
        
    }
   
    private func configureModel(newAlbums:[Album],playlist:[Playlist],tracks:[AudioTrack]){
        
        self.newAlbums = newAlbums
        self.playlist = playlist
        self.tracks = tracks
        sections.append(.newReleases(viewModel: newAlbums.compactMap({
            return NewReleasesCellViewModel(name: $0.name, artWorkURL: URL(string: $0.images.first?.url ?? ""), numberOfTracks: $0.total_tracks, artisitName: $0.artists.first?.name ?? "-")
        })))
        sections.append(.featuredPlaylist(viewModel: playlist.compactMap({
            return FeaturedPlaylistCellViewModel(name: $0.name, artWork: URL(string: $0.images.first?.url ?? ""), creatorName: $0.owner.display_name)
        })))
        
        sections.append(.recommendedTracks(viewModel: tracks.compactMap({
            return RecommendedTrackCollectionViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-", artWorkUrl: URL(string: $0.album?.images.first?.url ?? ""))
        })))
        collectionView.reloadData()
    }
    
    
    @objc func didTapSettingMethod(){
        let vc = SettingViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type{
        
        case .newReleases(let viewModel):
            return viewModel.count
        case .featuredPlaylist(let viewModel):
            return viewModel.count
        case .recommendedTracks(let viewModel):
            return viewModel.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind==UICollectionView.elementKindSectionHeader,let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderTitleCollectionReusableView.identifier, for: indexPath) as? HeaderTitleCollectionReusableView else{
            return UICollectionReusableView()
        }
        header.configure(with: "CHeck")
        return header
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = sections[indexPath.section]
        switch type{
        case .newReleases(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? NewReleaseCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        case .featuredPlaylist(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            cell.configure(with: viewModel[indexPath.row])
            return cell
        case .recommendedTracks(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifer, for: indexPath) as? RecommendedTrackCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            cell.configure(with: viewModel[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.section]
        switch section{
        case .featuredPlaylist:
            let plist = playlist[indexPath.row]
            let vc = PlaylistViewController(playlist: plist)
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = plist.name
            navigationController?.pushViewController(vc, animated: true)
            break
        case .newReleases:
            let album = newAlbums[indexPath.row]
            let vc = AlbumViewController(album: album)
            vc.title = album.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            break
        case .recommendedTracks: break
        }
    }
    
    private static func createSectionLayout(section:Int)->NSCollectionLayoutSection{
        
       let supplementartyView = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]

        
        switch section {
        case 0:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //adding vertical group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), subitem: item, count: 3)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390)), subitem: verticalGroup, count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementartyView
            return section
        case 1:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //adding vertical group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), subitem: item, count: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), subitem: verticalGroup, count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementartyView
            return section
        case 2:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //adding vertical group in horizontal group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitem: item, count: 1)
            
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementartyView
            return section
        default:
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //adding vertical group in horizontal group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), subitem: item, count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementartyView
            return section
        }
    }
    
}
