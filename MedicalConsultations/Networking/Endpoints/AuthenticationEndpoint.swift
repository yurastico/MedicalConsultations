//
//  AuthenticationEndpoint.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

enum AuthenticationEndpoint {
    case logout
}

extension AuthenticationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .logout:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .logout:
            guard let token = AuthenticationManager.shared.token else { return nil }
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .logout:
            return nil
        }
    }
    
    
}
