//
//  HTTPClient.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,responseModel: T.Type) async -> Result<T,Error>
}
