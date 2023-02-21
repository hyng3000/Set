//
//  ContentShape.swift
//  Set
//
//  Created by Hamish Young on 16/2/2023.
//

import Foundation
import SwiftUI

enum Fill: Equatable {
    case filled
    case textured
    case outlined
}

protocol ContentShape: View {
    var color: Color {get}
    var fill: Fill {get}
    var number: Int {get}

}


struct cardContent: ContentShape {

    let shape: any Shape
    let fill: Fill
    let number: Int
    let color: Color

    
    var body: some View {
    GeometryReader { geometry in
    
        let height: Double = determineHeight(geometry.size.height)
        let width: Double = determineWidth(geometry.size.width)
    
        VStack(alignment: .center){
            ForEach(1...Int(number), id: \.self) {_ in
                shape().stroke(lineWidth: 2)
                }
            }
            .foregroundColor(color)
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center
            )
        }
    }
    
}


struct Textured: ViewModifier {

        let fill: Fill

    func body(content: Content) -> some View {
        
    }
}
//
//extension View {
//    func texture(fill: Fill) -> some View {
//        return self.modifier(Textured(fill: fill))
//    }
//
//}




struct Pill_Previews: PreviewProvider {
    static var previews: some View {
        Pill(fill: Fill.outlined, number: 3, color: Color.blue, Capsule(){}.frame(width: width, height: height, alignment: Alignment.center)
                    .padding(5))
    }
}

