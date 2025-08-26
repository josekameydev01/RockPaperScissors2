//
//  ContentView.swift
//  RockPaperScissors2
//
//  Created by carlosgalvankamey on 8/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var numOfQuestion = 1
    @State private var score = 0
    @State private var appChoice = "paper"
    @State private var userShouldWin = false
    
    enum RoundResult{
        case win, lose
    }
    
    enum Moves: String, CaseIterable{
        case paper = "paper"
        case rock = "rock"
        case scissors = "scissors"
    }
    
    private let moves = Moves.allCases.map { $0.rawValue }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("App choice")
                Text("The user should win")
                Spacer()
                Spacer()
                VStack(spacing: 25) {
                    ForEach(0..<3) { number in
                        let currentMove = moves[number]
                        VStack {
                            Button {
                                // TODO: Add functionality
                            } label: {
                                Image(currentMove)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                            Text(currentMove)
                                .fontWeight(.bold)
                        }
                    }
                }
                Spacer()
                Spacer()
                Text("\(numOfQuestion) / 10")
                Spacer()
            }
            .navigationTitle("RockPaperScissors2")
        }
    }
}

#Preview {
    ContentView()
}
