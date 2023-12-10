//
//  SignInView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    
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
    }
}

#Preview {
    SignInView()
}
