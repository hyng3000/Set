//
//  ContentView.swift
//  Set
//
//  Created by Hamish Young on 9/2/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SetViewModel
    @State private var dealtCards = Set<Int>()
    @State private var discardedCards = Set<Int>()

    @Namespace private var dealingNameSpace
    
    var body: some View {

        VStack {
            HStack {
                scoreboard
                Spacer()
                newGameButton
            }
            
            gameBody
                
            HStack {
                Spacer()
                deckBody
                Spacer()
            }
            .frame(height: Constants.bottomHStackHeight)
            }
        }
    }
    
    
extension ContentView {
           
    // UI Components
                   
    var gameBody: some View {
    
          DynamicVGrid(items: viewModel.getCardsInPlay()){ card in
            if isUndealt(card) {
                Color.clear
            } else {
                let symbol = viewModel.makeUISymbol(card: card)
                    symbol.asCard(
                        repititions: card.number,
                        isSelected: viewModel.isSelected(card),
                        isMatched: card.isMatched
                        )
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .padding(5)
                        .onTapGesture(perform: {viewModel.selectCard(card)}
                    )
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .animation(.easeInOut, value: card.isMatched)
                }
            }
        }
     
        

    var deckBody: some View {
        ZStack {
            ForEach(viewModel.getCardDeck().filter({card in isUndealt(card)})) { card in
                    viewModel.makeUISymbol(card: card).asCard(repititions: card.number, isSelected: viewModel.isSelected(card), isMatched: card.isMatched)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: Constants.undealtDeckWidth , height: Constants.undealtDeckHeight)
        .foregroundColor(Color.red)
        .onTapGesture {
            viewModel.increaseCardsInPlay()
            for card in viewModel.getCardsInPlay() {
                    deal(card)
                }
            }
        }
    

    var newGameButton: some View { HStack{
        Button(action: { viewModel.restartGame(); dealtCards = [] }, label: {
        Image(systemName: "arrow.clockwise.circle").font(.system(size: Constants.fontSize))})
        }
        .foregroundColor(Color.red)
        .padding(.horizontal)
    }
    
    var moreCardsButton: some View {
        Button(
            action: { viewModel.increaseCardsInPlay() },
            label: {
                Image(systemName: "plus.circle").font(.system(size: Constants.fontSize))
                }
            ).foregroundColor(Color.black)
             }
    
    var scoreboard: some View { Text(
        "\(String(viewModel.getScore()))")
            .font(
                .system(size: Constants.fontSize))
                    .padding(
                        .horizontal)
                        }
                        
    // Animation Helpers
    
    func deal(_ card: SetCard.Card) {
        withAnimation(dealAnimation(for: card)) {
                dealtCards.insert(card.id)
        }
    }
        
    func isUndealt(_ card: SetCard.Card) -> Bool {
        return !dealtCards.contains(card.id)
    }
    
    private func dealAnimation(for card: SetCard.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.getCardsInPlay().firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) / 15
        }
        return Animation.easeInOut(duration: Constants.dealDuration).delay(delay)
    }
        
    private func zIndex(of card: SetCard.Card) -> Double {
        -Double(viewModel.getCardsInPlay().firstIndex(where: {$0.id == card.id}) ?? 0)
    }

}


struct Constants {

    static let fontSize: CGFloat = 40
    static let bottomHStackHeight: CGFloat = 30
    
    static let aspectRatio: CGFloat = 2/3
    
    static let undealtDeckHeight: CGFloat = 90
    static let undealtDeckWidth: CGFloat = undealtDeckHeight * aspectRatio
    
    
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentView.SetViewModel()
        ContentView(viewModel: viewModel)
    }
}
                 
