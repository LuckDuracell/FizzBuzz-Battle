//
//  OnboardingPage1.swift
//  FizzBuzz
//
//  Created by Luke Drushell on 5/30/22.
//

import SwiftUI

struct OnboardingPage1: View {
    
    var device = deviceScreen()
    @State private var animation1 = pos(x: CGFloat(deviceScreen().width) / 2, y: CGFloat(deviceScreen().height) / 25)
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Fizzbuzz")
                .bold()
                .font(.largeTitle)
            Text("Lets go over the rules")
                .bold()
                .font(.title)
            Spacer()
            Image(systemName: "arrow.right.circle")
                .resizable()
                .scaledToFit()
                .frame(width: device.width * 0.4, height: device.width * 0.4, alignment: .center)
            Spacer()
            Spacer()
        } .padding(.vertical, 50)
    }
}

struct OnboardingPage1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage1()
    }
}
