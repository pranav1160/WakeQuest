//
//  TimerView.swift
//  WakeQuest
//
//  Created by Pranav on 08/08/25.
//


// File: Views/TimerView.swift
import SwiftUI

struct TimerView: View {
    let timeRemaining: TimeInterval
    let total: TimeInterval

    var body: some View {
        let fraction = total > 0 ? CGFloat(timeRemaining / total) : 0
        VStack(alignment: .leading) {
            ProgressView(value: fraction)
            HStack {
                Text("Time: \(Int(timeRemaining))s")
                    .font(.caption)
                Spacer()
                Text("\(Int(100 * fraction))%")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
}
