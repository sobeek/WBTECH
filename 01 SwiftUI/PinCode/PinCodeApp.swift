//
//  PinCodeApp.swift
//  PinCode
//
//  Created by Pavel Sobyanin on 01.07.2024.
//

import SwiftUI

@main
struct PinCodeApp: App {
    var body: some Scene {
        WindowGroup {
            PincodeScreen(phoneNumber: "+7(012)345-67-89")
        }
    }
}
