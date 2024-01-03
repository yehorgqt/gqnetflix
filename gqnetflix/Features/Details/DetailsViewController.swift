//
//  DetailsViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 17.12.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private lazy var detailsView: DetailsView = {
        let view = DetailsView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension DetailsViewController {
    func setup() {
        view.addSubview(detailsView)
        
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate
extension DetailsViewController: DetailsDelegate {}
