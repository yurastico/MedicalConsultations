//
//  HomeViewModel.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

struct HomeViewModel {
    //MARK - Attributes
    let service: HomeServiceable
    
    
    let authManager = AuthenticationManager.shared
    
    
    //MARK - Init
    
    init(service: HomeServiceable) {
        self.service = service
    }
    
    //MARK - Class methods
    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    func logout() async {
        let oldService = WebService()
        do {
            let logoutSuccessful = try await oldService.logoutPatient()
            if logoutSuccessful {
                authManager.removeToken()
                authManager.removePatientId()
            }
        } catch {
            print("erro no logout \(error)")
        }
    }
    
}
