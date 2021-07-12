//
//  PlaylistHeaderCollectionReusableView.swift
//  Music
//
//  Created by Dalveer singh on 13/07/21.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate:AnyObject{
    func  PlaylistHeaderCollectionReusableViewPlayAll(_ header:PlaylistHeaderCollectionReusableView)
}
final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    weak var delegate:PlaylistHeaderCollectionReusableViewDelegate?
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize:22,weight:.bold)
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize:18,weight:.semibold)
        return label
    }()
    
    private let ownerLabel:UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize:18,weight:.semibold)
        return label
    }()
    
    private let imageView:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "photo")
        return imageview
    }()
    
    private let playAllButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 35
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    @objc private  func didTapPlayAll(){
        delegate?.PlaylistHeaderCollectionReusableViewPlayAll(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize:CGFloat = height/1.8
        imageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width-20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width-20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width-20, height: 44)
        playAllButton.frame = CGRect(x: width-100, y: height-95, width: 70, height: 70)
    }
    
    func configure(with viewModel:PlaylistHeaderViewModel){
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.discription
        imageView.sd_setImage(with: viewModel.artWorkUrl, completed: nil)
    }
    
}
