//
//  HomeViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit
import Combine
import SnapKit

final class HomeViewController: UIViewController {
    
    private var disposalBag = Set<AnyCancellable>()
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Configure
private extension HomeViewController {
    func setup() {
        view.backgroundColor = .black
        configureNavBar()
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavBar() {
        let image = UIImage(named: Assets.netflixLogo)?
            .withRenderingMode(.alwaysOriginal)
            .resizeTo(size: CGSize(width: 25, height: 25))
        
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: Symbols.person()), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: Symbols.play()), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .red
    }
}

// MARK: - Delegate
extension HomeViewController: HomeDelegate {
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
    
    func tranfsorm(with offset: CGFloat) {
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, offset))
    }
}
