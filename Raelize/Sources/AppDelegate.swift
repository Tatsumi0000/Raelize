//
//  AppDelegate.swift
//
//  Created by Tatsumi0000 on 2024/03/17
//
//

import AppKit
import Foundation
import InputMethodKit
import RaelizeInputMethodKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var server = IMKServer()

    func applicationDidFinishLaunching(_ notification: Notification) {
        server = IMKServer(
            name: Bundle.main.infoDictionary?["InputMethodConnectionName"] as? String,
            bundleIdentifier: Bundle.main.bundleIdentifier)
        NSLog("setup")
    }
}
