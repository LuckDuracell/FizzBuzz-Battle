//
//  OnboardingPage3.swift
//  FizzBuzz
//
//  Created by Luke Drushell on 5/30/22.
//

import SwiftUI

struct OnboardingPage3: View {
    
    @Binding var onboarding: Bool
    var device = deviceScreen()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Okay okay okay, last thing, we promise.")
                .bold()
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Text("There are some AI to compete against.")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            VStack {
            Text("Theres Easy, Medium, and Impossible. These will respond to your answers, so you'll be answering back and fourth as you go, as in:")
                .bold()
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("You say 1, it says 2, you say Fizz, it says 4, you say Buzz, it says Fizz, which goes on until either you or it makes a mistake.")
                .bold()
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            }
            Spacer()
            Button {
                onboarding = false
            } label: {
                Text("And Begin!")
                    .foregroundColor(.white)
                    .frame(width: 250, height: 80, alignment: .center)
                    .background(.indigo)
                    .cornerRadius(15)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 4)
                    })
            }
            Spacer()
            Spacer()
        } .padding(20)
    }
}

struct OnboardingPage3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage3(onboarding: .constant(true))
    }
}
