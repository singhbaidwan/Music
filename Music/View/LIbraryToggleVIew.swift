//
//  LibraryToggleView.swift
//  Music
//
//  Created by Dalveer singh on 17/07/21.
//

import UIKit

protocol LibraryToggleViewDelegate:AnyObject{
    func LibraryToggleViewDidTapPlaylist(_ toggleView:LibraryToggleView)
    func LibraryToggleViewDidTapAlbums(_ toggleView:LibraryToggleView)
}
class LibraryToggleView: UIView {
    enum State{
        case playlist
        case album
    }
    var state:State = .playlist
    weak var delegate:LibraryToggleViewDelegate?
    private let playListButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    private let albumButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    private let indicatorView:UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playListButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        playListButton.addTarget(self, action: #selector(didTapPlaylist), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbum), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func didTapPlaylist(){
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.LibraryToggleViewDidTapPlaylist(self)
    }
    @objc private func didTapAlbum(){
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.LibraryToggleViewDidTapAlbums(self)
    }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playListButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumButton.frame = CGRect(x: playListButton.right, y: 0, width: 100, height: 40)
        indicatorView.frame = CGRect(x: 0, y: playListButton.bottom, width: 100, height: 3)
        layoutIndicator()
    }
    private func layoutIndicator(){
        switch state{
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playListButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playListButton.bottom, width: 100, height: 3)
        }
    }
    func upadteUI(for state:State){
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }

    }
}
