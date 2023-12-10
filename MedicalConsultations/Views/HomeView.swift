//
//  HomeView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 02/11/23.
//

import SwiftUI

struct HomeView: View {
    
    let service = WebService()
    let authManager = AuthenticationManager.shared
    @State private var specialists: [Specialist] = []
    
    private func logout() async {
        do {
            let logoutSuccessful = try await service.logoutPatient()
            if logoutSuccessful {
                authManager.removeToken()
                authManager.removePatientId()
            }
        } catch {
            print("erro no logout \(error)")
        }
    }
    
    private func getSpecialists() async {
        do {
            if let specialists = try await service.getAllSpecialists() {
                
                self.specialists = specialists
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error)")
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            Task {
                await getSpecialists()
            
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await logout()
                    }
                } label: {
                    HStack(spacing: 2) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
