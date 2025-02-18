//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by Andrew on 05.02.2025.
//

import SwiftUI

private enum Constants {
    static let countFlags: Int = 3
    static let limitCountGame: Int = 4
}

struct ContentView: View {
    
    @State private var gameScore: Int = 0
    @State private var countToRestart: Int = Constants.limitCountGame
    @State private var countries: [String] = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
        "Poland", "Spain", "UK", "Ukraine", "US"
    ].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0..<Constants.countFlags)
    @State private var alertTitle: String = ""
    @State private var isPresentedAlert: Bool = false
    @State private var isPresentedResetGame: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.headline.bold())
                            .foregroundStyle(.primary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.bold())
                            .foregroundStyle(.primary)
                    }
                    ForEach(0..<Constants.countFlags) { index in
                        Button {
                            flagTapped(index: index)
                        } label: {
                            Image(countries[index])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(gameScore)")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
            .alert(alertTitle, isPresented: $isPresentedAlert) {
                Button("Continue", action: continueTapped)
            } message: {
                Text("Your score is \(gameScore)")
            }
            .alert("Game finished", isPresented: $isPresentedResetGame) {
                Button("Restart", action: restartGame)
            }
        }
    }
    
    // MARK: - Private
    
    private func flagTapped(index: Int) {
        if index == correctAnswer {
            alertTitle = "Correct"
            gameScore += 1
        } else {
            alertTitle = "Incorrect"
            gameScore -= 1
        }
        isPresentedAlert = true
    }
    
    private func continueTapped() {
        countToRestart -= 1
        guard countToRestart > 0 else {
            isPresentedResetGame = true
            return
        }
        changeQuestion()
    }
    
    private func changeQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<Constants.countFlags)
    }
    
    private func restartGame() {
        gameScore = 0
        countToRestart = Constants.limitCountGame
        changeQuestion()
    }
}

#Preview {
    ContentView()
}
