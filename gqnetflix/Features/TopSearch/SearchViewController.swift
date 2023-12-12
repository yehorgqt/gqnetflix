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
    
    private var disposalBag = Set<AnyCancellable>()
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.delegate = self
        return view
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
        
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavBar() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - Network
private extension SearchViewController {
    func fetchMovies(endpoint: Endpoint, completion: @escaping (MoviesResponse) -> Void) {
        let publisher = MoviesClient.live.fetchMovies(NetworkRequest(httpMethod: .get, endpoint: endpoint))
        
        publisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { response in
                completion(response)
            }
            .store(in: &disposalBag)
    }
}

// MARK: Delegate
extension SearchViewController: SearchDelegate {
    func transform(with offset: CGFloat) {
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, offset))
    }
}

