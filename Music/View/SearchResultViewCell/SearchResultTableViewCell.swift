//
//  SearchResultTableViewCell.swift
//  Music
//
//  Created by Dalveer singh on 15/07/21.
//

import UIKit
import SDWebImage

class SearchResultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(displayImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    private let label:UILabel = {
        let label = UILabel()
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
        displayImageView.layer.cornerRadius = (contentView.height-10)/2
        displayImageView.layer.masksToBounds = true
        label.frame = CGRect(x: displayImageView.right+10, y: 0, width: contentView.width-15, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        displayImageView.image = nil
        label.text = nil
    }
    func configure(title:String,url:URL?){
        label.text = title
        displayImageView.sd_setImage(with: url, completed: nil)
    }
    
}
