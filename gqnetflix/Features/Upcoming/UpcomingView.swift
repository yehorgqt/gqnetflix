//
//  UpcomingView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 12.12.2023.
//

import UIKit
import SnapKit

protocol UpcomingDelegate: AnyObject {
    func openDetails()
}

final class UpcomingView: UIView {
    
    weak var delegate: UpcomingDelegate?
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.upcomingTableView.reloadData()
            }
        }
    }
    
    private lazy var upcomingTableView: UITableView = {
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
private extension UpcomingView {
    func setup() {
        backgroundColor = .black
        addSubview(upcomingTableView)
        
        upcomingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate
extension UpcomingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - Data Source
extension UpcomingView: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openDetails()
    }
}
