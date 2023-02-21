//
//  Model.swift
//  Set
//
//  Created by Hamish Young on 10/2/2023.
//

import Foundation

/*
Model for Set 
 */

struct SetModel<Card> where Card: IsCard {

    private(set) var cards: Array<Card> = [Card]()
    private(set) var compareThreeCards: (Card...) -> Bool
    private(set) var selectedCards: Set<Card>
    private(set) var removedCards: Set<Card>
    private(set) var score = 0
    private(set) var numberOfCardsInPlay = 12
    
    private var match = false
    private let maxSelectable = 3
    
    

    init(cards: Array<Card>, compareFunc: @escaping (Card...) -> Bool) {
        self.cards = cards.shuffled()
        self.compareThreeCards = compareFunc
        self.selectedCards = Set<Card>()
        self.removedCards = Set<Card>()
        }
    
    mutating func selectCard(_ card: Card){
    
        if selectedCards.count == 3 {
            if match == true {
                match = false
                removeSelectedCardsFromPlay()
                numberOfCardsInPlay -= selectedCards.count
        }
            deSelectAllCards()
        }
    
        if selectedCards.contains(card) {
            selectedCards.remove(card)
            
        } else if selectedCards.count < maxSelectable {
            selectedCards.insert(card)
            
            if maxCardsSelected() {
                if isAMatch() {
                    score += 10
                    updateIsMatched()
                    match = true
                }
            }
        }
    }
    
    
    mutating func increaseCardsInPlay(by amount: Int){
        numberOfCardsInPlay += amount
    }
    
    mutating func updateIsMatched() {
        for card in selectedCards {
             if let selected = cards.firstIndex(where: { $0.id == card.id }) {
                cards[selected].isMatched = true
            }
        }
    }
    
    mutating func removeSelectedCardsFromPlay() {
        for card in selectedCards {
            if let selected = cards.firstIndex(where: { $0.id == card.id }) {
                cards.remove(at: selected)
            }
        }
    }
    
    mutating func increaseScore(){
        score += 10
    }
    
    mutating func deSelectAllCards(){
        selectedCards = Set<Card>()
    }
    
    func maxCardsSelected() -> Bool {
        return selectedCards.count == maxSelectable
    }
    
    func isAMatch() -> Bool {
        let cardsArray = Array(selectedCards)
        return compareThreeCards(cardsArray[0], cardsArray[1], cardsArray[2])
    }
        
}




