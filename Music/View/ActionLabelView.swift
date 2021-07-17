//
//  ActionLabelView.swift
//  Music
//
//  Created by Dalveer singh on 17/07/21.
//

import UIKit

protocol ActionLabelViewDelegate:AnyObject{
    func actionLabelViewDidTapButton(_ actionView:ActionLabelView)
}
class ActionLabelView: UIView {
    weak var delegate:ActionLabelViewDelegate?
    private let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize:15,weight:.bold)
        label.textColor = .secondaryLabel
        return label
    }()
    private let button:UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(label)
        addSubview(button)
        isHidden = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton(){
        delegate?.actionLabelViewDidTapButton(self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: width, height: 45)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height-45)
    }
    func configure(labelText text:String,actionTitile actionTitile:String)
    {
        label.text = text
        button.setTitle(actionTitile, for: .normal)
    }
}
