//
//  DetailsView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 03.01.2024.
//

import UIKit
import SnapKit

protocol DetailsDelegate: AnyObject {}

final class DetailsView: UIView {
    
    weak var delegate: DetailsDelegate?
    
    private lazy var moviePosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MovieViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.postUrl)") else { return }
        moviePosterView.sd_setImage(with: url)
    }
}

// MARK: - Setup
private extension DetailsView {
    func setup() {
        backgroundColor = .black
        addSubview(moviePosterView)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        moviePosterView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
