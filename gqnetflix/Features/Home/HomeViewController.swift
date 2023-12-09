//
//  HomeViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var homeFeedTable: UITableView = {
        let table = UITableView()
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

private extension HomeViewController {
    func setUp() {
        view.backgroundColor = .systemBackground
        
        setUpTableView()
    }
    
    func setUpTableView() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        view.addSubview(homeFeedTable)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionViewTableViewCell.identifier,
            for: indexPath) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
