import SwiftUI

struct MainView: View {
    @State private var showCredits = false
    
    var body: some View {
        ZStack {
            Color("SecondaryContainer")
                .ignoresSafeArea()
            
            AppNavigation()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showCredits = true
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showCredits) {
            CreditsView()
        }
    }
}

// Pantalla de créditos (popup modal)
struct CreditsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("About the App")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView {
                Text("""
                Muskly is an app to keep you motivated at the gym with the help of a virtual pet.
                Track your routines and complete challenges to boost your progress.

                By completing workouts and challenges, you help your pet improve its fitness.
                The points you earn can be used to unlock clothing, accessories, and skins,
                making training more fun and motivating.
                """)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            }
            
            Text("""
            Credits:
            Alison Daniela Ruiz
            Juan José Ángel Durán
            """)
            .font(.headline)
            .multilineTextAlignment(.center)
            
            Button("Close") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding()
        .presentationDetents([.fraction(0.8)])
    }
}

#Preview {
    MainView()
}
