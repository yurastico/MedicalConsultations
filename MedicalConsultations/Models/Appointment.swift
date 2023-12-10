//
//  Appointment.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 02/11/23.
//

import Foundation

struct Appointment: Codable,Identifiable {
    let id: String
    let date: String
    let specialist: Specialist
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}
