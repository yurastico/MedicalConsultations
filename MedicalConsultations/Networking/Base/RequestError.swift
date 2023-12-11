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
        case .custom(let errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["mensagem"] as? String ?? "Erro desconhecido"
                return message
            }
            return "Ops, ocorreu um erro ao carregar"
//        default:
//            return "erro desconhecido"
        }
    }
}
