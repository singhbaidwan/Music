//
//  NewReleaseCollectionViewCell.swift
//  Music
//
//  Created by Dalveer singh on 11/07/21.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20,weight:.semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberOfTracksLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14,weight:.thin)
        label.numberOfLines = 0
        return label
    }()
    
    private let artisitNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight:.regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artisitNameLabel)
        contentView.clipsToBounds = true // to prevent the overflow of the text from boundries
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize:CGFloat = contentView.height - 10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-imageSize-10, height: contentView.height-10))
        artisitNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        let albumLabelHeight = min(60,albumLabelSize.height)
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: 5, width: albumLabelSize.width, height: albumLabelHeight)
        artisitNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: albumNameLabel.bottom, width: contentView.width-albumCoverImageView.right-10, height:30)
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right+10, y: contentView.bottom - 44, width: numberOfTracksLabel.width, height: 44)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artisitNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel:NewReleasesCellViewModel)
    {
        albumNameLabel.text = viewModel.name
        artisitNameLabel.text = viewModel.artisitName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
    
}
