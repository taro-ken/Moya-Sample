//
//  ViewController.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/15.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: TableViewCell.className, bundle: nil), forCellReuseIdentifier: TableViewCell.className)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var items: [GithubModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = false
        indicator.isHidden = true
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.tableView.isHidden = false
            GithubAPI.user.get { result in
                switch result {
                case.failure(let error):
                    print(error)
                case.success(let response):
                    print(response)
                    self.items = response
                    self.tableView.reloadData()
                }
            }
        }
    }
}
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Router.shared.showWeb(from: self, githubModel: items[indexPath.item])
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.className) as? TableViewCell else {
            fatalError()
        }
        let githubModel = items[indexPath.item]
        
        cell.configure(githubModel: githubModel)
        return cell
    }
}
