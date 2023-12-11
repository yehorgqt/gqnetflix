//
//  Collection.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 11.12.2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
