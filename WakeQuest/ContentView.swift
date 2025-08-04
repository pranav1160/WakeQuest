//
//  ContentView.swift
//  WakeQuest
//
//  Created by Pranav on 02/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showMathView = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding()
            
            Button("Math"){
                showMathView = true
            }
            .buttonStyle(.borderedProminent)
            
        }
        .sheet(isPresented: $showMathView, content: {
            NavigationStack {
                MathSetView()
                    .presentationDetents([.large])
            }
               
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
