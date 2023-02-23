//
//  SetViewModel.swift
//  Set
//
//  Created by Hamish Young on 10/2/2023.
//

import Foundation
import SwiftUI

extension ContentView {
    
    @MainActor class SetViewModel: ObservableObject {
        
        @Published private var model: SetModel<SetCard.Card>
        private(set) var selectedCards: Set<SetCard.Card> = Set<SetCard.Card>()
        
        init() {
            var setCards = SetCard()
            self.model = SetModel<SetCard.Card>(cards: setCards.allCards, compareFunc: SetCard.Card.allSameOrAllDifferent)
            self.selectedCards = model.selectedCards
        }
        
        // MARK: Intent Functions
        
        func selectCard(_ card: SetCard.Card){
            print("Card: \(card.id)")
            model.selectCard(card)
        }
        
        func increaseCardsInPlay(){
            model.increaseCardsInPlay(by: 3)
        }
        
        func restartGame(){
            var setCards = SetCard()
            self.model = SetModel<SetCard.Card>(cards: setCards.allCards, compareFunc: SetCard.Card.allSameOrAllDifferent)
            self.selectedCards = model.selectedCards
        }
        
        // Other
        
        func getCardsInPlay() -> Array<SetCard.Card> {
            if model.numberOfCardsInPlay < model.cards.count {
                return Array(model.cards[0..<model.numberOfCardsInPlay])
            } else {
                return model.cards
            }
        }
        
        func getCardDeck() -> Array<SetCard.Card> {
            return model.cards
        }
        
        func getNumberOfCardsInPlay() -> Int {
            return model.numberOfCardsInPlay
        }
        
        func getCards() -> Array<SetCard.Card>{
            return model.cards
        }
        
        func getScore() -> Int{
            return model.score
        }
        
         func updateScore(){
            return model.increaseScore()
        }
        
        func checkSelectedCardsForMatch() -> Bool {
            model.isAMatch()
        }
        
        func isSelected(_ card: SetCard.Card) -> Bool{
            return model.selectedCards.contains(card)
        }
        
        
        
        @ViewBuilder
        func makeUISymbol(card: SetCard.Card) -> some View {
            makeSymbol(card)
        }
        
        @ViewBuilder
        private func makeSymbol(_ card: SetCard.Card) -> some View {
        switch card.shape {
            case .diamond:
               renderSymbol(shape: Diamond(), color: pickColor(card.color), fill: card.fill)
            case .pill:
                renderSymbol(shape: Capsule(), color: pickColor(card.color), fill: card.fill)
            case .squiggle:
                renderSymbol(shape: Squiggle(), color: pickColor(card.color), fill: card.fill)
                }
        }
        
        @ViewBuilder
        private func renderSymbol<shapeType>(shape: shapeType, color: Color, fill: SetCard.Card.Fills) -> some View where shapeType: Shape  {
        switch fill {
        case .filled:
            shape
            .foregroundColor(color)
        case .bordered:
            shape
            .stroke(lineWidth: 3)
            .foregroundColor(color)
        case .textured:
            shape.stripify(color: color)
        }
    }

        
        private func pickColor(_ color: SetCard.Card.Colors) -> Color{
            switch color {
                case .red:
                    return Color.red
                case .green:
                    return Color.green
                case .blue:
                    return Color.blue
                }
        }
         
    }

}
