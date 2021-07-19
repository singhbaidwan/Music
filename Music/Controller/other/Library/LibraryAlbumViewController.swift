//
//  LibraryAlbumViewController.swift
//  Music
//
//  Created by Dalveer singh on 17/07/21.
//

import UIKit

class LibraryAlbumViewController: UIViewController {
    var albums=[Album]()
    private let noAlbumView = ActionLabelView()
    private let tableView:UITableView = {
        let tableView=UITableView(frame: .zero,style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    private var observer:NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        fetchUserAlbum()
        updateUI()
        setUpNoPlaylistView()
        observer = NotificationCenter.default.addObserver(forName: .albumSaveNotification, object: nil, queue: .main, using: { [weak self]_ in
            self?.fetchUserAlbum()
        })
    }
    
    @objc func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height )
    }
    private func updateUI(){
        print(albums.count)
        if albums.isEmpty{
            noAlbumView.isHidden = false
            tableView.isHidden = true
        }
        else{
            noAlbumView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    private func setUpNoPlaylistView(){
        view.addSubview(noAlbumView)
        noAlbumView.delegate = self
        noAlbumView.configure(labelText: "You dont have any Album saved", actionTitile: "Browse")
    }
    private func fetchUserAlbum()
    {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbum { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let album ):
                    self?.albums = album
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
}

extension LibraryAlbumViewController:ActionLabelViewDelegate{
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //create playlist for user
        tabBarController?.selectedIndex = 0
    }
    
     
}

extension LibraryAlbumViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else
        {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(title: album.name, subtitle: album.artists.first?.name ?? "-", url: URL(string: album.images.first?.url ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
