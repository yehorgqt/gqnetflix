//
//  UpcomingViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit
import Combine
import SnapKit

final class UpcomingViewController: UIViewController {

    private var disposalBag = Set<AnyCancellable>()

    private lazy var upcomingView: UpcomingView = {
        let view = UpcomingView()
        view.delegate = self
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMovies(endpoint: .upcomingMovies) { response in
            self.upcomingView.movies = response.results
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Configuration
private extension UpcomingViewController {
    func setup() {
        configureNavBar()

        view.addSubview(upcomingView)

        upcomingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureNavBar() {
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsWhenVerticallyCompact = true
    }
}

// MARK: - Network
private extension UpcomingViewController {
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

// MARK: - Delegate
extension UpcomingViewController: UpcomingDelegate {
    func openDetails(with model: MovieViewModel) {
        navigationController?.pushViewController(DetailsViewController(movie: model), animated: true)
    }
}
