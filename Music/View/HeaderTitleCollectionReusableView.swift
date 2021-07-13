//
//  HeaderTitleCollectionReusableView.swift
//  Music
//
//  Created by Dalveer singh on 13/07/21.
//

import UIKit

class HeaderTitleCollectionReusableView: UICollectionReusableView {
        static let identifier = "HeaderTitleCollectionReusableView"
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0, width: width-30, height: height)
    }
    func configure(with title:String){
        label.text = title
    }
}

