//
//  PlayerViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate:AnyObject{
    func didTapPlayAndPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value:Float)
}

class PlayerViewController: UIViewController {
    
    weak var datasouce:PlayerDataSource?
    weak var delegate:PlayerViewControllerDelegate?
    private let imageView:UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .systemRed
        imageview.contentMode = .scaleAspectFill
//        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    private let controlView = PlayerControlView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlView)
        controlView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        configure()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlView.frame = CGRect(x: 10,
                                  y: imageView.bottom+10,
                                  width: view.width-20,
                                  height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: 360)
//        ])
    }
    @objc func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapAction(){
        
    }
    private func configure(){
        imageView.sd_setImage(with: datasouce?.imageURL, completed: nil)
        controlView.configue(with: datasouce?.songName, with: datasouce?.subtitle)
    }
}

extension PlayerViewController:PlayerControlViewDelegate{
    func playerControlViewDidSlideVolume(_ view: PlayerControlView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func playerControlViewDidTapPlayPause(_ view: PlayerControlView) {
        delegate?.didTapPlayAndPause()
    }
    
    func playerControlViewDidTapForwardButton(_ view: PlayerControlView) {
        delegate?.didTapForward()
    }
    
    func playerControlViewDidTapBackwardButton(_ view: PlayerControlView) {
        delegate?.didTapBackward()
    }
}
