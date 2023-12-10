//
//  Login.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
    
    
}
struct LoginResponse: Codable, Identifiable {
    let auth: Bool
    let id: String
    let token: String
}
