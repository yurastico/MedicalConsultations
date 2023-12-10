//
//  MyAppointmentsView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 02/11/23.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    let authManager = AuthenticationManager.shared
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        guard let patientID = authManager.patientId else {
            return
        }
        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientID: patientID) {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao obter consultas: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            if appointments.isEmpty {
                Text("Não há nenhuma consulta agendada no momento!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.cancel)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    }
                }
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
