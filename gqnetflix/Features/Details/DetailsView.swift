//
//  DetailsView.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 03.01.2024.
//

import UIKit

protocol DetailsDelegate: AnyObject {}

final class DetailsView: UIView {
    
    weak var delegate: DetailsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension DetailsView {
    func setup() {
        backgroundColor = .white
    }
}
