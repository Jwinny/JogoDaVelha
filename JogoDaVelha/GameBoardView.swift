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
    @State private var isHumanTurn : Bool = true
    
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
                        if moves[index]?.indicator == nil{
                            moves[index] = Move(player: isHumanTurn ? .human : .computer, boardIndex: index)
                            isHumanTurn.toggle()
                        }
                        else{
                            
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
