//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Tareq Aldhaifani on 10/09/2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
