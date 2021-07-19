//
//  LibraryPlaylistViewController.swift
//  Music
//
//  Created by Dalveer singh on 17/07/21.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    var playlist=[Playlist]()
    private let noPlaylistView = ActionLabelView()
    public var selectionHandler:((Playlist)->Void)?
    private let tableView:UITableView = {
        let tableView=UITableView(frame: .zero,style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        fetchUserPlaylist()
        updateUI()
        setUpNoPlaylistView()
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
    }
    
    @objc func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistView.center=view.center
        tableView.frame = view.bounds
    }
    private func updateUI(){
        print(playlist.count)
        if playlist.isEmpty{
            noPlaylistView.isHidden = false
            tableView.isHidden = true
        }
        else{
            noPlaylistView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    private func setUpNoPlaylistView(){
        view.addSubview(noPlaylistView)
        noPlaylistView.delegate = self
        noPlaylistView.configure(labelText: "You dont have any playlist", actionTitile: "Create")
    }
    private func fetchUserPlaylist()
    {
        APICaller.shared.getCurrentUserPlaylist {[weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self?.playlist = model
//                    print("playlist \(self?.playlist.count)")
                    self?.updateUI()
                    break
                case .failure(let error): break
                }
            }
        }
    }
    public func showPlaylistAlert(){
        let alert = UIAlertController(title: "New Playlists", message: "Enter Playlist name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder="Playlist..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else{
                return
            }
            APICaller.shared.createPlaylist(with: text) { [weak self]success in
                if success {
                    HapticManager.shared.vibrate(for: .success)
                    self?.fetchUserPlaylist()
                }
                else{
                    HapticManager.shared.vibrate(for: .error)
                    print("Failed to create Playlist")
                }
            }
        }))
        present(alert, animated: true, completion: nil)

    }
}

extension LibraryPlaylistViewController:ActionLabelViewDelegate{
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //create playlist for user
        showPlaylistAlert()
    }
    
     
}

extension LibraryPlaylistViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else
        {
            return UITableViewCell()
        }
        let plist = playlist[indexPath.row]
        cell.configure(title: plist.name, subtitle: plist.owner.display_name, url: URL(string: plist.images.first?.url ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticManager.shared.vibrateForSelection()
        let plist = playlist[indexPath.row]
        guard selectionHandler==nil else{
            selectionHandler?(plist)
            dismiss(animated: true, completion: nil)
            return
        }
        let vc = PlaylistViewController(playlist: plist)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
