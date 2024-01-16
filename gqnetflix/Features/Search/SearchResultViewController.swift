//
//  SearchResultViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 12.12.2023.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    private lazy var searchResultView: SearchResultView = {
        let view = SearchResultView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - View
extension SearchResultViewController {
    func updateMovies(with movies: [Movie]) {
        self.searchResultView.movies = movies
    }
}

// MARK: - Configuration
private extension SearchResultViewController {
    func setup() {
        view.backgroundColor = .black
        view.addSubview(searchResultView)
        
        searchResultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureNavBar()
    }
    
    func configureNavBar() {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsWhenVerticallyCompact = true
    }
}

// MARK: - Delegate
extension SearchResultViewController: SearchResultDelegate {}
