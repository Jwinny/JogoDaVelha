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
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.9)
            LazyVGrid(columns: columns) {
                ForEach(0..<9){ i in
                    ZStack{
                        Circle()
                            .foregroundColor(Color.brown).opacity(0.4)
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
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
