//
//  AlbumViewController.swift
//  Music
//
//  Created by Dalveer singh on 12/07/21.
//

import UIKit

class AlbumViewController: UIViewController {
    private let album:Album
    init(album:Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        APICaller.shared.getAlbumDetails(album: album) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                break
                case .failure(let error):
                break
                }
            }
        }
    }
    
    
}
