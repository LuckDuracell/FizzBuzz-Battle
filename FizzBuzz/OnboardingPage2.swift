//
//  OnboardingPage2.swift
//  FizzBuzz
//
//  Created by Luke Drushell on 5/30/22.
//

import SwiftUI

struct OnboardingPage2: View {
    
    var device = deviceScreen()
    
    var body: some View {
        VStack {
            Spacer()
            Text("It's super simple, we promise.")
                .bold()
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text("You're gonna get 5 seconds for each turn, so that's what the countdown means.")
                .bold()
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.vertical, 25)
            Text("As for the game, you're just counting up; saying  1  2  3  4  5  like that! Except theres 3 important exceptions you need to know")
                .bold()
                .font(.headline)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                Image(systemName: "1.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                Text("Every time the number is divisible by 3 (3, 6, 9, 12, etc.), you say Fizz instead")
            } .frame(width: device.width * 0.9, alignment: .leading)
                .multilineTextAlignment(.leading)
            HStack {
                Image(systemName: "2.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
            Text("And every time the number is divisible by 5 (5, 10, 15, etc.), you say Buzz")
            } .frame(width: device.width * 0.9, alignment: .leading)
                .multilineTextAlignment(.leading)
            HStack {
                Image(systemName: "3.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
            Text("And finally, when it's divisible by 3 AND 5 (15, 30, etc.), you say FizzBuzz")
            } .frame(width: device.width * 0.9, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 50)
            Spacer()
        }
        .padding(20)
    }
}

struct OnboardingPage2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage2()
    }
}
