//
//  KeyEvent.swift
//
//  Created by Tatsumi0000 on 2024/04/11
//
//

import Foundation

/// Use NSEvent.KeyCode for clarity enum.
/// NSEvent.keyCode ->  clarity keyevent name
/// keyCode List https://boredzo.org/blog/archives/2007-05-22/virtual-key-codes
/// https://stackoverflow.com/questions/2080312/where-can-i-find-a-list-of-key-codes-for-use-with-cocoas-nsevent-class
public struct KeyEvent {

    /// NSEvent.keyCode
    private let keyCode: Int

    public init(keyCode: Int) {
        self.keyCode = keyCode
    }

    /// NSEvent.keyCode's name
    public enum CodeConverter: Int {
        case enter = 36
        case backspace = 51
        case upArrow = 126
        case downArrow = 125
        case tab = 48
        case undifined = -1
    }

    /// keyCode -> key name
    public var eventName: CodeConverter {
        return CodeConverter(rawValue: keyCode) ?? .undifined
    }
}
