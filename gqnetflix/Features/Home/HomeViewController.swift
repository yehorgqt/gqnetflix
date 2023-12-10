//
//  HomeViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
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

// MARK: - Set up
private extension HomeViewController {
    func setUp() {
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        setUpTableView()
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
    
    func setUpTableView() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        homeFeedTable.tableHeaderView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2))
        
        view.addSubview(homeFeedTable)
    }
}

// MARK: - Table View Protocols
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
