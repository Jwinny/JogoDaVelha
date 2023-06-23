//
//  GameBoardView.swift
//  JogoDaVelha
//
//  Created by José Winny on 22/06/23.
//

import SwiftUI

struct GameBoardView: View {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameDisable = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.9)
            LazyVGrid(columns: columns) {
                ForEach(0..<9){ index in
                    ZStack{
                        Circle()
                            .foregroundColor(Color.brown).opacity(0.4)
                        Image(systemName: moves[index]?.indicator ?? "")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        if isOcuppied(in: moves, forIndex: index) { return }
                        moves[index] = Move(player: .human, boardIndex: index)
                        isGameDisable = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            let computerPosition = computerMove(in: moves)
                            moves[computerPosition] = Move(player: .computer, boardIndex: index)
                            isGameDisable.toggle()
                        }
                    }
                }
            }
            .padding()
            .disabled(isGameDisable)
        }
    }
    func isOcuppied(in moves : [Move?], forIndex index: Int) -> Bool {
        return moves[index] != nil
    }
    func computerMove(in moves : [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        while isOcuppied(in: moves, forIndex: movePosition){
             movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
