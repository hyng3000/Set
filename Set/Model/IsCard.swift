//
//  BehavesAsCard.swift
//  Set
//
//  Created by Hamish Young on 10/2/2023.
//

import Foundation

protocol IsCard: Identifiable, Equatable {
    associatedtype CardContentType
    
    var id: Int {get}
    var content: CardContentType {get}
    var isFaceUp: Bool {get set}
}

