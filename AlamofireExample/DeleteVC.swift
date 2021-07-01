//
//  DeleteVC.swift
//  AlamofireExample
//
//  Created by 董恩志 on 2021/6/21.
//

import UIKit
import Alamofire

class DeleteVC: UIViewController {

    let deleteBtn: UIButton = {
        let button = UIButton()
        button.setTitle("刪除", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(AFDeleteData), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(deleteBtn)
        autoLayout()
    }
    
    func autoLayout() {
        deleteBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    @objc func deleteData() {
        let url = URL(string: "https://reqres.in/api/users/2")!
        var request = URLRequest(url: url)
        request.httpMethod = "delete"
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.headers)
            }
        }.resume()
        
    }
    
    @objc func AFDeleteData() {
        AF.request("https://reqres.in/api/users/2",method: .delete).response{ response in
            if let status = response.response{
                print(status.statusCode)
            }
        }
    }
    
}
