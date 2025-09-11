//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Tareq Aldhaifani on 10/09/2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    static let animalCards = ["🐶", "🐶", "🐱", "🐱", "🐻", "🐻", "🦊", "🦊", "🐼", "🐼", "🐸", "🐸"]
    static let fruitCards = ["🍎", "🍎", "🍌", "🍌", "🍇", "🍇", "🍓", "🍓", "🍒", "🍒", "🍍", "🍍"]
    static let spaceCards = ["🚀", "🚀", "🛸", "🛸", "🌌", "🌌", "🪐", "🪐", "🌙", "🌙", "☄️", "☄️"]

    let cardThemes: [CardTheme] = [
        CardTheme(name: "Animals 🐾", cards: EmojiMemoryGameView.animalCards, colorTheme: .orange),
        CardTheme(name: "Fruits 🍎", cards: EmojiMemoryGameView.fruitCards, colorTheme: .red),
        CardTheme(name: "Space 🚀", cards: EmojiMemoryGameView.spaceCards, colorTheme: .indigo)
    ]

    @State private var selectedThemeIndex = 0
    @State private var shuffledCards: [String] = []
    @State private var cardsColor: Color = .orange

    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)

            ScrollView {
                cards
            }

            Picker("Select a theme", selection: $selectedThemeIndex) {
                ForEach(0..<cardThemes.count, id: \.self) { index in
                    Text(cardThemes[index].name).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .padding([.leading, .trailing])
        .onAppear {
            shuffledCards = cardThemes[selectedThemeIndex].cards.shuffled()
        }
        .onChange(of: selectedThemeIndex) { oldValue, newValue in
            shuffledCards = cardThemes[newValue].cards.shuffled()
            cardsColor = cardThemes[newValue].colorTheme
        }
    }

    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 90), spacing: 8)],
            spacing: 8
        ) {
            ForEach(0..<shuffledCards.count, id: \.self) { index in
                CardView(content: shuffledCards[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundColor(cardsColor)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct CardTheme {
    let name: String
    let cards: [String]
    let colorTheme: Color
}

#Preview {
    EmojiMemoryGameView()
}
