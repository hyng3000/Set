//
//  Stripey.swift
//  Set
//
//  Created by Hamish Young on 16/2/2023.
//

import SwiftUI

struct Stripey<ShapeType: Shape>: View {
    let shape: ShapeType
    let numberOfStripes: Int
    let stripeWidth: CGFloat
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let stripeWidthInPoints = stripeWidth * geometry.size.width / CGFloat(numberOfStripes)
            let stripeSize = CGSize(width: stripeWidthInPoints, height: geometry.size.height)
            
            HStack(spacing: 0) {
                Spacer()
                ForEach(0..<numberOfStripes) { index in
                    Rectangle()
                        .fill(index % 2 == 0 ? color : .white)
                        .frame(width: stripeSize.width, height: stripeSize.height, alignment: .center)
                }
                Spacer()
            }
            .mask(shape)
            .overlay(shape.stroke(color, lineWidth: stripeWidthInPoints))
            
        }
    }
}
    

extension Shape {
    func stripify(numberOfStripe: Int = 10, widthOfStripe: CGFloat = 0.5, color: Color) -> some View {
        Stripey(shape: self, numberOfStripes: numberOfStripe, stripeWidth: CGFloat(Float(widthOfStripe)), color: color)
    }
}


struct Stripey_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
        ForEach(Range(1...3)) { _ in
        Diamond().stripify(color: Color.red).foregroundColor(Color.green)
        }
        }
    }
}
