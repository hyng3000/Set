//
//  GameTheme.swift
//  Set
//
//  Created by Hamish Young on 12/2/2023.
//

import Foundation

/*
Protocol with bare requirements for playable card
 */
protocol IsCard: Equatable, Hashable, Identifiable {
    var id: Int { get }
    var isMatched: Bool { get set }
}


/*
Model for a UI independent playable Card
*/

struct SetCard {

lazy private(set) var allCards: Array<Card> = makeAllUniqueCards()


/*
Helper Methods
*/
    
private func makeContent(colors: Card.Colors, shapes: Card.Shapes, fills: Card.Fills, number: Int, id: Int) -> Card {
    return Card(color: colors, shape: shapes, fill: fills, number: number, id: id)
}

/*
Methods
*/
private func makeAllUniqueCards() -> Array<Card> {
    var cardId = -1
    return Card.Colors.allCases.flatMap { color in
        Card.Shapes.allCases.flatMap { shape in
            Card.Fills.allCases.flatMap { fill in
                Card.numberRange.map { number in
                    cardId += 1
                    return makeContent(colors: color, shapes: shape, fills: fill, number: number, id: cardId)
                }
            }
        }
    }
}

    /*
     Data Structures
     */
    
    struct Card: IsCard {
        
        let id: Int
        let color: Colors
        let shape: Shapes
        let fill: Fills
        let number: Int
        var isMatched = false
        
        init(color: Colors, shape: Shapes, fill: Fills, number: Int, id: Int) {
            
            self.id = id
            self.color = color
            self.shape = shape
            self.fill = fill
            self.number = number
        }
        
    enum Colors: CaseIterable, Equatable {
        case red
        case green
        case blue
    }
    
    enum Shapes: CaseIterable, Equatable {
        case pill
        case squiggle
        case diamond
    }
    
    enum Fills: CaseIterable, Equatable {
        case filled
        case bordered
        case textured
    }
    
    static let numberRange = 1..<4
        
    /*
    Card Methods
    */
    
    static func allSameOrAllDifferent(cards: Card...) -> Bool{
        
        var colors: Bool = false
        var shapes: Bool = false
        var fills: Bool = false
        var numbers: Bool = false
        
        let color = cards.map { $0.color }
        if allSame(color) || allDifferent(color) {
            colors = true
        }
        let shape = cards.map { $0.shape }
        if allSame(shape) || allDifferent(shape) {
            shapes = true
        }
        let fill = cards.map { $0.fill }
        if allSame(fill) || allDifferent(fill) {
            fills = true
        }
        let number = cards.map { $0.number }
        if allSame(number) || allDifferent(number) {
            numbers = true
        }
        
        return colors == true && shapes == true && fills == true && numbers == true
        
    }
    
    /*
     Card Helper Methods
     */
    
    private static func allSame<type>(_ content: Array<type>) -> Bool where type: Equatable{
        return content.allSatisfy { $0 == content.first }
    }
    
    private static func allDifferent<type>(_ content: Array<type>) -> Bool where type: Equatable, type: Hashable{
        return Set(content).count == content.count
    }

        
        
    }
    
    
}
