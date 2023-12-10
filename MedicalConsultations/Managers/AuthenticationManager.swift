//
//  AuthenticationManager.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation


final class AuthenticationManager: ObservableObject { //usar observable!!!!
    static let tokenKey = "app-vollmed-token"
    static let patientIdKey = "app-vollmed-patient-id"
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientId: String? // usar @observable futuramente
    
    private init() {
        self.token = KeychainHelper.get(for: AuthenticationManager.tokenKey)
        self.patientId = KeychainHelper.get(for: AuthenticationManager.patientIdKey)
    }
    
    func saveToken(token: String) {
        Task {
            KeychainHelper.save(value: token, key: AuthenticationManager.tokenKey)
            self.token = token
        }
    }
    
    func removeToken() {
        Task {
            KeychainHelper.remove(for: AuthenticationManager.tokenKey)
            self.token = nil
        }
    }
    
    func savePatientId(id: String) {
        Task {
            KeychainHelper.save(value: id, key: AuthenticationManager.patientIdKey)
            self.patientId = id
        }
    }
    
    func removePatientId() {
        KeychainHelper.remove(for: AuthenticationManager.patientIdKey)
        self.patientId = nil
    }
}
