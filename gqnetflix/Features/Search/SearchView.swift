//
//  SearchView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 12.12.2023.
//

import UIKit
import SnapKit

protocol SearchDelegate: AnyObject {}

final class SearchView: UIView {
    
    weak var delegate: SearchDelegate?
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
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
private extension SearchView {
    func setup() {
        backgroundColor = .black
        addSubview(searchTableView)
        
        searchTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.identifier,
            for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        let model = MovieViewModel(
            title: movie.safeName,
            postUrl: movie.posterPath ?? "",
            overview: movie.overview ?? "..."
        )
        cell.configure(with: model)
        
        return cell
    }
}
