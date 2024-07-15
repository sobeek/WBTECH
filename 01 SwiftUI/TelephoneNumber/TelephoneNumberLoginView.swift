//
//  TelephoneNumberLoginView.swift
//  PinCode
//
//  Created by Pavel Sobyanin on 09.07.2024.
//

import SwiftUI

struct TelephoneNumberLoginView: View {
    
    private let mask = "+7 (___) ___ - __ - __"
    @State private var currentNumber: String = ""
    @State private var pureNumber: String = ""
    
    @State private var isNotFilled: Bool = true
    
    private let color1 = Color(red: 29/255, green: 6/255, blue: 40/255, opacity: 0.94)
    private let color2 = Color(red: 15/255, green: 10/255, blue: 35/255, opacity: 0.49)
    
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
            VStack(spacing: 24) {
                Text("Авторизация")
                    .foregroundStyle(.white)
                    .font(.system(size: 24).bold())
                    .padding(.bottom)
                Image("profile")
                Text("Вход по номеру телефона")
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .padding(.bottom, 8)
                ZStack {
                    numberText
                    numberTextField
                }
                button
                
            }
        }
    }
    
    private var numberTextField: some View {
        TextField(mask, text: $pureNumber)
            .keyboardType(.numberPad)
            .padding(.horizontal, 24)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .onAppear(perform: {
                UITextField.appearance().clearButtonMode = .whileEditing
            })
            .onChange(of: pureNumber) { value in
                pureNumber = String(pureNumber.prefix(10))
                currentNumber = formatPhoneNumber(str: value)
                isNotFilled = pureNumber.count != 10
            }
    }
    
    private var numberText: some View {
        Text($currentNumber.wrappedValue)
            .frame(width: 352, height: 48, alignment: .leading)
            .background(.white.opacity(0.08))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 12))
    }
    
    private var button: some View {
        Button {} label: {
            NavigationLink(destination: PincodeScreen(phoneNumber: currentNumber)) {
                Text("Authorize")
                    .frame(width: 352, height: 48, alignment: .center)
            }
            
        }
        .disabled(isNotFilled)
        .foregroundStyle(.white)
        .background(buttonColor)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    private var buttonColor: Color {
        isNotFilled ? .purple.opacity(0.5) : .purple
    }
    
    func formatPhoneNumber(str: String) -> String {
        if str.isEmpty { return "" }
        let cleanNumber = str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(___) ___-__-__"
        
        var result = "+7 "
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "_" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
