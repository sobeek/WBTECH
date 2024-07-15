//
//  ContentView.swift
//  PinCode
//
//  Created by Pavel Sobyanin on 01.07.2024.
//

import SwiftUI

struct PincodeScreen: View {
    private let color1 = Color(red: 29/255, green: 6/255, blue: 40/255, opacity: 0.94)
    private let color2 = Color(red: 15/255, green: 10/255, blue: 35/255, opacity: 0.49)
    
    let phoneNumber: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(
                    colors: [
                        color1,
                        color2,
                    ]
                ))
                .ignoresSafeArea()
            VStack {
                Image("mail")
                Text(phoneNumber)
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 30, trailing: 0))
                    .foregroundStyle(.white)
                PinCodeView()
            }
        }
    }
}

#Preview {
    PincodeScreen(phoneNumber: "")
}
