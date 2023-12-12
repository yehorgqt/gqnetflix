//
//  SearchViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit
import SnapKit
import Combine

final class SearchViewController: UIViewController {
    
    private var сancellable: AnyCancellable?
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.delegate = self
        return view
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMovies(endpoint: .topSearch) { response in
            self.searchView.movies = response.results
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Configuration
private extension SearchViewController {
    func setup() {
        configureNavBar()
        
        view.addSubview(searchView)
        
        searchController.searchResultsUpdater = self
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavBar() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .systemRed
    }
}

// MARK: - Network
private extension SearchViewController {
    func fetchMovies(endpoint: Endpoint, completion: @escaping (MoviesResponse) -> Void) {
        let request = NetworkRequest(httpMethod: .get, endpoint: endpoint)
        
        self.сancellable = MoviesClient.live.fetchMovies(request)
            // TODO: Add debounce for search request
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint(error)
                }
            } receiveValue: { response in

                completion(response)
            }
    }
}

// MARK: Delegate
extension SearchViewController: SearchDelegate {
    func transform(with offset: CGFloat) {
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, offset))
    }
}

// MARK: - Search Results Updating Protocol
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultViewController
        else {
            return
        }
        
        fetchMovies(endpoint: .search(query)) { response in
            resultController.updateMovies(with: response.results)
        }
    }
}


