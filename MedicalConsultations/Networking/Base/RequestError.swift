//
//  RequestError.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case notAuthorized
    case unknown
    case custom(_ error: [String: Any]?)
    
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Erro de decodificacao"
        case .invalidURL:
            return "URL invalida"
        case .noResponse:
            return "sem resposta"
        case .notAuthorized:
            return "usuario nao autorizado"
        case .unknown:
            return "erro desconhecido"
        case .custom(_):
            return "erro:"
//        default:
//            return "erro desconhecido"
        }
    }
}
