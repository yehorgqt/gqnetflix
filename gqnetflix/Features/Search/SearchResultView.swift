//
//  SearchResultView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 12.12.2023.
//

import UIKit
import SnapKit

protocol SearchResultDelegate: AnyObject {
    func tranform(with offset: CGFloat)
}

final class SearchResultView: UIView {

    weak var delegate: SearchResultDelegate?
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchResultsCollectionView.reloadData()
            }
        }
    }
    
    private lazy var searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.indentifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration
private extension SearchResultView {
    func setup() {
        backgroundColor = .black
        addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate
extension SearchResultView: UICollectionViewDelegate {
    
}

// MARK: - Data Source
extension SearchResultView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.indentifier,
            for: indexPath) as? MovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie.posterPath ?? "")
        return cell
    }
    
    
}
