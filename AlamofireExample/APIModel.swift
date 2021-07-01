//
//  APIModel.swift
//  AlamofireExample
//
//  Created by 董恩志 on 2021/6/21.
//

import Foundation

// MARK: - APIModel
struct APIModel: Codable {
    let page, perPage, total, totalPages: Int
    let data: [Datum]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}



// MARK: - Post Example
struct CreateUserBody: Encodable {
    let email: String
    let password: String
}

struct CreateUserResponse: Decodable {
    let id: Int
    let token: String
}





// MARK: - Update
struct UpdateUserBody: Encodable {
    let name: String
    let job: String
}
struct UpdateUserResponse: Decodable {
    let name: String
    let job: String
}

