//
//  LibraryViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit

class LibraryViewController: UIViewController {

    private let playlistVC = LibraryPlaylistViewController()
    private let albumVC = LibraryAlbumViewController()
    private let scrollView:UIScrollView = {
       let scrollview = UIScrollView()
        scrollview.isPagingEnabled = true
        return scrollview
    }()
    private let toggleView=LibraryToggleView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        toggleView.delegate = self
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        addChildren()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.width, height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55 )
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 55)
    }
    private func addChildren(){
        addChild(playlistVC)
        scrollView.addSubview(playlistVC.view)
        playlistVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistVC.didMove(toParent: self)
        
        addChild(albumVC)
        scrollView.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumVC.didMove(toParent: self)
    }
}

extension LibraryViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-100){
            toggleView.upadteUI(for: .album)
        }
        else{
            toggleView.upadteUI(for: .playlist)
        }
    }
}

extension LibraryViewController:LibraryToggleViewDelegate{
    func LibraryToggleViewDidTapPlaylist(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        
    }
    
    func LibraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
    }
}
