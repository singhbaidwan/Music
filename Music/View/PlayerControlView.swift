//
//  PlayerControlView.swift
//  Music
//
//  Created by Dalveer singh on 15/07/21.
//

import UIKit

protocol PlayerControlViewDelegate:AnyObject{
    func playerControlViewDidTapPlayPause(_ view:PlayerControlView)
    func playerControlViewDidTapForwardButton(_ view:PlayerControlView)
    func playerControlViewDidTapBackwardButton(_ view:PlayerControlView)
    func playerControlViewDidSlideVolume(_ view:PlayerControlView,didSlideSlider value:Float)
}

final class PlayerControlView:UIView{
    
    private let slider:UISlider={
        let slider = UISlider()
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.value = 0.5
        return slider
    }()
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "song"
        label.font = .systemFont(ofSize:20,weight:.bold)
        return label
    }()
    private let subtitleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.text = "subtile"
        label.font = .systemFont(ofSize:18,weight:.semibold)
        return label
    }()
    private let backButton:UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "backward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .heavy)), for: .normal)
        return button
    }()
    private let forwardButton:UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "forward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 54, weight: .heavy)), for: .normal)
        return button
    }()
    private let playAndPauseButton:UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .heavy )), for: .normal)
        return button
    }()
    weak var delegate:PlayerControlViewDelegate?
    private var isPlaying:Bool = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(slider)
        addSubview(forwardButton)
        addSubview(backButton)
        addSubview(playAndPauseButton)
        clipsToBounds = true
        slider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        backButton.addTarget(self, action: #selector(didTapbackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapforwardButton), for: .touchUpInside)
        playAndPauseButton.addTarget(self, action: #selector(didTapplayAndPauseButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func didSlideSlider(_ slider:UISlider){
        let value = slider.value
        delegate?.playerControlViewDidSlideVolume(self, didSlideSlider: value)
    }
    @objc private func didTapbackButton(){
        delegate?.playerControlViewDidTapBackwardButton(self)
    }
    @objc private func didTapforwardButton(){
        delegate?.playerControlViewDidTapForwardButton(self)
    }
    @objc private func didTapplayAndPauseButton(){
        self.isPlaying = !isPlaying
        delegate?.playerControlViewDidTapPlayPause(self)
        let pause = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .heavy))
        let play = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .heavy))
        playAndPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        slider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44)
        let buttonSize:CGFloat = 60
        playAndPauseButton.frame = CGRect(x: (width-buttonSize)/2, y: slider.bottom+10, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playAndPauseButton.left-80-buttonSize, y: playAndPauseButton.top, width: buttonSize, height: buttonSize)
        forwardButton.frame = CGRect(x: playAndPauseButton.right+80, y: playAndPauseButton.top, width: buttonSize, height: buttonSize)
    }
    
    public func configue(with name:String?,with subtitle:String?)
    {
        nameLabel.text = name
        subtitleLabel.text = subtitle
    }
    
}
