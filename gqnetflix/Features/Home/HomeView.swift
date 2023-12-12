//
//  HomeView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 11.12.2023.
//

import UIKit
import SnapKit

protocol HomeDelegate: AnyObject {
    func fetchMovies(endpoint: Endpoint, completion: @escaping (MoviesResponse) -> Void)
    func tranfsorm(with offset: CGFloat)
}

fileprivate enum Sections: Int {
    case TrandingMovies = 0
    case TrandingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

final class HomeView: UIView {
    
    weak var delegate: HomeDelegate?
    
    private let sectionTitles: [String] = ["Trending Movies", "Tranding TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    private lazy var homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeFeedTable.tableHeaderView = HeroHeaderUIView(frame: CGRect( x: 0, y: 0, width: self.bounds.width, height: self.bounds.height / 2))
    }
}

// MARK: - Configure
private extension HomeView {
    func setup() {
        addSubview(homeFeedTable)
        
        homeFeedTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate
extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var headerConfiguration = header.defaultContentConfiguration()
        headerConfiguration.textProperties.font = .systemFont(ofSize: 18, weight: .semibold)
        headerConfiguration.textProperties.transform = .none
        headerConfiguration.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 6,
            leading: 6,
            bottom: 6,
            trailing: 6
        )
        headerConfiguration.textProperties.color = .white
        headerConfiguration.text = sectionTitles[section]
        
        header.contentConfiguration = headerConfiguration
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        delegate?.tranfsorm(with: -offset)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: - Data Source
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionViewTableViewCell.identifier,
            for: indexPath) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.TrandingMovies.rawValue:
            delegate?.fetchMovies(endpoint: .trandingMovies, completion: { response in
                cell.configure(with: response.results)
            })
        case Sections.TrandingTV.rawValue:
            delegate?.fetchMovies(endpoint: .trandingTV) { response in
                cell.configure(with: response.results)
            }
        case Sections.Popular.rawValue:
            delegate?.fetchMovies(endpoint: .popularMovies) { response in
                cell.configure(with: response.results)
            }
        case Sections.Upcoming.rawValue:
            delegate?.fetchMovies(endpoint: .upcomingMovies) { response in
                cell.configure(with: response.results)
            }
        case Sections.TopRated.rawValue:
            delegate?.fetchMovies(endpoint: .topRated) { response in
                cell.configure(with: response.results)
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}


