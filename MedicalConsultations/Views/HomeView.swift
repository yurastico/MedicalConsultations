//
//  HomeView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 02/11/23.
//

import SwiftUI

struct HomeView: View {
    
    let viewModel = HomeViewModel(service: HomeNetworkingService(),authService: AuthenticationService())
    @State private var specialists: [Specialist] = []
    @State private var isShowingSnackBar = false
    @State private var errorMessage = ""
    @State private var isFetchingData = true
    var body: some View {
        ZStack {
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
                    if isFetchingData {
                        SkeletonView()
                    } else {
                        ForEach(specialists) { specialist in
                            SpecialistCardView(specialist: specialist)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .onAppear {
                Task {
                    do {
                        isFetchingData = false
                        guard let response = try await viewModel.getSpecialists() else {
                            return
                        }
                        self.specialists = response
                    } catch {
                        isShowingSnackBar = true
                        let errorType = error as? RequestError
                        errorMessage = errorType?.customMessage ?? "Ops, ocorreu um erro!"
                    }
                
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.logout()
                        }
                    } label: {
                        HStack(spacing: 2) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Logout")
                        }
                    }
                }
            }
            if isShowingSnackBar {
                SnackBarErrorView(isShowing: $isShowingSnackBar, message: errorMessage)
            }
        }
    }
}

#Preview {
    HomeView()
}
