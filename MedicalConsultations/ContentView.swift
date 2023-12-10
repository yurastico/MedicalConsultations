//
//  ContentView.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 01/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(
                    title: { Text("Home") },
                    icon: { Image(systemName: "house") }
                )
            }
            
            NavigationStack {
                MyAppointmentsView()
            }
            .tabItem {
                Label(
                    title: { Text("Minhas consultas") },
                    icon: { Image(systemName: "calendar") }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
