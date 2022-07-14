//
//  MainTableViewController.swift
//  VKChallenge
//
//  Created by Nikita Nesporov on 14.07.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
     
    private let networkManager = NetworkManager()
    private var services: [Service] = [] 
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        getData()
        setupNavBar()
    }
     
    private func getData() {
        let baseURL = Constants.jsonUrl
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    private func setupTable() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        tableView.backgroundColor = .black
    }
    
    private func setupNavBar() {
        title = "Сервисы VK"
    }
    
    func openService(from url: String) {
        if let url =  URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 90
        return services.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID,
                                                    for: indexPath) as? TableViewCell{
            cell.backgroundColor = .black
            let service = services[indexPath.row]
            cell.setupCell(model: service)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let serviseURL = services[indexPath.row].link
        openService(from: serviseURL)
    }
}

// MARK: - Extension

extension MainTableViewController: NetworkManagerDelegate {
    func showData(results: [Service]) {
        services = results
        tableView.reloadData()
    }
    
    func showError() {
        let alert = AlertManager.showAlertError(text: "Пожалуйста, проверьте соединение.")
        present(alert, animated: true, completion: nil)
    }
}



