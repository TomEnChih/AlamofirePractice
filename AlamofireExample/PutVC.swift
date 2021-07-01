//
//  PutVC.swift
//  AlamofireExample
//
//  Created by 董恩志 on 2021/6/22.
//

import UIKit
import Alamofire


class PutVC: UIViewController,UITextFieldDelegate {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "nil"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var jobLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "nil"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let nameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "name..."
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .default
        return textField
    }()
    
    let jobTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "job..."
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .default
        return textField
    }()
    
    let updateBtn: UIButton = {
        let button = UIButton()
        button.setTitle("更新", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(AFUpdate), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Autolayout
    
    func autoLayout() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
        }
        
        jobLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(jobTF)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
        }
        
        nameTF.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.width.equalTo(200)
        }
        
        jobTF.snp.makeConstraints { (make) in
            make.top.equalTo(nameTF.snp.bottom).offset(10)
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.width.equalTo(200)
        }
        
        updateBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(jobTF.snp.bottom).offset(50)
            make.width.equalTo(100)
        }
        
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(jobLabel)
        view.addSubview(nameTF)
        view.addSubview(jobTF)
        view.addSubview(updateBtn)
        autoLayout()
        
        nameTF.delegate = self
        jobTF.delegate = self
        
        // 沒有用
        downLoading()
        
    }
    
    // MARK: - Methods
    
    @objc func AFUpdate() {
        
        let user = UpdateUserBody(name: nameTF.text ?? "tom", job: jobTF.text ?? "iOS engineer")
        
        AF.request("https://reqres.in/api/users/2",
                   method: .put,
                   parameters: user).response { response in
                    
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let createUserResponse = try decoder.decode(UpdateUserResponse.self, from: data)
                            self.nameLabel.text = createUserResponse.name
                            self.jobLabel.text = createUserResponse.job
                            
                        }
                        catch {
                            print(response.error)
                        }
                    }
                    
                   }
        
    }
    
    func downLoading() {
        
        AF.request("https://reqres.in/api/users/2").response { response in
            if let error = response.error {
                print("Error = \(error)")
                return
            }
            
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            
            if let dataModel = try? decoder.decode(UpdateUserResponse.self, from: data) {
                self.nameLabel.text = dataModel.name
                self.jobLabel.text = dataModel.job
            }
        }
    }
    
    
    
}
