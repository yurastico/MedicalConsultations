//
//  SignUPView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import SwiftUI

struct SignUpView: View {
    
    let service = WebService()
    
    @State private var name = ""
    @State private var email = ""
    @State private var cpf = ""
    @State private var phone = ""
    @State private var healthPlan: String
    @State private var password = ""
    @State private var showAlert = false
    @State private var isPatientRegistered = false
    @State private var navigateToSignInView = false
    
    let healthPlans: [String] = [
    "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "São Francisco Saúde", "Golden Cross", "Medial Saúde", "América Saúde", "Outro"
    ]
    
    init() {
        self.healthPlan = healthPlans[0]
    }
    
    private func register() async {
        let patient = Patient(id: nil, cpf: cpf, name: name, phoneNumber: phone, password: password, email: email, healthPlan: healthPlan)
        do {
            if let _ = try await service.registerPatient(patient: patient) {
                isPatientRegistered = true
               
            } else {
                isPatientRegistered = false
            }
        } catch(let error) {
            isPatientRegistered = false
            print(error)
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 15) {
                
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity,maxHeight: 36,alignment: .center)
                    .padding(.vertical)
                
                Text("Ola, boas vindas")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Insira seus dados para criar uma conta")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu nome completo",text: $name)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .autocorrectionDisabled()
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu Email",text: $email)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu CPF",text: $cpf)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(.numberPad)
                
                Text("Telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu Telefone",text: $cpf)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(.numberPad)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                SecureField("Insira sua senha",text: $password)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                Text("Selecione seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                Picker("Plano de saúde", selection: $healthPlan) {
                    ForEach(healthPlans,id: \.self) { healthPlan in
                        Text(healthPlan)
                    }
                }
                
                Button {
                    Task {
                        await register()
                    }
                } label: {
                    ButtonView(text: "Cadastrar")
                }
                
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Já possui uma conta? Faça o login.")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity,alignment: .center)
                }
                    
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegistered ? "Sucesso!" : "Ops... algo deu errado!",isPresented: $showAlert,presenting: $isPatientRegistered) { _ in
            Button {
                navigateToSignInView = true
            } label: {
                Text("Ok")
            }
        } message: { _ in
            if isPatientRegistered {
                Text("O paciente foi criado com sucesso!")
            } else {
                Text("houve um erro ao cadastrar um paciente!")
            }
        }
        .navigationDestination(isPresented: $navigateToSignInView) {
            SignInView()
        }
        
        
    }
}

#Preview {
    SignUpView()
}
