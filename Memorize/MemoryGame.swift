//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tareq Aldhaifani on 11/09/2025.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairsIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairsIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
