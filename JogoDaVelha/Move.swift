//
//  Move.swift
//  JogoDaVelha
//
//  Created by José Winny on 22/06/23.
//

import Foundation

struct Move{
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
