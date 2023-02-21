//
//  DynamicVGrid.swift
//  Set
//
//  Created by Hamish Young on 10/2/2023.
//

/*
Creates a self sizing LazyVGrid.
*/

import Foundation
import SwiftUI

struct DynamicVGrid<Item, ItemInView>: View where Item: Identifiable, Item: Hashable, ItemInView: View {

    var items: [Item]
    let content: (Item) -> ItemInView
    let itemAspectRatio: CGFloat
    
    init(items: [Item], itemAspectRatio: CGFloat = 2/3, @ViewBuilder content: @escaping (Item) -> ItemInView) {
        self.items = items
        self.content = content
        self.itemAspectRatio = itemAspectRatio
    }
    
    var body: some View {
        GeometryReader { geometry in
        ScrollView {
                VStack {
                    let itemWidth = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: itemAspectRatio)
                    LazyVGrid(columns: [adaptiveGridItem(width: itemWidth)], spacing: 0){
                        ForEach(items) { item in
                            content(item).aspectRatio(itemAspectRatio, contentMode: .fit)
                        }
                    }
                    Spacer(minLength: 0)
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
        let result = floor(size.width / CGFloat(columnCount))
    
        return max(result, 100)
        }
        
        }
