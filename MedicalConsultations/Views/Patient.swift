//
//  Patient.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

struct Patient: Identifiable,Codable {
    let id: String?
    let cpf: String
    let name: String
    let phoneNumber: String
    let password: String
    let email: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cpf
        case name = "nome"
        case email
        case password
        case phoneNumber = "telefone"
        case healthPlan = "planoSaude"
    }
}
