//
//  PostVC.swift
//  AlamofireExample
//
//  Created by 董恩志 on 2021/6/21.
//

import UIKit
import SnapKit
import Alamofire

class PostVC: UIViewController {
    
    // MARK: - Properties
    
    var email = "eve.holt@reqres.in"
    
    var password = "pistol"
    // MARK: - IBOutlets
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Email:"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Password:"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let emailTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email..."
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .default
        textField.addTarget(self, action: #selector(enterEmail), for: .editingChanged)
        return textField
    }()
    
    let passwordTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password..."
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .default
        textField.addTarget(self, action: #selector(enterPassword), for: .editingChanged)
        return textField
    }()
    
    let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("登錄", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(AFlogin), for: .touchUpInside)
        return button
    }()
    // MARK: - Autolayout
    
    func autoLayout() {
        emailLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordTF)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
        }
        
        emailTF.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(emailLabel.snp.right).offset(5)
            make.width.equalTo(200)
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(emailTF.snp.bottom).offset(10)
            make.left.equalTo(emailLabel.snp.right).offset(5)
            make.width.equalTo(200)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(50)
            make.width.equalTo(100)
        }
        
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(loginBtn)
        autoLayout()
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailTF.text = email
        passwordTF.text = password
    }
    
    // MARK: - Methods
    
    @objc func enterEmail() {
        if let text = emailTF.text {
            email = text
        }
    }
    
    @objc func enterPassword() {
        if let text = passwordTF.text {
            password = text
        }
    }
    
    @objc func login() {
        let url = URL(string: "https://reqres.in/api/register")
        var request = URLRequest(url: url!)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let user = CreateUserBody(email: email, password: password)
        let data = try? encoder.encode(user)
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let createUserResponse = try decoder.decode(CreateUserResponse.self, from: data)
                        print(createUserResponse.token)
                        self.postResult(token: createUserResponse.token)
                    }
                    catch {
                        print(error)
                    }
                }
                
            }
        }.resume()
        
    }
    
    @objc func AFlogin() {
        
        let user = CreateUserBody(email: email, password: password)
        
        AF.request("https://reqres.in/api/register",
                   method: .post,
                   parameters: user).response { response in
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let createUserResponse = try decoder.decode(CreateUserResponse.self, from: data)
                            self.postResult(token: createUserResponse.token)
                            print(createUserResponse.token)
                        }
                        catch {
                            print(response.error)
                        }
                    }
                   }
    }
 
    
    @objc func AFlogin2() {
        let user = CreateUserBody(email: email, password: password)
        
        AF.request("https://reqres.in/api/register",
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: CreateUserResponse.self) { (response) in
                    print(response.description)
                   }
        
    }
    
    
    func postResult(token: String) {
        
        let alert = UIAlertController(title: "成功",
                                      message: "取得 token: \(token)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITextFieldDelegate
extension PostVC: UITextFieldDelegate {
    
}
