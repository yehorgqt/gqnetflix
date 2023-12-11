//
//  MovieTableViewCell.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 11.12.2023.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: MovieTableViewCell.self)
    
    private lazy var playMovieButton: NetflixMainButton = {
        let button = NetflixMainButton(title: "Play")
        return button
    }()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var moviePosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with model: MovieViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.postUrl)") else { return }
        moviePosterView.sd_setImage(with: url)
        DispatchQueue.main.async { [weak self] in
            self?.movieLabel.text = model.title
            self?.overviewLabel.text = model.overview
        }
    }
}

// MARK: - Configuration
private extension MovieTableViewCell {
    func setUp() {
        contentView.addSubview(moviePosterView)
        contentView.addSubview(movieLabel)
        contentView.addSubview(playMovieButton)
        contentView.addSubview(overviewLabel)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        moviePosterView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.width.equalTo(100)
        }
        
        movieLabel.snp.makeConstraints { make in
            make.leading.equalTo(moviePosterView.snp.trailing).offset(20)
            make.centerY.equalTo(25)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(moviePosterView.snp.trailing).offset(20)
            make.top.equalTo(movieLabel.snp.bottom)
            make.trailing.equalTo(playMovieButton.snp.leading).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        playMovieButton.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(40)
        }
    }
}
