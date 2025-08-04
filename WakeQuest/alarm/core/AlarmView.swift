//
//  AlarmView.swift
//  WakeQuest
//
//  Created by Pranav on 04/08/25.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Image(.wakeUpBaby)
                .resizable()
                .scaledToFill()
                
            Text("Wake up baby")
                .font(.largeTitle)
                .bold()
                .padding(.leading,100)
                .padding(.bottom,50)
                
           
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AlarmView()
}
