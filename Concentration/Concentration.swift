//
//  Concentration.swift
//  Concentration
//
//  Created by Adrian on 2017/12/09.
//  Copyright © 2017 Adrian. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private(set) var seenCardsIndices = Set<Int>()
    
    private var indexOfOneAndOnlyUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched, !cards[index].isFaceUp {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyUpCard, index != matchIndex {
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 3
                } else {
                    if seenCardsIndices.contains(index) {
                        score -= 1
                    }
                    if seenCardsIndices.contains(matchIndex) {
                        score -= 1
                    }
                    seenCardsIndices.insert(index)
                    seenCardsIndices.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "init(numberOfPairsOfCards: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        for index in cards.indices {
            let randomCardIndex = cards.count.arc4random
            cards.swapAt(index, randomCardIndex)
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
