//
//  CollectionViewTableViewCell.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    static let identifier = "CollectionViewTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemIndigo
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
