//
//  DetailsViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 17.12.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    let movie: MovieViewModel

    private lazy var detailsView: DetailsView = {
        let view = DetailsView()
        view.delegate = self
        return view
    }()

    init(movie: MovieViewModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
private extension DetailsViewController {
    func setup() {
        detailsView.configure(with: movie)
        view.addSubview(detailsView)

        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate
extension DetailsViewController: DetailsDelegate {}
