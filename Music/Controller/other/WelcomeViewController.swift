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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInbutton)
        signInbutton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
