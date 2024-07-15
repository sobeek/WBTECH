//
//  PinCodeView.swift
//  PinCode
//
//  Created by Pavel Sobyanin on 01.07.2024.
//

import SwiftUI

struct Show: ViewModifier {
    let isVisible: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}

struct PinCodeView: View {
    
    private let truePinCode: String = "1234"
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 60
    
    
    @State private var pin: String = ""
    private let maxCount: Int = 4
    
    @State private var first: String = ""
    @State private var second: String = ""
    @State private var third: String = ""
    @State private var fourth: String = ""
    
    @State private var isNotFilled: Bool = true
    @State private var didTapAuthButton: Bool = false
    @State private var shouldToShowUncorrectPinText: Bool = false
    
    var body: some View {
        labels
        ModifiedContent(content: incorrectPin, modifier: Show(isVisible: shouldToShowUncorrectPinText))
        Text("Запросить повторно через \(timeRemaining) сек")
            .padding()
            .foregroundStyle(.white)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
        button
    }
    
    private var incorrectPin: some View {
        Text("Неверный пароль")
            .foregroundStyle(.red)
    }
    
    private var button: some View {
        Button {
            didTapAuthButton = true
            if pin == truePinCode {
                timer.upstream.connect().cancel()
            } else {
                shouldToShowUncorrectPinText = true
            }
        } label: {
            Text("Authorize")
                .frame(width: 352, height: 48, alignment: .center)
        }
        .disabled(isNotFilled)
        .foregroundStyle(.white)
        .background(buttonColor)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    private var buttonColor: Color {
        isNotFilled ? .purple.opacity(0.5) : .purple
    }
    
    private var backgroundField: some View {
        TextField("", text: $pin)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .keyboardType(.numberPad)
            .onChange(of: pin) { _ in
                pin = String(pin.prefix(maxCount))
                didTapAuthButton = false
                shouldToShowUncorrectPinText = false
                submitPin()
            }
    }
    
    private var labels: some View {
        ZStack {
            HStack(alignment: .center, spacing: 24) {
                label1
                label2
                label3
                label4
            }
            backgroundField
        }
    }
    
    private var label1: some View {
        generate(with: $first)
    }
    
    private var label2: some View {
        generate(with: $second)
    }
    
    private var label3: some View {
        generate(with: $third)
    }
    
    private var label4: some View {
        generate(with: $fourth)
    }
    
    private func generate(with str: Binding<String>) -> some View {
        return Text(str.wrappedValue)
            .frame(width: 64, height: 80, alignment: .center)
            .background(.white.opacity(0.08))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 12))
            .disabled(true)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            )
        
    }
    
    private var borderColor: Color {
        if isNotFilled || !didTapAuthButton {
            return .clear
        }
        
        return truePinCode == pin ? .green : .red
    }
    
    private func submitPin() {
        isNotFilled = pin.count != maxCount
        let values = Array(pin).map { String($0) }
        $first.wrappedValue = values.first ?? ""
        let values1 = values.dropFirst()
        $second.wrappedValue = values1.first ?? ""
        let values2 = values1.dropFirst()
        $third.wrappedValue = values2.first ?? ""
        let values3 = values2.dropFirst()
        $fourth.wrappedValue = values3.first ?? ""
    }
}
