//
//  NetflixMainButton.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import UIKit

final class NetflixMainButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setUp()
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension NetflixMainButton {
    func setUp() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
    }
}
