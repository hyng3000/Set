//
//  CardView.swift
//  Set
//
//  Created by Hamish Young on 21/2/2023.
//

import SwiftUI

struct AsCard: Animatable, ViewModifier  {

    init(repitions: Int, isSelected: Bool, isMatched: Bool) {
        self.repitions = repitions
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.rotation = isMatched ? 180 : 0
    }

    let repitions: Int
    var isSelected: Bool
    var isMatched: Bool
    let borderColor = Color.black
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)

        if isSelected {
            card(
                shape: shape,
                width: DrawingConstants.cardWidthMultiplier,
                height: DrawingConstants.cardHeightMultiplier,
                repititions: repitions,
                symbol: content,
                geometry: geometry,
                borderColor: borderColor,
                rotation: rotation
            )
            .overlay(
            RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
            .stroke(lineWidth: 6)
            )

     }  else {
         ZStack {
                card(
                    shape: shape,
                    width: DrawingConstants.cardWidthMultiplier,
                    height: DrawingConstants.cardHeightMultiplier,
                    repititions: repitions,
                    symbol: content,
                    geometry: geometry,
                    borderColor: borderColor,
                    rotation: rotation
                )
                }
            }
        }
    }
}

    

@ViewBuilder
func card<symbolView>(
    shape: RoundedRectangle,
    width: CGFloat,
    height: CGFloat,
    repititions: Int,
    symbol: symbolView,
    geometry: GeometryProxy,
    borderColor: Color,
    rotation: Double) -> some View where symbolView: View {

    ZStack {
            
            shape.fill().foregroundColor(rotation < 90 ? .white : .green)
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            
            
            VStack(spacing: 10) {
                ForEach(Range(1...repititions), id: \.self) { _ in
                    symbol
                }
                .opacity(rotation < 90 ? 1 : 0)
                .padding(DrawingConstants.cardSymbolPadding)
                .frame(
                    width: geometry.size.width * DrawingConstants.cardWidthMultiplier,
                    height: geometry.size.height * DrawingConstants.cardHeightMultiplier
                    )
                }
            }
                .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
                .foregroundColor(borderColor)
    }

private struct DrawingConstants {
    
    static let cardWidthMultiplier: CGFloat = 0.5
    static let cardHeightMultiplier: CGFloat = 0.2
    static let cardCornerRadius: CGFloat = 15
    static let cardSymbolPadding: CGFloat = 5
    
    static let lineWidth: CGFloat = 3
    static let fontSize: CGFloat = 40
}

extension View {
    func asCard(repititions: Int, isSelected: Bool, isMatched: Bool ) -> some View {
        self.modifier(AsCard(repitions: repititions, isSelected: isSelected, isMatched: isMatched))
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
