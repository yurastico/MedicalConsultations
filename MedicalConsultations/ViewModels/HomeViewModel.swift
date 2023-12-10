//
//  HomeViewModel.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

struct HomeViewModel {
    //MARK - Attributes
    let service = WebService()
    
    
    //MARK - Class methods
    func getSpecialists() async throws -> [Specialist] {
        do {
            if let fetchedSpecialists = try await service.getAllSpecialists() {
                
                return fetchedSpecialists
            }
            return []
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error)")
            throw error
        }
    }
}
