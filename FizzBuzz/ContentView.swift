//
//  ContentView.swift
//  FizzBuzz
//
//  Created by Luke Drushell on 5/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var onboarding = false
    
    @State var digit = 1
    @State var playing = false
    @State var difficulty: String = "Solo"
    @State var options = ["Solo", "Easy", "Medium", "Impossible"]
    @State var gameState = 0
    @State var numbers: [Int] = [1, 2, 3]
    @State var winLoss = "Lose"
    @State var botGuessing = false
    // gameState 0 is nothing, 1 is correct answer, 2 is wrong answer
    var device = deviceScreen()
    
    @State var won = false
    
    @State private var countdown = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    fileprivate func updateDigits() {
        let nums = pickDigits(digit)
        numbers[0] = nums.0
        numbers[1] = nums.1
        numbers[2] = nums.2
    }
    
    fileprivate func correctAnswer() {
        switch difficulty {
        case "Solo":
            digit += 1
            countdown = 5
            gameState = 1
            updateDigits()
        case "Easy":
            digit += 1
            countdown = 5
            gameState = 1
            botGuessing = true
            winLoss = "Win"
            let guess = Int.random(in: 0...5)
            var durationNum = Int.random(in: 1...6)
            if durationNum == 5 { durationNum = 6 }
            let duration = DispatchTimeInterval.seconds(durationNum)
            if durationNum < 6 {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                    if guess != 4 {
                        botGuessing = false
                        digit += 1
                        countdown = 5
                        winLoss = "Lose!"
                        updateDigits()
                    } else {
                        botGuessing = false
                        winLoss = "Win"
                        gameState = 0
                        countdown = 5
                        won = true
                    }
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                        botGuessing = false
                        winLoss = "Win"
                        gameState = 0
                        won = true
                })
            }
        case "Medium":
            digit += 1
            countdown = 5
            gameState = 1
            botGuessing = true
            winLoss = "Win"
            let guess = Int.random(in: 0...10)
            let durationNum = Int.random(in: 1...4)
            let duration = DispatchTimeInterval.seconds(durationNum)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                if guess != 4 {
                    botGuessing = false
                    digit += 1
                    countdown = 5
                    winLoss = "Lose"
                    updateDigits()
                } else {
                    botGuessing = false
                    winLoss = "Win"
                    gameState = 0
                    won = true
                }
            })
        default:
            digit += 1
            countdown = 5
            gameState = 1
            botGuessing = true
            winLoss = "Win"
            let guess = Int.random(in: 0...100)
            let durationNum = Int.random(in: 1...2)
            let duration = DispatchTimeInterval.seconds(durationNum)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                if guess != 4 {
                    botGuessing = false
                    digit += 1
                    countdown = 5
                    winLoss = "Lose"
                    updateDigits()
                } else {
                    botGuessing = false
                    winLoss = "Win"
                    gameState = 0
                    won = true
                }
            })
        }
    }
    
    fileprivate func wrongAnswer() {
        gameState = 2
        updateDigits()
    }
    
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            if gameState == 1 {
                Color.green.edgesIgnoringSafeArea(.all)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            gameState = 0
                        })
                    })
            } else if gameState == 2 {
                Color.red.edgesIgnoringSafeArea(.all)
            }
            VStack {
                Picker("Difficulty", selection: $difficulty, content: {
                    ForEach(options, id: \.self, content: { option in
                        Text(option)
                    })
                })
                .pickerStyle(.segmented)
                .padding()
                Divider()
                Spacer()
                if countdown != -1 {
                    Text("\(countdown)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Text("\(botGuessing == true ? "Opponent is Guessing" : "")")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                } else {
                    Text("You \(winLoss)!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Text("Score: \(digit - 1)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .onAppear(perform: {
                            if winLoss == "Lose" {
                                gameState = 2
                            }
                        })
                    Button {
                        countdown = 5
                        digit = 1
                        gameState = 0
                        updateDigits()
                        botGuessing = false
                        won = false
                    } label: {
                        Text("Tap to Start Again")
                            .foregroundColor(.white)
                            .frame(width: device.width * 0.8, height: 80, alignment: .center)
                            .background(.green)
                            .cornerRadius(15)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: 4)
                            })
                    }
                }
                Spacer()
                VStack(spacing: 13) {
                    Divider()
                    HStack(spacing: 13) {
                        Button {
                            if fbCheck(digit) == "\(numbers[0])" {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        } label: {
                            Text("\(numbers[0])")
                                .foregroundColor(.white)
                                .frame(width: device.width * 0.24, height: 80, alignment: .center)
                                .background(.orange)
                                .cornerRadius(15)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.white, lineWidth: 4)
                                })
                        }
                        Button {
                            if fbCheck(digit) == "\(numbers[1])" {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        } label: {
                            Text("\(numbers[1])")
                                .foregroundColor(.white)
                                .frame(width: device.width * 0.24, height: 80, alignment: .center)
                                .background(.orange)
                                .cornerRadius(15)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.white, lineWidth: 4)
                                })
                        }
                        Button {
                            if fbCheck(digit) == "\(numbers[2])" {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        } label: {
                            Text("\(numbers[2])")
                                .foregroundColor(.white)
                                .frame(width: device.width * 0.24, height: 80, alignment: .center)
                                .background(.orange)
                                .cornerRadius(15)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.white, lineWidth: 4)
                                })
                        }
                    }
                    HStack(spacing: 12) {
                        Button {
                            if fbCheck(digit) == "Fizz" {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        } label: {
                            Text("Fizz")
                                .foregroundColor(.white)
                                .frame(width: device.width * 0.38, height: 80, alignment: .center)
                                .background(.cyan)
                                .cornerRadius(15)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.white, lineWidth: 4)
                                })
                        }
                        Button {
                            if fbCheck(digit) == "Buzz" {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        } label: {
                            Text("Buzz")
                                .foregroundColor(.white)
                                .frame(width: device.width * 0.38, height: 80, alignment: .center)
                                .background(.pink)
                                .cornerRadius(15)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.white, lineWidth: 4)
                                })
                        }
                    }
                    Button {
                        if fbCheck(digit) == "FizzBuzz" {
                            correctAnswer()
                        } else {
                            wrongAnswer()
                        }
                    } label: {
                        Text("FizzBuzz")
                            .foregroundColor(.white)
                            .frame(width: device.width * 0.8, height: 80, alignment: .center)
                            .background(.indigo)
                            .cornerRadius(15)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: 4)
                            })
                    }
                } .overlay(content: {
                    if gameState == 2 || botGuessing || countdown == -1 {
                        Color.gray.edgesIgnoringSafeArea(.all).opacity(0.5).onTapGesture(perform: {
                            
                        })
                    }
                })
            }
        }
        .onAppear(perform: {
            if isFirstTimeOpening() != false {
                onboarding = true
            }
        })
        .onReceive(timer) { time in
            if gameState == 2 {
                 countdown = -1
            }
            if countdown >= 0 {
                countdown -= 1
            } else {
                if won == false {
                    gameState = 2
                }
            }
        }
        .onChange(of: onboarding, perform: { i in
            countdown = 5
            digit = 1
            gameState = 0
            updateDigits()
            botGuessing = false
            won = false
        })
        .sheet(isPresented: $onboarding, content: {
            OnboardingSheetView(onboarding: $onboarding)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func pickDigits(_ num: Int) -> (Int, Int, Int) {
    let correct = Int.random(in: 0...2)
    var output = [0, 0, 0]
    let less = num - 3
    let more = num + 3
    if correct == 0 {
        output[0] = num
        output[1] = Int.random(in: less...more)
        output[2] = Int.random(in: less...more)
    } else if correct == 1 {
        output[1] = num
        output[0] = Int.random(in: less...more)
        output[2] = Int.random(in: less...more)
    } else {
        output[2] = num
        output[0] = Int.random(in: less...more)
        output[1] = Int.random(in: less...more)
    }
    return (output[0], output[1], output[2])
}


func fbCheck(_ num: Int) -> String {
    var output = "\(num)"
    if num % 3 == 0 {
        output = "Fizz"
    }
    if num % 5 == 0 {
        output = "Buzz"
    }
    if num % 3 == 0 && num % 5 == 0 {
        output = "FizzBuzz"
    }
    return output
}

class deviceScreen: ObservableObject {
    @Published var width = UIScreen.main.bounds.width
    @Published var height = UIScreen.main.bounds.height
}

func isFirstTimeOpening() -> Bool {
  let defaults = UserDefaults.standard

  if(defaults.integer(forKey: "hasRun") == 0) {
      defaults.set(1, forKey: "hasRun")
      return true
  }
  return false

}
