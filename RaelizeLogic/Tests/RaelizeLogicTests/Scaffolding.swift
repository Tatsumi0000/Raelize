//
//  Scaffolding.swift
//
//  Created by Tatsumi0000 on 2024/03/27
//  
//

import XCTest
import Testing

/// [Swift 5.10](https://swiftpackageindex.com/apple/swift-testing/0.6.0/documentation/testing/temporarygettingstarted#Swift-510)
final class AllTests: XCTestCase {
  func testAll() async {
    await XCTestScaffold.runAllTests(hostedBy: self)
  }
}

