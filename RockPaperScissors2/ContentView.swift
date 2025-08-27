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
    @State private var appChoice = Moves.allCases.randomElement() ?? .paper
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
                HStack(spacing: 0){
                    Text("App choice: ")
                    Text("\(appChoice.rawValue)")
                        .fontWeight(.bold)
                }
                HStack(spacing: 0) {
                    Text("The user should ")
                    Text(userShouldWin ? "win" : "lose")
                        .fontWeight(.bold)
                }
                Spacer()
                Spacer()
                VStack(spacing: 25) {
                    ForEach(0..<3) { number in
                        let currentMove = moves[number]
                        VStack {
                            Button {
                                startRound()
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
    private func startRound() {
        appChoice = Moves.allCases.randomElement() ?? .paper
        userShouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
