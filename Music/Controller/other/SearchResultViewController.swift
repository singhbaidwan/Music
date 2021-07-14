//
//  SearchResultViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit
struct SearchSection{
    let title:String
    let result:[SearchResult]
}
protocol SearchResultViewControllerDelegate: AnyObject{
    func showResult(_ result:SearchResult)
}
class SearchResultViewController: UIViewController {
    weak var delegate:SearchResultViewControllerDelegate?
    private var sections:[SearchSection] = []
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.isHidden = true
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    func update(with result:[SearchResult])
    {
        let artist = result.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })
        let album = result.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })
        let track = result.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })
        let playlist = result.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })
        self.sections = [
            SearchSection(title: "Songs", result: track),
            SearchSection(title: "Artist", result: artist),
            SearchSection(title: "Album", result: album),
            SearchSection(title: "Playlist", result: playlist)
        ]
        tableView.isHidden = result.isEmpty
        self.tableView.reloadData()
        
    }
    
}

extension SearchResultViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].result.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].result[indexPath.row]
        switch result{
        
        case .artist(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier,for: indexPath) as? SearchResultTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(title: model.name, url: URL(string: model.images?.first?.url ?? ""))
            return cell
        case .album(model: let model):
            guard let acell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier,for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            acell.configure(title: model.name, subtitle: model.artists.first?.name ?? "-", url: URL(string: model.images.first?.url ?? ""))
            return acell
        case .track(model: let model):
            guard let acell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier,for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            acell.configure(title: model.name, subtitle: model.artists.first?.name ?? "-", url: URL(string: model.album?.images.first?.url ?? ""))
            return acell
        case .playlist(model: let model):
            guard let acell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier,for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            acell.configure(title: model.name, subtitle: model.owner.display_name ?? "-", url: URL(string: model.images.first?.url ?? ""))
            return acell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].result[indexPath.row]
        // we will be using protocol to return the selected ersutl bck to search view controller as this is only for diplaying search
        delegate?.showResult(result)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
