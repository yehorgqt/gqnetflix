//
//  UpcomingViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit
import Combine

final class UpcomingViewController: UIViewController {
    
    private var movies: [Movie] = []
    private var cancellable: Set<AnyCancellable> = []
    
    private lazy var upcomingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getMovies(endpoint: .upcomingMovies) { response in
            self.movies = response.results
            DispatchQueue.main.async {
                self.upcomingTableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTableView.frame = view.bounds
    }
    
    func getMovies(endpoint: Endpoint, completion: @escaping (MoviesResponse) -> Void) {
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
            .store(in: &cancellable)
    }
}

// MARK: - Set Up
private extension UpcomingViewController {
    func setUp() {
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        configureTableView()
    }
    
    func configureNavBar() {
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView() {
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        
        view.addSubview(upcomingTableView)
    }
}

// MARK: - Table View Protocols
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

