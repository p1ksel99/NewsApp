//
//  ViewController.swift
//  NewsApp
//
//  Created by Rostyslav Shmorhun on 05.02.2021.
//

import UIKit
import SafariServices


class ViewController: UIViewController  {

    var networkManager = NetworkManager()
    var articles = [Articles]()
    var refresh = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh.addTarget(self, action: #selector(hanleRefresh) , for: .valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
          
        networkManager.fetchData{
            data in
            self.articles = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifir)
        tableView.dataSource = self
        tableView.addSubview(refresh)
    }
    @objc func hanleRefresh() {
        
        refresh.endRefreshing()
    }
}




extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifir, for: indexPath) as! MyTableViewCell
        let index = articles[indexPath.row]
        cell.configure(author: index.author, title: index.title, image: index.urlToImage)
        

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "showDetails", sender: indexPath)
        let news = articles[indexPath.row]
        guard let url = URL(string: news.url) else {
            return
        }
        let config = SFSafariViewController.Configuration()
        let safariViewControler = SFSafariViewController(url: url, configuration: config)
        safariViewControler.modalPresentationStyle = .fullScreen
        present(safariViewControler, animated: true)
    }
}



