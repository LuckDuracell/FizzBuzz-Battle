//
//  OnboardingSheetView.swift
//  FizzBuzz
//
//  Created by Luke Drushell on 5/30/22.
//

import SwiftUI

struct OnboardingSheetView: View {
    
    @Binding var onboarding: Bool
    
    var body: some View {
        TabView(content: {
            OnboardingPage1()
            OnboardingPage2()
            OnboardingPage3(onboarding: $onboarding)
        }) .tabViewStyle(.page)
    }
}

struct OnboardingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSheetView(onboarding: .constant(true))
    }
}

struct pos {
    var x: CGFloat
    var y: CGFloat
}
