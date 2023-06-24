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
    @State private var playerPoint = 0
    @State private var computerPoint = 0
    @State private var showAlert: Bool = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.9)
            VStack {
                
                HStack {
                    Image(systemName: "person.fill")
                    Text("\(playerPoint) - \(computerPoint)")
                        .padding(.horizontal)
                        .padding(.vertical,5)
                        .border(Color.brown, width: 4)
                    Image(systemName: "laptopcomputer")
                }
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.bottom,30)
                
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
                            
                            if checkWinCondition(for: .human, in: moves){
                                showAlert.toggle()
                                return
                            }
                            
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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("You Win"),
                          dismissButton: .default(Text("Ok")){
                        resetGameBoard()
                    })
                }
            }
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
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            playerPoint += 1
            return true
        }
        
        return false
    }
    func resetGameBoard(){
        moves = Array(repeating: nil, count: 9)
        isGameDisable = false
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
