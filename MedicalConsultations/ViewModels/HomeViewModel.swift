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
    let authService: AuthenticationServiceable
    
    
    let authManager = AuthenticationManager.shared
    
    
    //MARK - Init
    
    init(service: HomeServiceable,authService: AuthenticationServiceable) {
        self.service = service
        self.authService = authService
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
        let result = await authService.logout()
        switch result {
        case .success(_):
            authManager.removeToken()
            authManager.removePatientId()
        case .failure(let error):
            print(error)
            
        }
       
    }
    
}
