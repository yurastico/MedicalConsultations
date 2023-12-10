//
//  HTTPClient.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,responseModel: T.Type?) async -> Result<T?,RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,responseModel: T.Type?) async -> Result<T?,RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.schema
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = 3000 // nao ta no endpoint pq eh local, quando rodar em alguma aplicacao em prod, nao precisara disso
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data,response) = try await URLSession.shared.data(for: request,delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let responseModel = responseModel else {
                    return .success(nil)
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
            case 401:
                return .failure(.notAuthorized)
            
            default:
                return .failure(.unknown)
            }
            
        } catch {
            return .failure(.unknown)
        }
        
    }
}
