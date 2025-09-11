//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Tareq Aldhaifani on 10/09/2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var selectedThemeIndex = 0
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            ScrollView {
                cards
                    .animation(.snappy, value: viewModel.cards)
            }
            HStack {
                Picker("Select a theme", selection: $selectedThemeIndex) {
                    ForEach(0..<viewModel.cardThemes.count, id: \.self) { index in
                        Text(viewModel.cardThemes[index].name).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 16)
                .padding(.top, 8)
                Spacer()
                Button(action: {
                    viewModel.shuffle()
                }, label: {
                    Image(systemName: "rectangle.2.swap")
                })
                .imageScale(.large)
                .font(.title3)
            }
            .padding([.leading, .trailing])
        }
        .padding([.leading, .trailing])
        .padding([.bottom, .top], 0)
        .onAppear() {
            viewModel.shuffle()
        }
        .onChange(of: selectedThemeIndex) { oldIndex, newIndex in
            viewModel.switchTheme(newIndex)
        }
    }

    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
            spacing: 0
        ) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.getThemeColor(selectedThemeIndex))
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
