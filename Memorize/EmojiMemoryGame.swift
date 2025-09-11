//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tareq Aldhaifani on 11/09/2025.
//

import SwiftUI

struct CardTheme {
    let name: String
    let emojis: [String]
}

class EmojiMemoryGame: ObservableObject {
    private static let emojisAnimals = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵"]
    private static let emojisFruits = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍒","🍑","🥭","🍍","🥥","🥝"]
    private static let emojisSpace  = ["🌍","🪐","☀️","🌑","🌒","🌓","🌕","🌙","⭐","💫","☄️","🚀","🛰️","🛸"]

    let cardThemes: [CardTheme] = [
        CardTheme(name: "Animals 🐾", emojis: emojisAnimals),
        CardTheme(name: "Fruit 🍎", emojis: emojisFruits),
        CardTheme(name: "Space 🚀",  emojis: emojisSpace)
    ]

    @Published private var selectedEmojis: [String] = EmojiMemoryGame.emojisAnimals
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(with: EmojiMemoryGame.emojisAnimals)

    private static func createMemoryGame(with emojis: [String]) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }

    func switchTheme(_ index: Int) {
        selectedEmojis = cardThemes[index].emojis
        model = EmojiMemoryGame.createMemoryGame(with: selectedEmojis)
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
