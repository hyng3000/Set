//
//  AsCard.swift
//  Set
//
//  Created by Hamish Young on 9/2/2023.
//

import Foundation
import SwiftUI

struct AsSetCard: ViewModifier {

    let color: Color
    func body(content: Content) -> some View {
        drawCard(content: content, borderColor: color )
    }
}


/**
 Constants.
 */
private struct AsCardDrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let contentScale: CGFloat  = 0.65
}

/**
 Create a face up view of card.
 */
@ViewBuilder
func drawCard(content: some View, borderColor: Color) -> some View {
    
    GeometryReader { geometry in
        
        let shape = RoundedRectangle(cornerRadius: AsCardDrawingConstants.cornerRadius)
        
        ZStack {
            shape.fill().foregroundColor(Color.white)
            shape.strokeBorder(lineWidth: AsCardDrawingConstants.lineWidth)
            ForEach(Range(1...3)) { _ in
                content
            }
            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.2)
        }
        .foregroundColor(borderColor)
    }
}



/**
 Determines the correct size for content inside the card.
 -> Takes the minimum of height or width from given Size(best calculated with GeometryReader())
 -> then multiplies it by the AsCardDrawingConstants.contentScale
 */
private func contentSize(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * AsCardDrawingConstants.contentScale)
}

/**
 Make AsCard struct accessable via dot notation directly -> ".AsCard()" -> As opposed to '".modifier(AsCard())."
 */
extension View {
    func asSetCard(color: Color) -> some View {
        return self.modifier(AsSetCard(color: color))
    }
    
}

