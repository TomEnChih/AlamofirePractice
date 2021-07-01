//
//  ViewController.swift
//  AlamofireExample
//
//  Created by 董恩志 on 2021/6/21.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    // MARK: - Properties
    var data:[Datum] = []{
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .white
        return tv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下載", style: .plain, target: self, action: #selector(AFloadingData))
        
        
    }

    // MARK: - Methods
    @objc func loadingData() {
        let url = URL(string: "https://reqres.in/api/users?page=2")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            if let dataModel = try? decoder.decode(APIModel.self, from: data) {
                self.data = dataModel.data
            }
        }.resume()
    }
    
    
    @objc func AFloadingData() {
        
        AF.request("https://reqres.in/api/users?page=2").response { response in
            if let error = response.error {
                print("Error = \(error)")
                return
            }
            
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            
            if let dataModel = try? decoder.decode(APIModel.self, from: data) {
                    self.data = dataModel.data
            }
        }
        
    }
    
    

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].firstName + " - " + data[indexPath.row].lastName
        
        return cell
    }
    
    
}
