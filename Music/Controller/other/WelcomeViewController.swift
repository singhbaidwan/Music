//
//  WelcomeViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInbutton:UIButton = {
         let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("SIgn In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    private let backgroundImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "playlist_background")
        return imageView
    }()
    private let overlayView:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    private let logoImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let label:UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 32,weight:.semibold)
        label.text = "Listen to Millions\nof Songs on\nthe go"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NewSpotify"
        view.backgroundColor = .black
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(signInbutton)
        signInbutton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        view.addSubview(label)
        view.addSubview(logoImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overlayView.frame = view.bounds
        backgroundImageView.frame = view.bounds
        signInbutton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
        
    }
    
    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.completionHandler = { [weak self]success in
            self?.handleSignIn(success:success)
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func handleSignIn(success:Bool)
    {
        // log the user in
        guard success else {
            let alert = UIAlertController(title: "Sign In error", message: "Not able to sign In . Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainTabVC = TabBarViewController()
        mainTabVC.modalPresentationStyle = .fullScreen
        present(mainTabVC, animated: true, completion: nil)
        
    }
}
