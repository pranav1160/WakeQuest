//
//  BalloonView.swift
//  WakeQuest
//
//  Created by Pranav on 02/08/25.
//


import SwiftUI

import SwiftUI

struct BalloonView: View {
  
   

    let option: Int
    @State private var floatDown = false
    let startOffset: CGFloat // Start 200 points above
    let endOffset:CGFloat
    let color1:Color
    let color2:Color
    @State private var isPopped = false
    @State private var hideBalloon = false
    
    var body: some View {
        if !hideBalloon{
            ZStack {
                // Balloon string
                Path { path in
                    path.move(to: CGPoint(x: 50, y: 110))
                    path.addCurve(to: CGPoint(x: 50, y: 180),
                                  control1: CGPoint(x: 40, y: 130),
                                  control2: CGPoint(x: 60, y: 160))
                }
                .stroke(Color.gray, lineWidth: 2)
                
                // Balloon body
                VStack{
                    Ellipse()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [color1, color2]),
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(width: 100, height: 110)
                        .overlay(
                            Ellipse()
                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
                                .blur(radius: 1)
                                .overlay(
                                    Text("\(option)")
                                        .font(.system(size: 40).bold())
                                        .foregroundStyle(.black)
                                )
                        )
                }
                .scaleEffect(isPopped ? 1.6 : 0.8)
                
            }
            .frame(width: 100, height: 200)
            .offset(y: floatDown ? endOffset : startOffset)
            .onAppear {
                withAnimation(.easeOut(duration: 12)) {
                                floatDown = true
                }
            }
            .onTapGesture {
                withAnimation {
                    isPopped = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        hideBalloon = true
                    }
                }
                
            }
        }
       
        
        
    }
}



#Preview {
    ZStack {
        Color.blue.opacity(0.1).ignoresSafeArea()
        BalloonView(
            option: 23,
            startOffset: 0,
            endOffset: 400,
            color1: .yellow,
            color2: .red
        )
    }
}


