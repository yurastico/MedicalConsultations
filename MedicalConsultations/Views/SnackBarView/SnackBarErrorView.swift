//
//  SnackBarErrorView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 11/12/23.
//

import SwiftUI

struct SnackBarErrorView: View {
    @Binding var isShowing: Bool
    var message: String
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
    }
}

#Preview {
    SnackBarErrorView(isShowing: .constant(true),message: "Erro! tente novamente mais tarde")
}
