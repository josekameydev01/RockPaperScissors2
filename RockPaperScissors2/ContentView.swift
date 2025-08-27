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
    @State private var appChoice = (Moves.allCases.randomElement() ?? .paper).rawValue
    @State private var userChoice = Moves.paper.rawValue
    @State private var userShouldWin = Bool.random()
    @State private var showFeedbackAlert = false
    @State private var showGameOverAlert = false
    
    enum RoundResult{
        case win, lose
    }
    
    enum Moves: String, CaseIterable{
        case paper = "paper"
        case rock = "rock"
        case scissors = "scissors"
    }
    
    private let moves = Moves.allCases.map { $0.rawValue }
    
    var roundResult: RoundResult {
        let paper = Moves.paper.rawValue
        let rock = Moves.rock.rawValue
        let scissors = Moves.scissors.rawValue
        
        let condition1 = appChoice == paper && userChoice == scissors
        let condition2 = appChoice == rock && userChoice == paper
        let condition3 = appChoice == scissors && userChoice == rock
        
        if userShouldWin && condition1 || condition2 || condition3 {
            return .win
        } else if !userShouldWin && !condition1 && !condition2 && !condition3 {
            return .win
        }
                    
        return .lose
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack(spacing: 0){
                    Text("App choice: ")
                    Text("\(appChoice)")
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
                                startRound(with: currentMove)
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
                Text("Player score: \(score)")
                    .fontWeight(.bold)
                Spacer()
                Text("\(numOfQuestion) / 10")
                Spacer()
            }
            .navigationTitle("RockPaperScissors2")
            .alert("Game Over", isPresented: $showGameOverAlert) {
                Button("Play Again!", action: resetGame)
            }message: {
                Text("The game is over, your final score is \(score)")
            }
            .alert(roundResult == .win ? "You Win!" : "You Lose!", isPresented: $showFeedbackAlert) {
                Button("OK", action: getNextRound)
            } message: {
                Text(roundResult == .win ? "You win 1 point! 😁" : "You lose 1 point 😔")
            }
        }
    }
    private func startRound(with userChoice: String) {
        if roundResult == .win {
            score += 1
        } else {
            score -= 1
        }
        
        self.userChoice = userChoice
        
        showFeedbackAlert = true
        
    }
    private func getNextRound() {
        if numOfQuestion >= 10 {
            showGameOverAlert = true
        } else {
            numOfQuestion += 1
        }
        
        appChoice = (Moves.allCases.randomElement() ?? .paper).rawValue
        userShouldWin = Bool.random()
    }
    private func resetGame() {
        showFeedbackAlert = false
        showGameOverAlert = false
        score = 0
        numOfQuestion = 1
        appChoice = (Moves.allCases.randomElement() ?? .paper).rawValue
        userShouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
