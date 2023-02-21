//
//  ContentView2.swift
//  Set
//
//  Created by Hamish Young on 15/2/2023.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        
        
        DynamicVGrid(items: Array(viewModel.cards[0...19])) { card in
            Text(card.content.asCard(isFaceUp: card.isFaceUp, color: Color.red)
                .padding(3)
                .onTapGesture {
                    viewModel.selectCard(card)
            }
        }
        .padding()
    }
}
                 struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    let viewModel: ContentView.SetViewModContentView.SetViewModel()
                    ContentView(viewModel: viewModel)
                }
            }
