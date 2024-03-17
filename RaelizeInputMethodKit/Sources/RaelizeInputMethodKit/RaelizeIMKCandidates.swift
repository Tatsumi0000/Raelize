//
//  RaelizeIMKCandidates.swift
//
//  Created by Tatsumi0000 on 2024/03/17
//
//

import Foundation
import InputMethodKit

@objc(RaelizeIMKCandidates)
public class RaelizeIMKCandidates : IMKCandidates {
//    
//    public override init!(server: IMKServer!, panelType: IMKCandidatePanelType, styleType style: IMKStyleType) {
//        super.init(server: server, panelType: panelType, styleType: style)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public override func candidates(_ sender: Any!) -> [Any]! {
        return ["TEST0", "TEST1", "TEST2"]
    }
    
}
