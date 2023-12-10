//
//  HeroHeaderUIView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import UIKit
import SnapKit

final class HeroHeaderUIView: UIView {
    
    private lazy var playButton: NetflixMainButton = {
        let button = NetflixMainButton(title: "Play")
        return button
    }()
    
    private lazy var downloadButton: NetflixMainButton = {
        let button = NetflixMainButton(title: "Download")
        return button
    }()
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: Assets.homeMockImage)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Header Setup Up
private extension HeroHeaderUIView {
    func setUp() {
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        
        addConstraints()
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

// MARK: - Constraints
private extension HeroHeaderUIView {
    func addConstraints() {
        playButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(25)
            make.bottom.equalTo(-50)
            make.width.equalTo(100)
        }
        
        downloadButton.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(-25)
            make.bottom.equalTo(-50)
            make.width.equalTo(100)
        }
    }
}
