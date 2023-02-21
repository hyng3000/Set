//
//  ContentView.swift
//  Set
//
//  Created by Hamish Young on 9/2/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
    
    
        // UI Components
        let newGameButton = HStack{
            VStack {
                Text("New")
                Text("Game")
                }
            Button(action: { viewModel.restartGame() }, label: {
            Image(systemName: "x.circle").font(.system(size: Constants.fontSize))})
        }
        .foregroundColor(Color.red)
        .padding(.horizontal)
        
        let moreCardsButton = Button(
            action: { viewModel.increaseCardsInPlay() },
            label: {
                Image(systemName: "plus.circle").font(.system(size: Constants.fontSize))
                }
            ).foregroundColor(Color.black)
             
        let scoreboard = Text(
        "\(String(viewModel.getScore()))")
            .font(
                .system(size: Constants.fontSize))
                    .padding(
                        .horizontal)

    
        // Screen

        VStack {
            HStack {
                scoreboard
                Spacer()
                newGameButton
            }
            DynamicVGrid(items: viewModel.getCardsInPlay()){ card in
                let symbol = viewModel.makeUISymbol(card: card)
                    symbol.asCard(
                        repititions: card.number,
                        isSelected: viewModel.isSelected(card),
                        isMatched: card.isMatched
                        )
                        .padding(5)
                        .onTapGesture(perform: {viewModel.selectCard(card)}
                    )
                }
            HStack {
                Spacer()
                moreCardsButton
                Spacer()
            }
            .frame(height: Constants.bottomHStackHeight)
            }
        }
    }

struct Constants {
    static let fontSize: CGFloat = 40
    static let bottomHStackHeight: CGFloat = 30
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentView.SetViewModel()
        ContentView(viewModel: viewModel)
    }
}
                 
