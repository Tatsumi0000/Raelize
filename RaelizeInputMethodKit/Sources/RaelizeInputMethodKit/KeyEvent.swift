//
//  KeyEvent.swift
//
//  Created by Tatsumi0000 on 2024/04/11
//
//

import Foundation

/// NSEvent.keyCode -> Custom Event
/// keyCode List https://boredzo.org/blog/archives/2007-05-22/virtual-key-codes
public struct KeyEvent {

    /// NSEvent.keyCode
    public let keyCode: Int

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
