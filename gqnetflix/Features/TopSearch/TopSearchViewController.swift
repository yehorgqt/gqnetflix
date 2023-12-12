//
//  TopSearchViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit
import SnapKit
import Combine

final class TopSearchViewController: UIViewController {
    
    private var disposalBag = Set<AnyCancellable>()
    
    private lazy var topSearchView: TopSearchView = {
        let view = TopSearchView()
        view.delegate = self
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMovies(endpoint: .topSearch) { response in
            self.topSearchView.movies = response.results
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Configuration
private extension TopSearchViewController {
    func setup() {
        configureNavBar()
        
        view.addSubview(topSearchView)
        
        topSearchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavBar() {
        title = "Top Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - Network
private extension TopSearchViewController {
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
extension TopSearchViewController: TopSearchDelegate {
    func transform(with offset: CGFloat) {
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, offset))
    }
}

