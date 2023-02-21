//
//  AspectVGrid.swift
//  Set
//
//  Created by Hamish Young on 9/2/2023.
//

import Foundation
import SwiftUI

struct DynamicVGrid<T> where T: Identifiable, T: View {
    
    var items: [T]
    
    init(items: [T]) {
        self.items = items
    }
    
    var body: some View {
        
        LazyVGrid(columns: [adaptiveGridItem(width: 100)]){
            ForEach(items) { item in
                item
            }
        }
        
    }
}
    
    
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if  CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
