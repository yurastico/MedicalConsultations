//
//  SignInView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import SwiftUI

struct SignInView: View {
    let service = WebService()
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    var authManager = AuthenticationManager.shared
    
    private func login() async {
        do {
            if let response = try await service.loginPatient(email: email, password: password) {
                authManager.saveToken(token: response.token)
                authManager.savePatientId(id: response.id)
            } else {
                showingAlert = true
            }
        } catch(let error) {
            showingAlert = true
            print("Ocorreu um erro no login: \(error)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,maxHeight: 36)
            
            Text("Ola!")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            
            Text("Preencha para acessar sua conta.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            Text("Email")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            TextField("Digite seu Email", text: $email)
                .padding(14)
                .background(Color.gray.opacity(0.24))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            Text("Senha")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            SecureField("Digite sua senha.", text: $password)
                .padding(14)
                .background(Color.gray.opacity(0.24))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            
           
            
            Button {
                Task {
                    await login()
                }
            } label: {
                ButtonView(text: "Entrar")
            }
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("Ainda não possui uma conta? cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .center)
            }
            
        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert("Ops! Algo deu errado.",isPresented: $showingAlert) {
            Button {
                
            } label: {
                Text("OK")
            }
        } message: {
            Text("Houve um erro ao entrar na sua conta. Por favor tente novamente.")
        }
    }
}

#Preview {
    SignInView()
}
