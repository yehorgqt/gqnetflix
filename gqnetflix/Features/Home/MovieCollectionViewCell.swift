//
//  MovieCollectionViewCell.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 11.12.2023.
//

import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell {

    static let indentifier = "MovieCollectionViewCell"

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
}

extension MovieCollectionViewCell {
    public func configure(with url: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(url)") else { return }
        posterImageView.sd_setImage(with: url)
    }
}
