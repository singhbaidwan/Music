//
//  SearchResultSubtitleTableViewCell.swift
//  Music
//
//  Created by Dalveer singh on 15/07/21.
//

import UIKit

class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultSubtitleTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(displayImageView)
        contentView.addSubview(sublabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private let sublabel:UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    private let displayImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        displayImageView.frame = CGRect(x: 10, y: 0, width: contentView.height-10 , height: contentView.height-10)
        label.frame = CGRect(x: displayImageView.right+10, y: 0, width: contentView.width-15, height: contentView.height/2)
        sublabel.frame = CGRect(x: displayImageView.right+10, y: label.bottom, width: contentView.width-15, height: contentView.height/2)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        displayImageView.image = nil
        label.text = nil
        sublabel.text = nil
    }
    func configure(title:String,subtitle:String,url:URL?){
        label.text = title
        sublabel.text = subtitle
        displayImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"),completed: nil)
    }
    

}
