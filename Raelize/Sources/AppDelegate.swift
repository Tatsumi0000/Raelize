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
  var candidatesWindow = IMKCandidates()

  func applicationDidFinishLaunching(_ notification: Notification) {
    server = IMKServer(
      name: Bundle.main.infoDictionary?["InputMethodConnectionName"] as? String,
      bundleIdentifier: Bundle.main.bundleIdentifier)
    candidatesWindow = RaelizeIMKCandidates(
      server: server, panelType: kIMKSingleColumnScrollingCandidatePanel, styleType: kIMKMain)
    print("setup-print")
    NSLog("setup-nslog")
  }
}
